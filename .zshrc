export LANG=ja_JP.UTF-8
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=10000

source ~/dotfiles/dotfiles_link.sh

#パスの設定
PATH=/usr/local/bin:$PATH
export MANPATH=/usr/local/share/man:/usr/local/man:/usr/share/man

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias git='nocorrect git'

## 補完機能の強化
autoload -Uz compinit
compinit

autoload colors
colors
case ${UID} in
0)
	PROMPT='%{${fg[green]}%} %n %{${reset_color}%}'
	RPROMPT='%{${fg[yellow]}%} [%~] %{${reset_color}%}'
	;;
*)
	PROMPT='%{${fg[green]}%} %n %{${reset_color}%}'
	RPROMPT='%{${fg[yellow]}%} [%~] %{${reset_color}%}'
	;;
esac

## コアダンプサイズを制限
# limit coredumpsize 102400

## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr

## 色を使う
setopt prompt_subst

## ビープを鳴らさない
#setopt nobeep

## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

## 補完候補一覧でファイルの種別をマーク表示
setopt list_types

## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume

## 補完候補を一覧表示
setopt auto_list

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

## cd 時に自動で push
setopt autopushd

## 同じディレクトリを pushd しない
setopt pushd_ignore_dups

## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob

## TAB で順に補完候補を切り替える
setopt auto_menu

## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history

## =command を command のパス名に展開する
setopt equals

## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst

## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify

# ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort

## 出力時8ビットを通す
setopt print_eight_bit

## ヒストリを共有
setopt share_history

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

## 補完候補の色づけ
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## ディレクトリ名だけで cd
setopt auto_cd

## カッコの対応などを自動的に補完
setopt auto_param_keys

## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

## スペルチェック
setopt correct

## jkobayashi add
echo Callme
export PATH=$PATH:/usr/local/vim74/bin/
export PATH=$PATH:~/java_wrapper
export PATH=$PATH:~/bin/
alias vim='/usr/local/vim74/bin/vim.exe'
alias gnuplot='/cygdrive/c/Program\ Files\ \(x86\)/gnuplot/bin/gnuplot.exe'
alias ec='explorer .'
alias c='cygstart'
alias excellkill='taskkill /IM EXCEL.exe /F'
alias cubekill='taskkill /IM CubeSuiteW+.exe /F'
alias vckill='taskkill /IM VCExpress.exe /F'
alias pdfkill='taskkill /IM AcroRd32.exe /F'
export TERM=xterm
export PLANTUML_PATH="`cygpath -w \`which plantuml.jar\``"

bindkey -v

alias -s txt=/usr/local/vim74/bin/vim.exe

## cdr system stuff.
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
# エントリが多くなるとちょっぴり重い
# https://github.com/zsh-users/zsh/blob/zsh-5.0.4/Functions/Chpwd/chpwd_recent_filehandler#L39
# zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

source ~/z.sh
function percol_select_directory() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    local dest=$(_z -r 2>&1 | eval $tac | percol --query "$LBUFFER" | awk '{ print $2 }')
    if [ -n "${dest}" ]; then
        cd ${dest}
    fi
    zle reset-prompt
}
zle -N percol_select_directory
bindkey "^X;" percol_select_directory

# function percol_select_history() {
#     local tac
#     if which tac > /dev/null; then
#         tac="tac"
#     else
#         tac="tail -r"
#     fi
#     BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
#     CURSOR=$#BUFFER             # move cursor
#     zle -R -c                   # refresh
# }
# zle -N percol_select_history
# bindkey "^X:" percol_select_history
#
# setopt hist_ignore_all_dups
#
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi

function wincmd() {
    cmd /C $@ | iconv -f cp932 -t utf-8
}

function svnjk() {
	svn log | sed -n '/jkobayashi/,/-----$/ p'
}

