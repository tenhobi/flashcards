#!/bin/bash

function generatedart() {
    pub run intl_translation:generate_from_arb --output-dir=lib/src/i18n/generated --generated-file-prefix="" lib/src/i18n/*.dart lib/src/i18n/translations/*_*.arb
    echo "Done generating dart files."
    echo "Formatting"
    dartfmt --line-length 120 -w lib/src/i18n/generated/*.dart
    echo "Bye!"
    exit 0
}

function generatearb() {
    ORIG="lib/src/i18n/translations/intl_messages.arb"
    COPY="lib/src/i18n/translations/template_copy.arb"
    TEMPLATE="lib/src/i18n/translations/template.arb"
    cp $TEMPLATE $COPY 2>/dev/null
    pub run intl_translation:extract_to_arb --output-dir=lib/src/i18n/translations lib/src/i18n/string.dart
    mv $ORIG $TEMPLATE

    echo "Done generating arb file."
    echo "Diff:"
    if ! type "colordiff" > /dev/null; then
        diff $COPY $TEMPLATE 2>/dev/null
    else
        diff $COPY $TEMPLATE | colordiff 2>/dev/null
    fi
    rm $COPY 2>/dev/null
    echo "Bye!"
    exit 0
}

# move to the right directory
cd "$(dirname $0)"/../common/

echo "Available methods:"
PS3="Choose method to use: "
options=("Generate arb template from source" "Generate Dart files from arb templates" "Quit")
select opt in "${options[@]}"
do
    case ${opt} in
        "Generate arb template from source")
            generatearb
            ;;
        "Generate Dart files from arb templates")
            generatedart
            ;;
        "Quit")
            break
            ;;
        *) echo "Invalid option";;
    esac
done
