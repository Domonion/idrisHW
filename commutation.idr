import Data.Fin
%default total

leftAddZero : (m : Nat) -> (m = m + 0)
leftAddZero Z = Refl
leftAddZero (S k) = replace {P=\a => S k = S a} (leftAddZero k) Refl

leftAddOne : (m : Nat) -> (S m = m + 1)
leftAddOne Z = Refl
leftAddOne (S k) = replace {P=\a => S (S k) = S a} (leftAddOne k) Refl

switchAddition : (n : Nat) -> (m : Nat) -> (S n) + m = n + (S m)
switchAddition Z m = Refl
switchAddition (S k) m = replace {P=\a => (S (S k)) + m = S a} (switchAddition k m) Refl

symm : a=b -> b=a
symm Refl = Refl

transit : a=b -> b=c -> a=c
transit Refl Refl = Refl

propagateAdd : (n : Nat) -> (m : Nat) -> m + (S n) = (S m) + n
propagateAdd Z m = transit (symm (leftAddOne m)) (leftAddZero (S m))
propagateAdd (S k) m = symm (switchAddition m (S k))

commute : (n : Nat) -> (m : Nat) -> (m + n = n + m)
commute Z m = symm (leftAddZero m)
commute (S k) m = replace {P=\a => m + (S k) = S a } (commute k m) (propagateAdd k m) 




