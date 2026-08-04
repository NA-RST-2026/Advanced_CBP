# ==============================================================================
# J-PAL NA RST 2026 Advanced Data Coding Best Practices Justfile
# ==============================================================================
#
# Quick reference:
# just add-new-pull pull_number coding_language
# just undo-new-pull pull_number
# just help
# ==============================================================================

add-new-pull pull_number coding_language:
    #!/usr/bin/env bash
    mkdir -p "code/clean/pull_{{pull_number}}"
    mkdir -p "code/deid/pull_{{pull_number}}"
    mkdir -p "code/validate/pull_{{pull_number}}"
    mkdir -p "data/raw/pulls/pull_{{pull_number}}"
    mkdir -p "data/deid"
    mkdir -p "data/clean"
    if [ "{{coding_language}}" = "Stata" ]; then
        cp code/template/clean.do "code/clean/pull_{{pull_number}}/clean.do"
        cp code/template/de_identification.do "code/deid/pull_{{pull_number}}/de_identification.do"
        cp code/template/validate.do "code/validate/pull_{{pull_number}}/validate.do"
    elif [ "{{coding_language}}" = "R" ]; then
        cp code/template/clean.R "code/clean/pull_{{pull_number}}/clean.R"
        cp code/template/de_identification.R "code/deid/pull_{{pull_number}}/de_identification.R"
        cp code/template/validate.R "code/validate/pull_{{pull_number}}/validate.R"
    elif [ "{{coding_language}}" = "Python" ]; then
        cp code/template/clean.py "code/clean/pull_{{pull_number}}/clean.py"
        cp code/template/de_identification.py "code/deid/pull_{{pull_number}}/de_identification.py"
        cp code/template/validate.py "code/validate/pull_{{pull_number}}/validate.py"
    else
        echo "Invalid coding language: {{coding_language}}"
        exit 1
    fi

undo-new-pull pull_number:
    #!/usr/bin/env bash
    rm -rf "code/clean/pull_{{pull_number}}"
    rm -rf "code/deid/pull_{{pull_number}}"
    rm -rf "code/validate/pull_{{pull_number}}"

help:
    #!/usr/bin/env bash
    echo "Usage: just <command> <arguments>"
    echo "Commands:"
    echo "  add-new-pull <pull_number> <coding_language> - Add a new data pull from the admin data provider to the project"
    echo "  undo-new-pull <pull_number> - Undo the addition of a new pull"
    echo "  help - Show this help message"