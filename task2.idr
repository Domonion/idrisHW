
%default total

conj : ({A : Type} -> {B : Type} -> {C : Type} -> ((A -> B -> C)) -> (A) -> (B) -> C)
conj f a b = f a b


x : Int
x = conj (\a => \b => a) 1 2


disj : {A : Type} -> {B : Type} -> {C : Type} -> ((A -> C) -> (B -> C) -> C) -> (A -> C) -> (B -> C) -> C
disj disp f g = disp f g
