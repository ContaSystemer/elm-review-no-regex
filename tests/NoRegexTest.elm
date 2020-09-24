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
        , Test.test "should fire an error when import contains regex module" <|
            \() ->
                testRule (testString "import Regex exposing (..)")
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = "`Regex` module usage is not allowed. Please use `Parser` module instead."
                            , under = "import Regex exposing (..)"
                            , details =
                                [ "Using `Parser` module provides code which is easier to read and maintain than the regular expressions."
                                ]
                            }
                        ]
        ]
