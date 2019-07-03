import Data.Complex

complexNums :: (Num a, RealFloat a) => [Complex a]
complexNums = [
    (0 :+ 1) * (0 :+ 1),
    cis 1.0,
    conjugate (0 :+ 1),
    mkPolar 1.0 1.0]


realNums :: (Num a, RealFloat a) => [a]
realNums = [
    realPart (1 :+ 1),
    imagPart (0 :+ 1),
    magnitude (1 :+ 1),
    phase (1 :+ (-1))]

tuples :: (Num a, RealFloat a) => [(a, a)]
tuples = [
    polar (1 :+ 2)]

allOfThem :: (Num a, RealFloat a) => ([Complex a], [a], [(a, a)])
allOfThem = (complexNums, realNums, tuples)

main :: IO ()
main = print allOfThem