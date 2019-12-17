import Data.Fin
%default total



plusplus : (a : Nat) -> S a = a + 1
plusplus Z = Refl
plusplus (S x) = replace {P=(\w => S (S x) = S w)} (plusplus x)  Refl


copy : {n : Nat} -> Fin (S n) -> Fin (n + 1)
copy {n} (FS fin) = replace {P=\a => Fin (a)} (plusplus n) (FS fin)
copy {n} FZ       = replace {P=\a => Fin (a)} (plusplus n) (FZ)

