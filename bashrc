#if [ "$TERM" -eq "screen" ]; then
#        stty erase ""
#fi

#bind SPACE:magic-space

export HISTSIZE=20000
export HISTFILESIZE=20000
# aggressively write history
export PROMPT_COMMAND='history -a'
shopt -s histappend
# ignore duplicate lines and lines starting with space
export HISTCONTROL='ignoreboth'
# add timestamps to history
export HISTTIMEFORMAT='%b %d %H:%M:%S: '
# save multi-line entries as a single entry
set cmdhist

export ARCH=`uname -i`
export EDITOR=/usr/bin/vim
export MAILCHECK=0
export NAME='Jason Frantz'
export PAGER=less
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

alias dusort='du -s *|sort -n'
alias ls='ls -h --color=tty'
alias pu=pushd
alias po=popd
alias vi=vim

# tagging commands
alias r_="rename 's/\ /_/g' *"
alias mp3C='mp3info *.mp3|grep Comment:'
alias mp3x='mp3info -x *.mp3|grep Audio:'

alias grep='grep --color'
#alias sgrep='grep -rI --exclude=tags'
#alias sgrep='grep --include=*.[ch]'

alias mq='hg -R $(hg root)/.hg/patches'

alias kdf3='kdiff3 --cs "FileAntiPattern=*.orig;*.o;*.obj;tags;*.pyc;.sconsign.dblite" --cs "DirAntiPattern=CVS;.deps;.svn;.hg;build" p2.0 p2.0-bigc/'

ulimit -c unlimited

# Conversions
h2d() { /bin/echo 16i "$*" p | tr abcdef ABCDEF | /usr/bin/dc; }
h2o() { /bin/echo 8o 16i "$*" p | tr abcdef ABCDEF | /usr/bin/dc; }
h2b() { /bin/echo 2o 16i "$*" p | tr abcdef ABCDEF | /usr/bin/dc; }
                                                                                
d2h() { /bin/echo "$*" 16op | /usr/bin/dc; }
d2o() { /bin/echo "$*" 8op | /usr/bin/dc; }
d2b() { /bin/echo "$*" 2op | /usr/bin/dc; }
                                                                                
o2h() { /bin/echo 16o 8i "$*" p | /usr/bin/dc; }
o2d() { /bin/echo 8i "$*" p | /usr/bin/dc; }
o2b() { /bin/echo 2o 8i "$*" p | /usr/bin/dc; }
                                                                                
b2h() { /bin/echo 16o 2i "$*" p | /usr/bin/dc; }
b2d() { /bin/echo 2i "$*" p | /usr/bin/dc; }
b2o() { /bin/echo 8o 2i "$*" p | /usr/bin/dc; }

bug() { /usr/bin/links -dump http://bugs/show_bug.cgi?id="$*" | less; }
