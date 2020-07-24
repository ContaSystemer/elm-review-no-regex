module NoRegexTest exposing (tests)

import NoRegex exposing (rule)
import Review.Test exposing (ReviewResult)
import Test exposing (Test)


{-| Rule to test
-}
testRule : String -> ReviewResult
testRule string =
    Review.Test.run rule string


{-| Helper function to amend module declaration in a test
-}
testString : String -> String
testString stringToConcat =
    """module A exposing (..)""" ++ stringToConcat


{-| Test cases for NoRegexModuleImport rule
-}
tests : Test
tests =
    Test.describe "NoRegex"
        [ Test.test "should not report imports without regex module" <|
            \() ->
                testRule (testString """import AnyModule exposing (..)""")
                    |> Review.Test.expectNoErrors
        , Test.test "should fire an error when import contains regex modules" <|
            \() ->
                testRule (testString "import Regex exposing (..)")
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "No Regex usage is allowed"
                            , under = "import Regex exposing (..)"
                            , details =
                                [ "Regular expressions are difficult to write, read and maintain."
                                , "It's recommended to use `Parser` package instead of `Regex`. This will help to have reliable and maintainable code."
                                ]
                            }
                        ]
        ]
