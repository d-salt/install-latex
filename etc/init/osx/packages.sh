#!/usr/bin/env bash

set -Cue

: "Install LaTeX and packages"  && {
    brew update
    echo 'Install LaTeX and packages...'
    brew install ghostscript
    brew cask install basictex skim
    export PATH=$PATH:/Library/TeX/texbin # 強引なのでいい方法考える
    sudo tlmgr update --self --all
    sudo tlmgr paper a4
    sudo tlmgr install collection-langjapanese
    sudo tlmgr install latexmk
}


: "Note" && {
    echo ''
    echo 'Note:'
    echo "    to see realtime preview exact: latexmk -pvc"
    echo "    to enable realtime preview on skim, check"
    echo "    preference -> Sync -> Check for file changes"
}

exit 0

