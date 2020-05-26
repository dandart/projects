{-# LANGUAGE LambdaCase, OverloadedStrings #-}

module Main where

import qualified Graphics.Vty as V
import qualified Graphics.Vty.Input.Events as VIE
import Reflex.Vty
import Reflex.Vty.Host
import Reflex.Vty.Widget

main :: IO ()
main = mainWidget $ do
    text "Hello World"
    text "How are you?"
    return $ fforMaybe input1 $ \case
        V.EvKey (V.KChar 'c') [V.MCtrl] -> Just ()
        _ -> Nothing