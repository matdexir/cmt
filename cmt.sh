#!/bin/sh

TYPE=$(gum choose --cursor="◉ " "fix" "feat" "docs" "style" "ci" "refactor" "test" "chore" "revert")
SCOPE=$(gum input --placeholder "scope")


test -n  "$SCOPE" && SCOPE="($SCOPE)"

SUMMARY=$(gum input --width 80 --value "$TYPE$SCOPE:" --placeholder "Quick summary of this change")
DESCRIPTION=$(gum write --placeholder "Detailed description of this change (CTRL+D to finish)")

gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"
