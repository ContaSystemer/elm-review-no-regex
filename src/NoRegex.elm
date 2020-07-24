module NoRegex exposing (rule)

import Elm.Syntax.Import exposing (Import)
import Elm.Syntax.Node as Node exposing (Node)
import Review.Rule as Rule exposing (Error, Rule)


{-| Make sure that `regex` is not being used in the code.
As mentioned in the [core regex](https://github.com/elm/regex/tree/1.0.0#regex-in-elm) readme, it will be easier
and nicer to use parser instead of regex.
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
            { message = "No Regex usage is allowed"
            , details =
                [ "Regular expressions are difficult to write, read and maintain."
                , "It's recommended to use `Parser` package instead of `Regex`. This will help to have reliable and maintainable code."
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
