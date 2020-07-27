# review-noregex

Provides [elm-review][elm-review] rule to forbid Regex usage.

## Usage

After adding [elm-review][elm-review] to your project, import this rule to `ReviewConfig.elm` file and add it to the config.

## Example configuration

```elm
import NoRegex
import Review.Rule exposing (Rule)

config : List Rule
config =
    [ NoRegex.rule ]
```


[elm-review]: https://package.elm-lang.org/packages/jfmengels/elm-review/latest/