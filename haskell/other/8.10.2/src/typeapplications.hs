{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE UnicodeSyntax    #-}
main ∷ IO ()
main = do
    let s = read @Int "2"
    let t = read @Int "3"
    print . show $ s + t
