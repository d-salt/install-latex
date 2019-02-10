#!/usr/bin/env bash

set -Cue

. "$LATEXPATH"/etc/lib/vital.sh

: "Install LaTeX and packages"  && {
    echo 'Download TeX Live...' 
    if is_exists "curl"; then
      curl -LO http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    elif is_exists "wget"; then
      wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    else
      echo "error: required: curl or wget"
      exit 1
    fi
    tar xvf install-tl-unx.tar.gz
    rm install-tl-unx.tar.gz
    echo 'Install TeX Live and packages...' 
    cd install-tl*
    sudo ./install-tl --repository http://mirror.ctan.org/systems/texlive/tlnet/
    ln -snvf /usr/local/texlive/????/bin/*/tlmgr /usr/local/
    
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

