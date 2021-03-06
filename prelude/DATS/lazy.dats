(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
** later version.
**
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
**
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: July, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [lazy.dats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

implement{a}
stream2list (xs) = let
//
fun loop (
  xs: stream (a), res: &ptr? >> List0_vt (a)
) : void = let
in
  case+ !xs of
  | stream_cons
      (x, xs) => let
      val () = res :=
        list_vt_cons{a}{0} (x, _)
      // end of [val]
      val+ list_vt_cons (_, res1) = res
      val () = loop (xs, res1)
      prval () = fold@ (res)
    in
      // nothing
    end // end of [stream_cons]
  | stream_nil () => res := list_vt_nil ()
end // end of [loop]
var res: ptr // uninitialized
val () = $effmask_all (loop (xs, res))
//
in
  res
end // end of [stream2list]

(* ****** ****** *)

implement{a}
stream_nth_exn
  (xs, n) = let
in
  case+ !xs of
  | stream_cons (x, xs) =>
      if n > 0 then stream_nth_exn<a> (xs, pred(n)) else x
  | stream_nil () => $raise StreamSubscriptExn()
end // end of [stream_nth_exn]

implement{a}
stream_nth_opt
  (xs, n) = let
//
fn handle
  (exn: exn):<> Option_vt (a) = let
in
  if isStreamSubscriptExn (exn) then let
    prval (
    ) = __assert (exn) where {
      extern praxi __assert : (exn) -<prf> void
    } // end of [prval]
  in
    None_vt ()
  end else
    $effmask_exn ($raise (exn)) // HX: deadcode
  // end of [if]
end // end of [handle]
//
in
  try Some_vt (stream_nth_exn<a> (xs, n)) with exn => handle (exn)
end // end of [stream_nth_opt]

(* ****** ****** *)

implement{a}
stream_take_exn
  (xs, n) = let
//
fun loop {n:nat} (
  xs: stream a, res: &ptr? >> list_vt (a, n-k), n: int n
) : #[k:nat | k <= n] int k =
  if n > 0 then (
    case+ !xs of
    | stream_cons
        (x, xs) => let
        val () = res :=
          list_vt_cons{a}{0} (x, _)
        val+ list_vt_cons (_, res1) = res
        val k = loop (xs, res1, pred(n))
        prval () = fold@ (res)
      in
        k
      end // end of [stream_cons]
    | stream_nil () => let
        val () = res := list_vt_nil () in n
      end // end of [stream_nil]
  ) else let
    val () = res := list_vt_nil () in n
  end // end of [if]
//
var res: ptr // uninitialized
val k = $effmask_all (loop (xs, res, n))
//
in
//
$effmask_all (
if k = 0 then res else let
  val () = list_vt_free (res) in $raise StreamSubscriptExn()
end // end of [if]
) // end of [$effmask_all]
//
end // end of [stream_take_exn]

(* ****** ****** *)

implement{a}
stream_drop_exn
  (xs, n) = let
in
  if n > 0 then (
    case+ !xs of
    | stream_cons
        (_, xs) => stream_drop_exn (xs, pred(n))
    | stream_nil () => $raise StreamSubscriptExn()
  ) else xs // end of [if]
end // end of [stream_drop_exn]

(* ****** ****** *)

local

fun{a:t0p}
stream_filter_con
  (xs: stream a): stream_con a = let
in
  case+ !xs of
  | stream_cons (x, xs) => (
      if stream_filter$pred (x) then
        stream_cons (x, stream_filter<a> (xs))
      else
        stream_filter_con (xs)
      // end of [if]
    ) // end of [stream_cons]
  | stream_nil () => stream_nil ()
end // end of [stream_filter_con]

in // local]

implement{a}
stream_filter
  (xs) = $delay (stream_filter_con<a> (xs))
// end of [stream_filter]

implement{a}
stream_filter_fun (xs, p) = let
//
implement
stream_filter$pred<a> (x) = p (x)
//
in
  stream_filter (xs)
end // end of [stream_filter_fun]

implement{a}
stream_filter_cloref (xs, p) = let
//
implement
stream_filter$pred<a> (x) = p (x)
//
in
  stream_filter (xs)
end // end of [stream_filter_cloref]

end // end of [local]

(* ****** ****** *)

implement
{a}{b}
stream_map
  (xs) = $delay (
//
case+ !xs of
| stream_cons
    (x, xs) => let
    val y = stream_map$fwork<a><b> (x)
  in
    stream_cons (y, stream_map<a><b> (xs))
  end // end of [stream_cons]
| stream_nil () => stream_nil ()
//
) // end of [stream_map]

implement
{a}{b}
stream_map_fun
  (xs, f) = let
//
implement
stream_map$fwork<a><b> (x) = f (x)
//
in
  stream_map (xs)
end // end of [stream_map_fun]

implement
{a}{b}
stream_map_cloref
  (xs, f) = let
//
implement
stream_map$fwork<a><b> (x) = f (x)
//
in
  stream_map (xs)
end // end of [stream_map_cloref]

(* ****** ****** *)

local

#define :: stream_cons

in // in of [local]

implement
{a1,a2}{b}
stream_map2
  (xs1, xs2) = $delay (
//
case+ !xs1 of
| x1 :: xs1 => (
  case+ !xs2 of
  | x2 :: xs2 => let
      val y =
        stream_map2$fwork<a1,a2><b> (x1, x2)
      // end of [val]
    in
      stream_cons (y, stream_map2<a1,a2><b> (xs1, xs2))
    end // end of [::]
  | stream_nil () => stream_nil ()
  ) // end of [::]
| stream_nil () => stream_nil ()
//
) // end of [stream_map2]

end // end of [local]

implement
{a1,a2}{b}
stream_map2_fun
  (xs1, xs2, f) = let
//
implement
stream_map2$fwork<a1,a2><b> (x1, x2) = f (x1, x2)
//
in
  stream_map2 (xs1, xs2)
end // end of [stream_map2_fun]

implement
{a1,a2}{b}
stream_map2_cloref
  (xs1, xs2, f) = let
//
implement
stream_map2$fwork<a1,a2><b> (x1, x2) = f (x1, x2)
//
in
  stream_map2 (xs1, xs2)
end // end of [stream_map2_cloref]

(* ****** ****** *)

local

#define :: stream_cons

in // in of [local]

implement{a}
stream_merge
  (xs10, xs20) = $delay (
//
case+ !xs10 of
| x1 :: xs1 => (
  case+ !xs20 of
  | x2 :: xs2 => let
      val sgn =
        stream_merge$cmp (x1, x2)
    in
      if sgn <= 0 then
        x1 :: stream_merge (xs1, xs20)
      else
        x2 :: stream_merge (xs10, xs2)
      // end of [if]
    end // end of [::]
  | stream_nil () => x1 :: xs1
  ) (* end of [::] *)
| stream_nil () => !xs20
) // end of [stream_merge]

end // end of [local]

implement{a}
stream_merge_fun
  (xs1, xs2, cmp) = let
//
implement
stream_merge$cmp<a> (x1, x2) = cmp (x1, x2)
//
in
  stream_merge (xs1, xs2)
end // end of [stream_merge_fun]

implement{a}
stream_merge_cloref
  (xs1, xs2, cmp) = let
//
implement
stream_merge$cmp<a> (x1, x2) = cmp (x1, x2)
//
in
  stream_merge (xs1, xs2)
end // end of [stream_merge_cloref]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [lazy.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [lazy.dats] *)
