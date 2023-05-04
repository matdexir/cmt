#!/bin/sh
#
# Basic shellscript for following conventional commit rules

set -eu
set -o pipefail

# Prints the help message
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   the help message
function help_msg {
  cat << END
    Usage: cmt.sh [flag]
          -a, --ammend: For amending the previous commit
          -h, --help:   For printing this message here
  END
}


SHORT=a,h
LONG=ammend,help
VALID_ARGS=$(getopt --options $SHORT --longoptions $LONG)


# gets the type of commit
TYPE=$(gum choose --cursor="◉ " "fix" "feat" "docs" "style" "ci" "refactor" "test" "chore" "revert" "misc")

# gets the scope of the commit
SCOPE=$(gum input --placeholder "scope")

# confirms for breaking changes or not
BREAKING=""
gum confirm "Breaking Changes?" && BREAKING="!"


# tests if scope is empty or not
test -n  "$SCOPE" && SCOPE="($SCOPE)"

# prompts the user for a quick summary of the commit
SUMMARY=$(gum input --width 80 --value "$TYPE$SCOPE$BREAKING: " --placeholder "Quick summary of this change")


# prompts the user for a more detailed description of the commit
DESCRIPTION=$(gum write --width 80 --placeholder "Detailed description of this change (CTRL+D to finish)")

# confirms if the user wants to commit the changes or not
gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"
