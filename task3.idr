
%default total 


one : {A : Type} -> (A -> A) -> A -> A
one f x = f x

zero : {A : Type} -> (A -> A) -> A -> A
zero f x = x


toChurch : {A : Type} -> Nat -> (A -> A) -> A -> A
toChurch Z f x = x
toChurch (S n) f x = f (toChurch n f x)


addOne : ({B : Type} -> (B -> B) -> B -> B) -> ({A : Type} -> (A -> A) -> A -> A)
addOne a f x = a f (f x)

add : ({A : Type} -> (A -> A) -> A -> A) -> ({B : Type} -> (B -> B) -> B -> B) -> ({C : Type} -> (C -> C) -> C -> C)
add a b f x = a f (b f x)


minusOne : ({A : Type} -> (A -> A) -> A -> A) -> ({B : Type} -> (B -> B) -> B -> B)
minusOne a f x = fst $ (a (\(x, y) => (y, add y one f x)) (zero f x, zero f x))
