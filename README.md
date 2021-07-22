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

## Start VIM

```bash
vim
```

## Others

- `.vimrc` is for Linux/Mac
- `.vimperatorrc` is for Firefox plugin `vimperator`
- Plugins manage: [vim-plug](https://github.com/junegunn/vim-plug)
