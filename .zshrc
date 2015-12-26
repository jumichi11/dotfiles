export LANG=ja_JP.UTF-8
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=10000

source ~/dotfiles/dotfiles_link.sh

#�p�X�̐ݒ�
PATH=/usr/local/bin:$PATH
export MANPATH=/usr/local/share/man:/usr/local/man:/usr/share/man

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias git='nocorrect git'

## �⊮�@�\�̋���
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

## �R�A�_���v�T�C�Y�𐧌�
# limit coredumpsize 102400

## �o�͂̕����񖖔��ɉ��s�R�[�h�������ꍇ�ł��\��
unsetopt promptcr

## �F���g��
setopt prompt_subst

## �r�[�v��炳�Ȃ�
#setopt nobeep

## �����R�}���h jobs �̏o�͂��f�t�H���g�� jobs -l �ɂ���
setopt long_list_jobs

## �⊮���ꗗ�Ńt�@�C���̎�ʂ��}�[�N�\��
setopt list_types

## �T�X�y���h���̃v���Z�X�Ɠ����R�}���h�������s�����ꍇ�̓��W���[��
setopt auto_resume

## �⊮�����ꗗ�\��
setopt auto_list

## ���O�Ɠ����R�}���h���q�X�g���ɒǉ����Ȃ�
setopt hist_ignore_dups

## cd ���Ɏ����� push
setopt autopushd

## �����f�B���N�g���� pushd ���Ȃ�
setopt pushd_ignore_dups

## �t�@�C������ #, ~, ^ �� 3 �����𐳋K�\���Ƃ��Ĉ���
setopt extended_glob

## TAB �ŏ��ɕ⊮����؂�ւ���
setopt auto_menu

## zsh �̊J�n, �I���������q�X�g���t�@�C���ɏ�������
setopt extended_history

## =command �� command �̃p�X���ɓW�J����
setopt equals

## --prefix=/usr �Ȃǂ� = �ȍ~���⊮
setopt magic_equal_subst

## �q�X�g�����Ăяo���Ă�����s����ԂɈ�U�ҏW
setopt hist_verify

# �t�@�C�����̓W�J�Ŏ������ł͂Ȃ����l�I�Ƀ\�[�g
setopt numeric_glob_sort

## �o�͎�8�r�b�g��ʂ�
setopt print_eight_bit

## �q�X�g�������L
setopt share_history

## �⊮���̃J�[�\���I����L����
zstyle ':completion:*:default' menu select=1

## �⊮���̐F�Â�
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## �f�B���N�g���������� cd
setopt auto_cd

## �J�b�R�̑Ή��Ȃǂ������I�ɕ⊮
setopt auto_param_keys

## �f�B���N�g�����̕⊮�Ŗ����� / �������I�ɕt�����A���̕⊮�ɔ�����
setopt auto_param_slash

## �X�y���`�F�b�N
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
# �G���g���������Ȃ�Ƃ�����҂�d��
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

