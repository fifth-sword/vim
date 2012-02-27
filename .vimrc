source ~/dotfiles/vim/.vimrc.bundle
"基本設定
source ~/dotfiles/vim/.vimrc.basic
"表示関連
source ~/dotfiles/vim/.vimrc.display
"StatusLine設定
source ~/dotfiles/vim/.vimrc.statusline
"インデント設定
source ~/dotfiles/vim/.vimrc.indent
"補完関連
source ~/dotfiles/vim/.vimrc.compl
"検索関連
source ~/dotfiles/vim/.vimrc.search
"移動関連
source ~/dotfiles/vim/.vimrc.moving
"編集関連
source ~/dotfiles/vim/.vimrc.editing
"エンコーディング関連
source ~/dotfiles/vim/.vimrc.encoding
"プラグイン関連
source ~/dotfiles/vim/.vimrc.plugins
"ファイル別設定
source ~/dotfiles/vim/.vimrc.files

" MacVim用設定
if has('gui_running')
  set imdisable
  set antialias
  set guioptions& guioptions-=T
  set guifont=Ricty:h13
  " http://code.google.com/p/macvim-kaoriya/wiki/Readme
  set transparency=10
endif
