-- Author: Mukesh Tiwari
-- https://github.com/mukeshtiwari/Idris/blob/master/Printf.idr
import Data.String

%default total

data Format = FInt Format
            | FLeadZero Nat Format
            | FString Format
            | FOther Char Format
            | FEnd


parseNumWithoutSign : List Char -> Nat -> Maybe Nat 
parseNumWithoutSign []        acc = Just acc
parseNumWithoutSign (c :: cs) acc = 
  if (c >= '0' && c <= '9') 
  then parseNumWithoutSign cs ((acc * 10) + (cast ((ord c) - (ord '0'))))
  else Nothing

mutual
  formatHelper : List Char -> List Char -> List Char -> Format
  formatHelper s ('d' :: l) orig with (parseNumWithoutSign (s) 0)
      | Just a = FLeadZero a (format l)
      | Nothing = FOther '%' (FOther '0' (format orig))
  formatHelper [] ('d' :: l) orig = FInt (format l)
  formatHelper s (c :: l) orig with ('0' <= c && '9' >= c)
      | True = formatHelper (s ++ (unpack $ singleton c)) l orig
      | False = FOther '%' (FOther '0' (format orig))
  formatHelper s [] orig = FOther '%' (FOther '0' (format orig)) 

  format : List Char -> Format
  format ('%' :: 'd' :: cs ) = FInt ( format cs )
  format ('%' :: '0' :: s) = formatHelper (unpack "") s s
  format ('%' :: 's' :: cs ) = FString ( format cs )
  format ( c :: cs )         = FOther c ( format cs )
  format []                  = FEnd




interpFormat : Format -> Type
interpFormat ( FInt f )       = Int -> interpFormat f
interpFormat ( FLeadZero n f) = Int -> interpFormat f
interpFormat ( FString f )    = String -> interpFormat f
interpFormat ( FOther _ f )   = interpFormat f
interpFormat FEnd             = String


formatString : String -> Format
formatString s = format ( unpack s )

genZeros : Nat -> String
genZeros Z = ""
genZeros (S n) = "0" ++ genZeros n

toFunction : ( fmt : Format ) -> String -> interpFormat fmt
toFunction ( FInt f ) a       = \i => toFunction f ( a ++ show i )
toFunction ( FLeadZero n f) a = \i => toFunction f (a ++ genZeros (minus n  (length (show i))) ++ (show i)) 
toFunction ( FString f ) a    = \s => toFunction f ( a ++ s )
toFunction ( FOther c f ) a   = toFunction f ( a ++ singleton c )
toFunction FEnd a             = a 




sprintf : ( s : String ) -> interpFormat ( formatString s )
sprintf s = toFunction ( formatString s ) ""

--main : IO ()
--main = putStrLn (sprintf "String parameter: %s, integer parameter: %d" "alpha" (10+23))
