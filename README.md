# review-noregex
Provides [elm-review](https://package.elm-lang.org/packages/jfmengels/elm-review/latest/) rule to forbid regex usage.

## Usage
After adding [elm-review](https://package.elm-lang.org/packages/jfmengels/elm-review/latest/) to your project, import this rule to
`ReviewConfig.elm` file and add it to the config. 

## Example configuration
    import NoRegex
    import Review.Rule exposing (Rule)

    config : List Rule
    config =
        [ NoRegex.rule ]