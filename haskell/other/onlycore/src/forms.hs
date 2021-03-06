{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE OverloadedStrings         #-}
{-# LANGUAGE RankNTypes                #-}

{-# LANGUAGE UnicodeSyntax             #-}

import           Data.Text        (Text)
import qualified Data.Text        as T
import           Text.Parsec
import           Text.Parsec.Text

data IsDropdown = NotDropdown | Dropdown  deriving (Enum, Show)
data IsMulti = NotMulti | Multi deriving (Enum, Show)

data FormOption = FormOption {
    formOptionValue :: Text, -- TODO definable
    formOptionLabel :: Text
} deriving (Show)

type FormOptions = [FormOption]

data FormElementType = FreeText -- Maybe FormAttributes -- TODO ResultTypeType eg Text
    | Number
    | Date
    | Time
    | Choose IsDropdown IsMulti FormOptions -- TODO default
    deriving (Show)

data FormElement = FormElement {
    formElementLabel :: Text,
    formElementType  :: FormElementType
} deriving (Show)

type FormElements = [FormElement]

data Form = Form {
    formTitle    :: Text,
    formElements :: FormElements
} deriving (Show)

elementTypeParser :: Parsec Text u FormElementType
elementTypeParser =
    (FreeText <$ string "(free text)") <|>
    (Number <$ string "(number)") <|>
    (Date <$ string "(date)") <|>
    (Time <$ string "(time)") <|>
    (FreeText <$ string "...")

elementParser :: Parsec Text u FormElement
elementParser = do
    label' <- T.pack <$> many1 (noneOf "\n(.")
    optional spaces
    elementType <- elementTypeParser
    optional newline
    pure $ FormElement label' elementType

formParser :: Parsec Text u Form
formParser = do
    formTitle' <- T.pack <$> many1 (noneOf "\n")
    _ <- newline
    _ <- newline
    els <- many1 (elementParser <* optional newline)
    pure $ Form formTitle' els

main ∷ IO ()
main = do
    form <- parseFromFile formParser "data/example.form"
    print form
