#!/usr/bin/env bash 
# Author: Rafal Masiarek
# inspired by Pawel Malinowski
#
# function `sort_version` stolen from asdf kubectl plugin
# where author stole this from rbenv
# https://imgur.com/a/DYL68S7


export __KUBECTLENV_HOMEDIR=$HOME/.kubectlenv

function __kubectlenv_utils_wget {
    wget "$@" -q --show-progress --progress=bar:force
}

# stolen from https://github.com/rbenv/ruby-build/pull/631/files#diff-fdcfb8a18714b33b07529b7d02b54f1dR942
function __kubectlenv_utils_sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

function __kubectlenv_utils_list_all_versions() {
  git ls-remote --tags --refs https://github.com/kubernetes/kubernetes.git |
    grep -o 'refs/tags/.*' |
      cut -d/ -f3- |
        grep -ivE '(^-src|-dev|-latest|-stm|[-\.]rc|-alpha|-beta|[-\.]pre|-next|(a|b|c)[0-9]+|snapshot|master)' |
          sed 's/^v//'
}

function __kubectlenv_utils_get_specific_version() {
  VERSION=$1
  __kubectlenv_utils_list_all_versions | __kubectlenv_utils_sort_versions | grep $VERSION |
    sed 's/^[[:space:]]\+//' | tail -1
}

function __kubectlenv_utils_get_latest_version() {
    LATEST_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt | cut -c 2- -)
    __kubectlenv_utils_get_specific_version $LATEST_VERSION
}

function __kubectlenv_print_help()
{
        echo -e "Easy managed kubectl multiple versions.\n\tExample: kubectlenv -v 1.27"
        return 99
}

function __kubectlenv_get_version()
{
    if [[ "$1" == "latest" ]]; then
        VERSION=$(__kubectlenv_utils_get_latest_version)
    else
        VERSION=$(__kubectlenv_utils_get_specific_version $1)
    fi

    if [[ -f "$__KUBECTLENV_HOMEDIR/$VERSION/kubectl" ]]; then
        return 0
    else
        case "$(uname -s)" in
            "Darwin") PLATFORM="darwin" ;;
            "Linux") PLATFORM="linux";;
            *) PLATFORM="unknown" ;;
        esac

        case "$(uname -m)" in
            "86_64"|"x86_64") ARCH="amd64" ;;
            "arm64"|"aarch64") ARCH="arm64";;
            *) ARCH="unknown" ;;
        esac

        echo "Trying to find and get kubectl $VERSION"
        echo "Download from https://dl.k8s.io/v$VERSION/kubernetes-client-$PLATFORM-$ARCH.tar.gz"
        if __kubectlenv_utils_wget "https://dl.k8s.io/v$VERSION/kubernetes-client-$PLATFORM-$ARCH.tar.gz" -P "/tmp"; then
            tmp_dir=$(mktemp -d /tmp/kubernetes-client-$VERSION-$PLATFORM-$ARCH.XXXX)

            tar zxf /tmp/kubernetes-client-$PLATFORM-$ARCH.tar.gz -C $tmp_dir
            mkdir -p $__KUBECTLENV_HOMEDIR/$VERSION
            install -m 0755 $tmp_dir/kubernetes/client/bin/kubectl $__KUBECTLENV_HOMEDIR/$VERSION/kubectl
            # cleanup
            rm -rf $tmp_dir /tmp/kubernetes-client-$PLATFORM-$ARCH.tar.gz
            return 0
        else
            echo "Wrong kubectl version"
            return 1
        fi
    fi
}

function __kubectlenv_set_version()
{
    if [[ "$1" == "latest" ]]; then
        VERSION=$(__kubectlenv_utils_get_latest_version)
    else
        VERSION=$(__kubectlenv_utils_get_specific_version $1)
    fi

    mkdir -p $__KUBECTLENV_HOMEDIR/bin
    ln -sfn ${__KUBECTLENV_HOMEDIR}/$VERSION/kubectl $__KUBECTLENV_HOMEDIR/bin/kubectl
}

function kubectlenv() 
{
    case "$1" 
    in
        "-l")
            __kubectlenv_utils_list_all_versions
            ;;

        "-v")
            __kubectlenv_get_version $2 &&
            __kubectlenv_set_version $2
            ;;

        *)
            __kubectlenv_print_help
            ;;
    esac
}
