import Data.Fin
%default total


plusZeroL : (n : Nat) -> (plus Z n = n)
plusZeroL n = Refl

plusZeroR : (n : Nat) -> (plus n Z = n)
plusZeroR Z = Refl
plusZeroR (S m) = replace {P=\a => S (plus m 0) = S a} (plusZeroR m) (Refl) 


leftZeroAddition : (m : Nat) -> (m = m + 0)
leftZeroAddition Z = Refl
leftZeroAddition (S k) = replace {P=\a => S k = S a} (leftZeroAddition k) Refl

leftAddOne : (m : Nat) -> (S m = m + 1)
leftAddOne Z = Refl
leftAddOne (S k) = replace {P=\a => S (S k) = S a} (leftAddOne k) Refl

moveAddition : (n : Nat) -> (m : Nat) -> (S n) + m = n + (S m)
moveAddition Z m = Refl
moveAddition (S k) m = replace {P=\a => (S (S k)) + m = S a} (moveAddition k m) Refl

symm : a=b -> b=a
symm Refl = Refl

transit : a=b -> b=c -> a=c
transit Refl Refl = Refl

propagateAdd : (n : Nat) -> (m : Nat) -> m + (S n) = (S m) + n
propagateAdd Z m = transit (symm (leftAddOne m)) (leftZeroAddition (S m))
propagateAdd (S k) m = symm (moveAddition m (S k))

commute : (n : Nat) -> (m : Nat) -> (m + n = n + m)
commute Z m = symm (leftZeroAddition m)
commute (S k) m = replace {P=\a => m + (S k) = S a } (commute k m) (propagateAdd k m) 



--plusplus : (a : Nat) -> S a = a + 1
--plusplus Z = Refl
--plusplus (S x) = replace {P=(\w => S (S x) = S w)} (plusplus x)  Refl


--copy : Fin (S a) -> Fin (a + 1)
--copy (FS (S a)) = plusplus

