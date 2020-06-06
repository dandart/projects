module Main where

import Control.Exception (evaluate)
import Test.Hspec
import Test.QuickCheck

prop :: [Int] -> [Int] -> Property
prop x y = collect (length x) $ length x > 3 ==> x ++ y === y ++ x

prop2 x y = collect (length x) $ length x > 3 ==> x ++ y === y ++ x
    where types = (x :: [Int], y :: [Int])

tests = describe "tests" $ do
    it "runs" $
        quickCheck prop
    it "runs 10000 times" $
        quickCheck (withMaxSuccess 10000 prop)
    it "checks" $
        1 `shouldBe` 1
    it "calcs prop" $
        property $ \x y -> (x :: Int) == (y :: Int)
    it "throws" $
        evaluate (1 / 0) `shouldThrow` anyException

main :: IO ()
main = hspec tests
    