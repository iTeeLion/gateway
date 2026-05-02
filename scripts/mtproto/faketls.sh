#!/bin/bash

install_packages() {
    sudo apt update && sudo apt install -y xxd
}

get_domain() {
    echo "--- ASKING DOMAIN ---"
    read -p "Enter domain: " DOMAIN

    if [ -z "$DOMAIN" ]; then
        echo "Cannot be empty!"
        get_domain  # Рекурсивный вызов
    fi
}

gen_key() {
    echo "--- GENERATING KEY ---"
    DOMAIN_HEX=$(echo -n $DOMAIN | xxd -ps | tr -d '\n')
    echo "Domain HEX: ${DOMAIN_HEX}"
    DOMAIN_LEN=${#DOMAIN_HEX}
    echo "Domain length: ${DOMAIN_LEN}"

    NEEDED=$((30 - DOMAIN_LEN))

    RANDOM_HEX=$(openssl rand -hex 15 | cut -c1-$NEEDED)
    echo "Randome HEX: ${RANDOM_HEX}"

    GENERATED_SECRET="ee${DOMAIN_HEX}${RANDOM_HEX}"
    echo "Resulted secret: ${GENERATED_SECRET}"
}

main() {
    install_packages
    get_domain
    gen_key
    #sed -i "s/^#\?SECRET=.*/SECRET=${GENERATED_SECRET//\//\\/}/" config.env
}

main
