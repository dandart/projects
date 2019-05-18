import Data.Numbers.Primes

[
    (
        (primes !! 299 * primes !! 926) `mod` 2^x,
        (primes !! 299) `mod` 2^x,
        (primes !! 926) `mod` 2^x
    ) | x <- [1..100]]