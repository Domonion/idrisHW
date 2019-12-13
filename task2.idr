
%default total

makePair : a -> b -> ( (t : Type) -> ( ( a -> b -> t ) -> t )  )
makePair x y = \z => \f => f x y

myTrue : a -> b -> a
myTrue f g = f

myFalse : a -> b -> b
myFalse f g = g

getFirst : ( (a -> b -> a ) -> a ) -> a
getFirst pair = pair myTrue

getSecond : ( ( a -> b -> b ) -> b) -> b
getSecond pair = pair myFalse

inj1 : (b : Type) -> a -> ( (g : Type) -> ( (a -> g) -> (b -> g) -> g) )
inj1 _ a = \t => \fa => \fb => fa a

inj2 : (a : Type) -> b -> ( ( g : Type) -> ( ( a -> g) -> (b -> g) -> g) ) 
inj2 _ b = \t => \fa => \fb => fb b

myCase : ( ( a -> g ) -> ( b -> g) -> g) -> (a -> g) -> (b -> g) -> g
myCase alg f g = alg f g
