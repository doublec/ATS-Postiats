(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Start Time: April, 2011
//
(* ****** ****** *)

staload "pats_basics.sats"
staload "pats_syntax.sats"
staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"

(* ****** ****** *)

fun v1al_is_true (v: v1al): bool
fun v1al_is_false (v: v1al): bool

fun do_e0xpact_assert
  (loc: location, v: v1al): void
fun do_e0xpact_error (loc: location, v: v1al): void
fun do_e0xpact_prerr (v: v1al): void

fun e1xp_eval (e: e1xp): v1al
fun e1xp_eval_if (knd: srpifkind, e: e1xp): v1al
fun e1xp_make_v1al (loc: location, v: v1al): e1xp

(* ****** ****** *)

fun e0xp_tr (x: e0xp): e1xp
fun e0xplst_tr (x: e0xplst): e1xplst

(* ****** ****** *)

fun e0fftaglst_tr
  (tags:  e0fftaglst): @(funcloopt, int, int, effcst)
// end of [e0fftaglst_tr]

(* ****** ****** *)

fun s0rt_tr (_: s0rt): s1rt
fun s0rtlst_tr (_: s0rtlst): s1rtlst
fun s0rtopt_tr (_: s0rtopt): s1rtopt

(* ****** ****** *)

fun s0arg_tr (x: s0arg): s1arg
fun s0arglst_tr (x: s0arglst): s1arglst
fun s0marg_tr (xs: s0marg): s1arglst
fun s0marglst_tr (xss: s0marglst): s1arglstlst

(* ****** ****** *)

fun a0srt_tr (x: a0srt): a1srt
fun a0msrt_tr (x: a0msrt): a1msrt
fun a0msrtlst_tr (x: a0msrtlst): a1msrtlst

(* ****** ****** *)

fun sp0at_tr (x: sp0at): sp1at

(* ****** ****** *)

fun s0exp_tr (x: s0exp): s1exp
fun s0explst_tr (x: s0explst): s1explst
fun s0expopt_tr (x: s0expopt): s1expopt

fun labs0exp_tr (x: labs0exp): labs1exp

fun s0rtext_tr (x: s0rtext): s1rtext

fun s0qualst_tr (xs: s0qualst): s1qualst
fun s0qualstlst_tr (xs: s0qualstlst): s1qualstlst

fun witht0ype_tr (x: witht0ype): witht1ype

(* ****** ****** *)

fun d0ecl_fixity_tr
  (dec: f0xty, ids: i0delst): void
fun d0ecl_nonfix_tr (ids: i0delst): void

(* ****** ****** *)

fun d0atsrtdec_tr (d: d0atsrtdec): d1atsrtdec

(* ****** ****** *)

fun s0rtdef_tr (x: s0rtdef): s1rtdef

fun s0tacst_tr (x: s0tacst): s1tacst
fun s0tacon_tr (x: s0tacon): s1tacon
fun s0tavar_tr (x: s0tavar): s1tavar

fun s0expdef_tr (x: s0expdef): s1expdef
fun s0aspdec_tr (x: s0aspdec): s1aspdec

(* ****** ****** *)

fun q0marg_tr (x: q0marg): q1marg
fun q0marglst_tr (x: q0marglst): q1marglst

(* ****** ****** *)

fun t0mpmarg_tr (x: t0mpmarg): t1mpmarg

(* ****** ****** *)

fun d0atcon_tr (d: d0atcon): d1atcon
fun d0atdec_tr (d: d0atdec): d1atdec
fun e0xndec_tr (d: e0xndec): e1xndec

(* ****** ****** *)

fun dcstextdef_tr (ext: Stropt): dcstextdef

(* ****** ****** *)

fun a0typ_tr (x: a0typ): s1exp
fun a0typlst_tr (x: a0typlst): s1explst

fun s0exparg_tr (loc: location, s0a: s0exparg): s1exparg

(* ****** ****** *)

fun d0cstdeclst_tr
  (isfun: bool, isprf: bool, ds: d0cstdeclst): d1cstdeclst
// end of [d0cstdeclst_tr]

(* ****** ****** *)

fun p0at_tr (x: p0at): p1at
fun p0atlst_tr (x: p0atlst): p1atlst

(* ****** ****** *)

fun d0exp_tr (x: d0exp): d1exp
fun d0explst_tr (xs: d0explst): d1explst
fun d0expopt_tr (xs: d0expopt): d1expopt

fun labd0exp_tr (x: labd0exp): labd1exp

fun d0exp_lams_dyn_tr (
  lamknd : int
, locopt : Option (location)
, fcopt : funcloopt
, lin : int
, args : f0arglst
, res : s0expopt
, efcopt : effcstopt
, body : d0exp
) : d1exp // end of [d0exp_lams_dyn_tr]

fun termination_metric_check
  (loc: location, is_met: bool, oefc: effcstopt): void
// end of [termination_metric_check]

(* ****** ****** *)

fun d0ecl_tr (_: d0ecl): d1ecl
fun d0eclist_tr (_: d0eclist): d1eclist

(* ****** ****** *)

(* end of [pats_trans1.sats] *)