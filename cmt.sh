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
help_msg() {
  echo "cmt.sh 0.0.1 by @matdexir"
  echo ""
  echo "DESCRIPTION:"
  echo -e "\tThis program serves as a replacement for git-commit but for conventional commits."
  echo ""
  echo -e "Usage: cmt.sh [flag]"
  echo -e "\t-a: For amending the previous commit"
  echo -e "\t-h: For printing this message here"
}

# getopts only supports short flags, hence I will be looking for an alternative in the future
SHORT=":ah"
# LONG="amend,help"
AMEND=""


while getopts $SHORT arg; do
	case "$arg" in
		a)
      AMEND="--amend"
      break
		;;
		h)
      help_msg
      exit 0
		;;
		*)
			echo "Argument ${arg} is not recognized" >&2
			exit 1
		;;
	esac
done



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
gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION" $AMEND
