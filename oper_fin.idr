import Data.Fin

--FZ {k=7}
--FS {k=7} 5
--plus_fin (FZ {k=0}) (FZ {k=0})
--plus_fin (FS {k=3} 2) (FS {k=4} 3)

plus_fin : Fin m -> Fin n -> Fin (m + n)
--plus_fin FZ FZ = FZ
--plus_fin FZ (FS f) = FZ
--plus_fin {m=S x} {n=n} (FS t) f = FS {k = (x + n)} (plus_fin t f)
--plus_fin {m=S Z} {n=n} t f = FZ {k = n} 
plus_fin {m=S x} {n=n} t f = FZ {k = (x + n)} 

--shift : (m : Nat) -> Fin n -> Fin (m + n)
--shift Z f = f
--shift {n=t} (S m) f = FS {k = (m + t)} (shift2 m f)
