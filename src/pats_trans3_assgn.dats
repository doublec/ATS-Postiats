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
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
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
// Start Time: April, 2012
//
(* ****** ****** *)

staload
LOC = "pats_location.sats"
stadef location = $LOC.location

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_selab"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_stacst2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp2_util.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

local

fun aux1 (
  loc0: location
, s2f0: s2hnf
, d3e_l: d3exp
, d2ls: d2lablst
, d2e_r: d2exp
) : d3exp = let
  val opt = un_s2exp_ptr_addr_type (s2f0)
in
//
case+ opt of
| ~Some_vt (s2a) => let
  in
    exitloc (1)
  end // end of [Some_vt]
| ~None_vt () => aux2 (loc0, s2f0, d3e_l, d2ls, d2e_r)
//
end // end of [aux1]

and aux2 (
  loc0: location
, s2f0: s2hnf
, d3e_l: d3exp
, d2ls: d2lablst
, d2e_r: d2exp
) : d3exp = let
  val opt = un_s2exp_ref_viewt0ype_type (s2f0)
in
//
case+ opt of
| ~Some_vt (s2e) => let
    val d3ls = d2lablst_trup (d2ls)
    var linrest: int = 0
    val (s2e_sel, s2ps) =
      s2exp_get_dlablst_linrest (loc0, s2e, d3ls, linrest)
    // end of [val]
    val () = trans3_env_add_proplst_vt (loc0, s2ps)
    val s2e_sel = s2exp_hnfize (s2e_sel)
    val islin = s2exp_is_lin (s2e_sel)
    val () = if islin then {
      val () = prerr_error3_loc (loc0)
      val () = prerr ": a linear component of a given reference is abandoned."
      val () = prerr_newline ()
      val () = the_trans3errlst_add (T3E_d3exp_trup_deref_linsel (d3e_l, d3ls))
    } // end of [val]
    val d3e_r = d2exp_trdn (d2e_r, s2e_sel)
  in
    d3exp_assgn_ref (loc0, d3e_l, d3ls, d3e_r)
  end // end of [Some_vt]
| ~None_vt () => aux3 (loc0, s2f0, d3e_l, d2ls, d2e_r)
//
end // end of [aux2]

and aux3 (
  loc0: location
, s2f0: s2hnf
, d3e_l: d3exp
, d2ls: d2lablst
, d2e_r: d2exp
) : d3exp = let
in
  d3exp_err (loc0)
end // end of [aux3]

in // in of [local]

implement
d2exp_trup_assgn_deref
  (loc0, d2e_l, d2ls, d2e_r) = let
// (*
val () = (
  print "d2exp_trup_deref: d2e_l = "; print_d2exp (d2e_l); print_newline ();
  print "d2exp_trup_deref: d2e_r = "; print_d2exp (d2e_r); print_newline ();
) // end of [val]
// *)
val d3e_l = d2exp_trup (d2e_l)
val () = d3exp_open_and_add (d3e_l)
val s2e0 = d3exp_get_type (d3e_l)
val s2f0 = s2exp2hnf_cast (s2e0)
//
in
  aux1 (loc0, s2f0, d3e_l, d2ls, d2e_r)
end // end of [d2exp_trup_deref]

end // end of [local]

(* ****** ****** *)

implement
d2exp_trup_assgn
  (loc0, d2e_l, d2e_r) = let
  val d2lv = d2exp_lvalize (d2e_l)
in
//
case+ d2lv of
| D2LVALderef (d2e_l, d2ls) =>
    d2exp_trup_assgn_deref (loc0, d2e_l, d2ls, d2e_r)
| _ => exitloc (1)
//
end // end of [d2exp_trup_assgn]


(* ****** ****** *)

(* end of [pats_trans3_assgn.dats] *)