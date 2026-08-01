# ==============================================================================
# J-PAL NA RST 2026 Advanced Data Coding Best Practices Justfile
# ==============================================================================
#
# Quick reference:
# ==============================================================================

just add-new-pull <pull_number> <coding_language>:
    #!/usr/bin/env bash
    @Add a new data pull from the admin data provider to the project
    @pull_number: The number of the pull to add
    @coding_language: The coding language to use for the pull; one of Stata, R, or Python
    @Example: just add-new-pull 1
    @Output: New directories for the pull number in the code and data folders, and copies of the template validation and cleaning files
    @Usage: just add-new-pull <pull_number> <coding_language>
    mkdir -p code/clean/pull_{pull_number}
    mkdir -p code/deid/pull_{pull_number}
    mkdir -p code/validate/pull_{pull_number}
    mkdir -p data/raw/pull_{pull_number}
    if [ "{{coding_language}}" = "Stata" ]; then
        cp code/clean/template.do code/clean/pull_{pull_number}/clean.do
        cp code/deid/template.do code/deid/pull_{pull_number}/deid.do
        cp code/validate/template.do code/validate/pull_{pull_number}/validate.do
    elif [ "{{coding_language}}" = "R" ]; then
        cp code/clean/template.R code/clean/pull_{pull_number}/clean.R
        cp code/deid/template.R code/deid/pull_{pull_number}/deid.R
        cp code/validate/template.R code/validate/pull_{pull_number}/validate.R
    elif [ "{{coding_language}}" = "Python" ]; then
        cp code/clean/template.py code/clean/pull_{pull_number}/clean.py
        cp code/deid/template.py code/deid/pull_{pull_number}/deid.py
        cp code/validate/template.py code/validate/pull_{pull_number}/validate.py
    else
        echo "Invalid coding language: {{coding_language}}"
        exit 1
    fi

