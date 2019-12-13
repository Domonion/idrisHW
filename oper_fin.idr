import Data.Fin

%default total
--shift : (m : Nat) -> Fin n -> Fin (m + n)
--shift Z f = f
--shift {n=t} (S m) f = FS {k = (m + t)} (shift2 m f)

--FZ {k=7}
--FS {k=7} 5
--plus_fin (FZ {k=0}) (FZ {k=0})
--plus_fin (FS {k=3} 2) (FS {k=4} 3)
plus_fin : Fin m -> Fin n -> Fin (m + n)
plus_fin {m=S x} {n=n} t f = FZ {k = (x + n)} 


--plus_fin2 : Fin m -> Fin n -> Fin (m + n)
--plus_fin2 {m=S x} {n=n} FZ FZ = (FS FZ) {k = (x + n)}
--plus_fin2 {m=S x} {n=n} t FZ = (FS t) {k = (x + n)}
--plus_fin2 {m=S x} {n=n} t f = (FS FZ) {k = (x + n)} 


--mul_fin (FZ {k=0}) (FZ {k=0})
--mul_fin (FS {k=3} 2) (FS {k=4} 3)
mul_fin : Fin m -> Fin n -> Fin (m * n)
mul_fin {m=S x} {n=S y} t f = FZ {k = plus y (mult x (S y))} 


-- Not possible haha shtuk, because a can be Z, and Fin Z is not presented
dec_fin : Fin (S a) -> Fin a
dec_fin {a=S x} f = FZ
dec_fin {a=Z} f = FZ {S a)
