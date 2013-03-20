//
// A simple loop example
// Author: Hongwei Xi (March 2013)
//

(* ****** ****** *)

staload "prelude/lmacrodef.sats"
staload INT = "prelude/DATS/integer.dats"

(* ****** ****** *)

extern
fun sumodd (n: int): int
implement
sumodd (n) = let
//
var res: int = 0
//
var i: int // uninitialized
val () = for
(
  i := 1; i <= n; i :=+ 1
)
(
  if i mod 2 = 0 then continue else res :=+ i
)
in
  res
end // end of [sumodd]

(* ****** ****** *)

macdef square(x) = let val x = ,(x) in x * x end

(* ****** ****** *)

implement
main0 () =
 {
  #define N 100
  val () = assertloc (sumodd (N) = square((N+1)/2))
  #define N1 N+1
  val () = assertloc (sumodd (N1) = square((N1+1)/2))
} // end of [main0]

(* ****** ****** *)

(* end of [sumodd] *)