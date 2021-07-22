# VIM Configuration

## Prepare

### Install `fzf`

#### Linux

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

#### Mac

```bash
brew install fzf
$(brew --prefix)/opt/fzf/install
```

### Install `node`

#### Install `nvm`

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```

#### Install latest release of node

```bash
export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
nvm install node
```

#### Link `.vimrc`/`coc-config.json` file

```bash
ln -s $(pwd)/.vimrc ~/.vimrc
ln -s $(pwd)/coc-settings.json ~/.vim/coc-settings.json
```

## Start VIM

### First start to init the plug

```bash
vim
```

### Install `coc.nvim` Plugin

```bash
alias nvm_mirror='npm_config_registry=http://registry.npm.taobao.org/ SASS_BINARY_SITE=https://npm.taobao.org/mirrors/node-sass/'
nvm_mirror vim
# :CocInstall coc-json coc-tsserver
```

## Update `.vimrc`

```bash
vim -u DEFAULTS ~/.vimrc
```

## Others

- `.vimrc` is for Linux/Mac
- `.vimperatorrc` is for Firefox plugin `vimperator`
- Plugins manage: [vim-plug](https://github.com/junegunn/vim-plug)
