
%default total 

church : Type
church = (a : _) -> (a -> a) -> (a -> a)

one : Main.church 
one t f x = f x

zero : Main.church
zero t f x = x


toChurch : Nat -> Main.church 
toChurch Z t f x = x
toChurch (S n) t f x = f (toChurch n t f x)


addOne : Main.church -> Main.church
addOne a t f x = a t f (f x)

add : Main.church -> Main.church -> Main.church
add a b t f x = a t f (b t f x)

addEx : Main.church -> Main.church -> Main.church
addEx a b = (a (Main.church) addOne (b)) 

ff : (a : Type) -> Int
ff x = 1


pc : Type
pc = (Main.church, Main.church)

fn : Main.pc -> Main.pc
fn (a, b) = (b, addOne b)

init : (Main.church, Main.church)
init = (zero, zero)


minusOne : Main.church -> Main.church 
minusOne a = (fst $ (a (Main.church, Main.church) (\(x, y) => (y, addOne x)) (zero, zero)))


minus : Main.church -> Main.church -> Main.church
minus a b = b Main.church minusOne a


mult : Main.church -> Main.church -> Main.church
mult a b = a Main.church (add b) zero

pow : Main.church -> Main.church -> Main.church
pow a b = a Main.church (mult b) one

