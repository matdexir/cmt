#!/bin/sh

TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")
SCOPE=$(gum input --placeholder "scope")


test -n  "$SCOPE" && SCOPE="($SCOPE)"

SUMMARY=$(gum input --value "$TYPE$SCOPE:" --placeholder "Quick summary of this change")
DESCRIPTION=$(gum write --placeholder "Detailed description of this change (CTRL+D to finish)")

gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"
