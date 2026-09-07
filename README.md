# CLI Utils

## Quickstart

Homebrew installation:

```sh
brew install benmoose/tap/fns
```

Or `brew tap benmoose/tap` and then `brew install fns`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "benmoose/tap"
brew "fns"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).


## Contributing

### Linter

Check a script's syntax:

```sh
zsh -f -n -- path/to/script.zsh
```

Install [zsh-lint](https://wiki.zshell.dev/community/zsh_lint) to check zsh scripts locally.

```sh
go install github.com/z-shell/zsh-lint/cmd/zsh-lint@latest
zsh-lint path/to/script.zsh
```

### Updating formula

Get sha256 of formula url:

```sh
brew info --json --formula fns | jq '.[].urls.stable.url'
```
