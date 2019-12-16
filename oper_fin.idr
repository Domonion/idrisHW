import Data.Fin

%default total
--data Fin : (n : Nat) -> Type where
--    FZ : Fin (S k)
--    FS : Fin k -> Fin (S k)

--shift : (m : Nat) -> Fin n -> Fin (m + n)
--shift Z f = f
--shift {n=t} (S m) f = FS {k = (m + t)} (shift2 m f)

--FZ {k=7}
--FS {k=7} 5
--plus_fin (FZ {k=0}) (FZ {k=0})
--plus_fin (FS {k=3} 2) (FS {k=4} 3)
plus_fin : Fin m -> Fin n -> Fin (m + n)
plus_fin {m=S x} {n=n} t f = FZ {k = (x + n)} 


plus_fin2 : Fin m -> Fin n -> Fin (m + n)
plus_fin2 {m=S p} FZ t = shift (S p) t
plus_fin2 {m=S m} {n=p} (FS f) l = FS {k = (m + p)} (plus_fin2 f l)

--weaken : Fin n -> Fin (S n)
--weaken FZ     = FZ
--weaken (FS k) = FS (weaken k)

--weakenN : (n : Nat) -> Fin m -> Fin (m + n)
--weakenN n FZ = FZ
--weakenN n (FS f) = FS (weakenN n f)

weakenN2 : (n : Nat) -> Fin m -> Fin (n + m)
weakenN2 Z f = f
weakenN2 (S k) f = weaken (weakenN2 k f)


--(x1, y1) + (x2, y2) = (x1 + x2, y1 + y2)
plus_fin3 : Fin m -> Fin n -> Fin (m + n)
plus_fin3 {m=S p} FZ t = FS (weakenN2 p t)
plus_fin3 {m=S m} {n=p} (FS f) l = FS {k = (m + p)} (plus_fin3 f l)
--or just: plus_fin3 (FS f) l = FS (plus_fin3 f l)

--mul_fin (FZ {k=0}) (FZ {k=0})
--mul_fin (FS {k=3} 2) (FS {k=4} 3)
mul_fin : Fin m -> Fin n -> Fin (m * n)
mul_fin {m=S x} {n=S y} t f = FZ {k = plus y (mult x (S y))} 


--(x1, y1) * (x2, y2) = (x1 * x2, y1 * y2) = ((x1 - 1) * x2, ...) + (x2, ...)
--(0, y1) * (x2, y2) = (0, y1 * y2)
mul_fin2 : Fin m -> Fin n -> Fin (m * n)
mul_fin2 {m=S x} {n=S y} FZ l = FZ {k = plus y (mult x (S y))}
mul_fin2 {m=S x} {n=S y} l FZ = FZ {k = plus y (mult x (S y))} 
mul_fin2 (FS l) (FS f) = FS (plus_fin3 f (mul_fin2 l (FS f)))


mul_fin3 : Fin m -> Fin n -> Fin (m * n)
mul_fin3 {m=S x} {n=S y} FZ l = weakenN (mult x (S y)) l 
mul_fin3 (FS l) f = plus_fin3 f (mul_fin3 l f)

--Not possible always, because a can be Z, and Fin Z is not presented
--dec_fin : Fin (S a) -> Fin a
--dec_fin {a=S x} FZ = FZ
--dec_fin {a=S x} (FS i) = FS (dec_fin i)
----dec_fin {a=Z} f = FZ
