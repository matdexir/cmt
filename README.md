# cmt.sh(WIP)

It's a tool for writing [Conventional commit messages](https://www.conventionalcommits.org/en/v1.0.0/#summary) powered by [gum](https://github.com/charmbracelet/gum) 

## Dependencies

```
gum
bash(Bourne-Again Shell)
Linux(Not tested on MacOS)
```

## Usage

Assuming that your default shell is `bash`, download the script, then:

```
chmod +x cmt.sh
./cmt.sh (insise a git repo)
```

## Help message

```
cmt.sh 0.0.1 by @matdexir

DESCRIPTION:
	This program serves as a replacement for git-commit but for conventional commits.

Usage: cmt.sh [flag]
	-a: For amending the previous commit
	-h: For printing this message here
```

## Note 

You can also add `where/file/is/cmt.sh` to your `$PATH` for convenience.
