# oh-my-zsh-kubectlenv-plugin
![GitHub Release](https://img.shields.io/github/v/release/rafalmasiarek/oh-my-zsh-kubectlenv-plugin)

Plugin for [oh-my-zsh](https://ohmyz.sh/) to easy managed kubectl multiple versions

# Installation
1) Clone repository into `oh-my-zsh` custom plugins folder
```
git clone https://github.com/rafalmasiarek/oh-my-zsh-kubectlenv-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/kubectlenv
```
2) To enable kubectlenv plugin, add `kubectlenv` to the plugins array of your zshrc `~/.zshrc`:
```
plugins=(... kubectlenv)
```
3) Add kubectl path to your PATH environment variable (mostly in your `~/.zshrc`):
```
export PATH=$HOME/.kubectlenv/bin:(...)
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
1) Set `kubectl` version to latest 1.31 (and download if you don't have one)
```
$ virtualenv -v 1.31
Trying to find and get kubectl 1.31.1 
```

## License

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

```text
The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

Source: <https://opensource.org/licenses/MIT>
```
See [LICENSE](LICENSE) for full details.
