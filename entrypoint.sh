#!/usr/bin/env bash
set -e

JACKRABBIT_HOME="/opt/jackrabbit"

function process_configuration_template {
    TEMPLATE_PATH=$1
    TARGET_PATH=$2

    for i in `compgen -e`
    do
        KEYWORD="\${ENV.$i}"
        VALUE=${!i}

        echo "s#$KEYWORD#$VALUE#g" >> /tmp/replace.sed
    done

    sed -f /tmp/replace.sed < $TEMPLATE_PATH > $TARGET_PATH
    rm -rf /tmp/replace.sed
}

# Check if there already is a workspace initialized. If so, we should update
# it's configuration.
if [ -f "$JACKRABBIT_HOME/workspaces/default/workspace.xml" ]; then
    process_configuration_template /workspace.template.xml $JACKRABBIT_HOME/workspaces/default/workspace.xml
fi

# Process repository template if it's available
if [ -f "/repository.template.xml" ]; then
    process_configuration_template /repository.template.xml $JACKRABBIT_HOME/repository.xml
fi

exec "$@"
