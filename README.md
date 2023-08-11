# oh-my-zsh-kubectlenv-plugin
Plugin for [oh-my-zsh](https://ohmyz.sh/) to easy managed kubectl multiple versions

# Installation
1) Clone repository to `~/.oh-my-zsh/custom/plugins`
```
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/rafalmasiarek/oh-my-zsh-kubectlenv-plugin.git kubectlenv
```
2) To enable kubectlenv plugin, add `kubectlenv` to the plugins array of your zshrc `~/.zshrc`:
```
plugins=(... kubectlenv)
```
and reload your terminal or use command:
```
source ~/.zshrc
```

# Usage
The following all `kubectlenv` parameters:

```
virtualenv -l    : Print all available k8s versions from github tag
virtualenv -v    : Set kubectl version
virtualenv -h    : Print help message
```

## Example:
1) Set `kubectl` version to latest 1.26 (and download if you don't have one)
```
$ virtualenv -v 1.26
Trying to find and get kubectl 1.26.7 
```

