newtype Root = Root Int

instance Show Root where
    show (Root a) = "√" ++ show a

