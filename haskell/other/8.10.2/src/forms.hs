{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE OverloadedStrings         #-}
{-# LANGUAGE FlexibleContexts         #-}
{-# LANGUAGE RankNTypes             #-}
{-# LANGUAGE TemplateHaskell             #-}
{-# LANGUAGE UnicodeSyntax             #-}

import qualified Data.Text as T
import Data.Text (Text)
import qualified Data.Text.IO as T
import Debug.Trace
import GHC.TypeLits
import Language.Haskell.TH.Syntax
import Text.Parsec
import Text.Parsec.Text

data IsDropdown = Dropdown | NotDropdown deriving (Show)
data IsMulti = Multi | NotMulti deriving (Show)

data FormOption = FormOption {
    formOptionValue :: Text, -- TODO definable
    formOptionLabel :: Text
} deriving (Show)

type FormOptions = [FormOption]

data FormType = FreeText -- Maybe FormAttributes -- TODO ResultTypeType eg Text
    | Number
    | Date
    | Time
    | Choose IsDropdown IsMulti FormOptions -- TODO default
    deriving (Show)

data FormElement = FormElement {
    formElementLabel :: Text,
    formElementType :: FormType
} deriving (Show)

type FormElements = [FormElement]

data Form = Form {
    formTitle :: Text,
    formElements :: FormElements
} deriving (Show)

elementParser :: Parsec Text u FormElement
elementParser = do
    label <- T.pack <$> many1 (noneOf "\n") <* optional newline
    pure $ FormElement label FreeText

formParser :: Parsec Text u Form
formParser = do
    formTitle' <- T.pack <$> many1 (noneOf "\n") <* newline
    newline
    els <- many1 (elementParser <* optional newline)
    pure $ Form formTitle' els

main ∷ IO ()
main = do
    form <- parseFromFile formParser "data/example.form"
    print form