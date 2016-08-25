#!/usr/bin/env bash
set -e

if [ -f /workspace.template.xml ]; then

    for i in `compgen -e`
    do
        KEYWORD="\${ENV.$i}"
        VALUE=${!i}

        echo $KEYWORD

        echo "s#$KEYWORD#$VALUE#g" >> /tmp/replace.sed
    done

    sed -f /tmp/replace.sed < /workspace.template.xml > /opt/jackrabbit/workspaces/default/workspace.xml
    rm -rf /tmp/replace.sed
fi

if [ -f /repository.template.xml ]; then

    for i in `compgen -e`
    do
        KEYWORD="\${ENV.$i}"
        VALUE=${!i}

        echo $KEYWORD

        echo "s#$KEYWORD#$VALUE#g" >> /tmp/replace.sed
    done

    sed -f /tmp/replace.sed < /repository.template.xml > /opt/jackrabbit/repository.xml
    rm -rf /tmp/replace.sed
fi

exec "$@"
