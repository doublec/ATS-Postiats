//
// A naive implementation of the factorial function
// Author: Hongwei Xi (August 2007)
//

(* ****** ****** *)
//
// How to compile:
//   atscc -o fact1 fact1.dats
// How to test:
//   ./fact1
//
(* ****** ****** *)
//
// HX: [fun] declares a recursive function
//
fun fact1 (x: int): int = if x > 0 then x * fact1 (x-1) else 1

(* ****** ****** *)
//
// [fn] declares a non-recursive function
// It is fine to replace [fn] with [fun] as a non-recursive function
// is a special kind of recursive function that does not call itself.
// [@(...)] is used in ATS to group arguments for variadic functions
//
fn fact1_usage (cmd: string): void =
  prerrf ("Usage: %s [integer]\n", @(cmd)) // print an error message
// end of [fact1_usage]

(* ****** ****** *)

implement
main (argc, argv) =
  if argc >= 2 then let
    val n = int_of_string
      (argv.[1]) // turning string into integer
    val r = fact1 (n)
  in
    printf ("factorial of %i = %i\n", @(n, r))
  end else let
    val () = fact1_usage (argv.[0]) in exit (1)
  end // end of [if]
// end of [main]

(* ****** ****** *)

(* end of [fact1.dats] *)