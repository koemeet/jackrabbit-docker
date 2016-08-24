#!/usr/bin/env bash
set -e

if [ -f repository.template.xml ]; then

    for i in `compgen -e`
    do
        KEYWORD="\${ENV.$i}"
        VALUE=${!i}

        echo $KEYWORD

        echo "s#$KEYWORD#$VALUE#g" >> /tmp/replace.sed
    done

    sed -f /tmp/replace.sed < repository.template.xml > repository.xml
    rm -rf /tmp/replace.sed
fi

exec "$@"
