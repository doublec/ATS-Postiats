(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: March, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [reference.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)

castfn ref_get_ptr
  {a:viewt@ype} (r: ref a):<> [l:agz] ptr (l)
castfn ref_get_view_ptr
  {a:viewt@ype} (r: ref a):<> [l:agz] (vbox (a @ l) | ptr l)
// end of [ref_get_view_ptr]

(* ****** ****** *)

(*
macdef ptr_of_ref = ref_get_ptr
*)

(* ****** ****** *)

fun{a:vt0p} ref (x: a):<> ref a
fun{a:vt0p} ref_make_elt (x: a):<> ref a

(* ****** ****** *)

fun{a:t0p} ref_get_elt (r: ref a):<!ref> a
fun{a:t0p} ref_set_elt (r: ref a, x: a):<!ref> void

fun{a:vt0p} ref_exch_elt (r: ref a, x: &a):<!ref> void

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [reference.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [reference.sats] *)