#!/bin/bash

function one() {
    cd ../flutter/
    flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n/generated --generated-file-prefix=flashcards_ lib/*/*.dart ../common/lib/i18n/flashcards_*.arb
    echo "Done generating dart files."
    echo "Bye!"
    exit 0
}

function two() {
    cd ../flutter/
    cp "../common/lib/i18n/intl_messages.arb" "../common/lib/i18n/intl_messages_copy.arb" 
    flutter pub pub run intl_translation:extract_to_arb --output-dir=../common/lib/i18n lib/*/*.dart
    echo "Done generating arb file."
    echo "Diff:"

    d=``
    
    if ! type "colordiff" > /dev/null; then
        diff "../common/lib/i18n/intl_messages.arb" "../common/lib/i18n/intl_messages_copy.arb"
    else
        diff "../common/lib/i18n/intl_messages.arb" "../common/lib/i18n/intl_messages_copy.arb" | colordiff 
    fi
    rm "../common/lib/i18n/intl_messages_copy.arb"
    echo "Bye!"
    exit 0
    
}

echo "Do you want to generate dart files from arb (Method one) or re-generate arb template (Method two)?"
PS3="Please enter number: "
options=("Method one" "Method two" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Method one")
            one
            ;;
        "Method two")
            two
            ;;
        "Quit")
            break
            ;;
        *) echo "Invalid option";;
    esac
done
