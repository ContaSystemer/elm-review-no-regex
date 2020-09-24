module NoRegex exposing (rule)

{-| Makes sure that `Regex` package is not being used in the code.
As mentioned in the [Regex](https://github.com/elm/regex/tree/1.0.0#regex-in-elm) package readme,
it will be easier and nicer to use parser instead of regex.


# Rule

@docs rule

-}

import Elm.Syntax.Import exposing (Import)
import Elm.Syntax.Node as Node exposing (Node)
import Review.Rule as Rule exposing (Error, Rule)


{-|


## Usage

After adding [elm-review](https://package.elm-lang.org/packages/jfmengels/elm-review/latest/) to your project,
import this rule to `ReviewConfig.elm` file and add it to the config.


## Example configuration

    import NoRegex
    import Review.Rule exposing (Rule)

    config : List Rule
    config =
        [ NoRegex.rule ]

-}
rule : Rule
rule =
    Rule.newModuleRuleSchema "NoRegexModuleImport" ()
        |> Rule.withSimpleImportVisitor importVisitor
        |> Rule.fromModuleRuleSchema


regexModuleName : String
regexModuleName =
    "Regex"


doesImportContainsRegexModule : Node Import -> List String -> List (Error {})
doesImportContainsRegexModule node imports =
    if List.member regexModuleName imports then
        [ Rule.error
            { message = "`Regex` module usage is not allowed. Please use `Parser` module instead."
            , details =
                [ "Using `Parser` module provides code which is easier to read and maintain than the regular expressions."
                ]
            }
            (Node.range node)
        ]

    else
        []


importVisitor : Node Import -> List (Error {})
importVisitor node =
    Node.value node
        |> .moduleName
        |> Node.value
        |> doesImportContainsRegexModule node
