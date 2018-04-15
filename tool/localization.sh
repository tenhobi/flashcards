#!/bin/bash

function one() {
    cd ../common/
    pub run intl_translation:generate_from_arb --output-dir=lib/src/i18n/generated --generated-file-prefix=flashcards_ lib/src/i18n/*.dart lib/src/i18n/translations/*_*.arb
    echo "Done generating dart files."
    echo "Bye!"
    exit 0
}

function two() {
    cd ../common/
    ORIG="../common/lib/src/i18n/translations/intl_messages.arb"
    COPY="../common/lib/src/i18n/translations/template_copy.arb"
    TEMPLATE="../common/lib/src/i18n/translations/template.arb"
    cp $TEMPLATE $COPY 2>/dev/null
    pub run intl_translation:extract_to_arb --output-dir=lib/src/i18n/translations lib/src/i18n/string.dart
    mv $ORIG $TEMPLATE

    echo "Done generating arb file."
    echo "Diff:"
    if ! type "colordiff" > /dev/null; then
        diff $TEMPLATE $COPY 2>/dev/null
    else
        diff $TEMPLATE $COPY | colordiff 2>/dev/null
    fi
    rm $COPY 2>/dev/null
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
