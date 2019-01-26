#!/usr/bin/env bash


set -Ceu

. "$LATEXPATH"/etc/lib/vital.sh

if [ -z "$LATEXPATH" ]; then
    echo '$LATEXPATH not set' >&2
    exit 1
fi

for script in "$LATEXPATH"/etc/init/$(get_os)/*.sh
do
    if [ -f "$script" ]; then
        echo '-> $(basename $script)'
        bash $script
    else
        continue
    fi
done

echo "Done. Bye!"
exit 0
