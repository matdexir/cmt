#!/bin/sh
#
# Basic shellscript for following conventional commit rules

set -eu
set -o pipefail

# Defining colors for possible future use cases
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

# Prints the help message
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   the help message
help_msg() {
  printf "cmt.sh 0.0.1 by @matdexir"
  printf ""
  printf "DESCRIPTION:"
  printf "\tThis program serves as a replacement for git-commit but for conventional commits."
  printf ""
  printf "Usage: cmt.sh [flag]"
  printf "\t-a: For amending the previous commit"
  printf "\t-h: For printing this message here"
}

is_inside_git_repo() {
    git rev-parse --is-inside-work-tree >/dev/null 2>&1
}

# Detects for a '.git' folder in the current working directory
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   exits if '.git' folder was not found
detect_git() {
  if ! is_inside_git_repo; then
    printf "git is not detected in %s." "$(pwd)" 1>&2
    exit 1
  fi
}

# getopts only supports short flags, hence I will be looking for an alternative in the future
SHORT=":ah"
AMEND=""

# argument parsing
# caveat: you can pass more than one argument and I am not quite sure how to deal with it 
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

# detects for the presence of a '.git' directory
detect_git

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
