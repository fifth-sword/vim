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
""Tags関連
"source ~/dotfiles/.vimrc.tags
"検索関連
source ~/dotfiles/vim/.vimrc.search
""移動関連
"source ~/dotfiles/.vimrc.moving
""Color関連
"source ~/dotfiles/.vimrc.colors
""編集関連
"source ~/dotfiles/.vimrc.editing
""エンコーディング関連
"source ~/dotfiles/.vimrc.encoding
""その他
"source ~/dotfiles/.vimrc.misc
""プラグインに依存するアレ
"source ~/dotfiles/.vimrc.plugins_setting

" MacVim用設定
if has('gui_running')
  set imdisable
  set antialias
  set guioptions& guioptions-=T
  set guifont=Ricty:h13
  " http://code.google.com/p/macvim-kaoriya/wiki/Readme
  set transparency=10
endif

