(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: April, 2013
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
S2E = "./pats_staexp2.sats"
typedef s2cst = $S2E.s2cst
typedef d2con = $S2E.d2con

(* ****** ****** *)

staload
D2E = "./pats_dynexp2.sats"
typedef d2cst = $D2E.d2cst
typedef d2var = $D2E.d2var
typedef d2varlst = $D2E.d2varlst
vtypedef d2varlst_vt = $D2E.d2varlst_vt
typedef d2varset = $D2E.d2varset
vtypedef d2varset_vt = $D2E.d2varset_vt

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

vtypedef funlablst2_vt = List_vt (funlablst)

(* ****** ****** *)

local

extern
fun funent_set_flablst_fin
(
  fent: funent, opt: Option (funlablst)
) : void = "ext#patsopt_funent_set_flablst_fin"

(*
fun
aux_funlab_get_flablst
  (flab: funlab): funlablst = let
//
val opt = funlab_get_funent (flab)
//
in
//
case+ opt of
| Some (fent) => funent_get_flablst (fent) | None () => list_nil ()
//
end // end of [aux_funlab_get_flablst]
*)
fun
aux_funlab_get_flablst
  (flab: funlab): funlablst = let
//
val-Some (fent) = funlab_get_funent (flab)
//
in
  funent_get_flablst (fent)
end // end of [aux_funlab_get_flablst]

fun auxtrclo
(
  flvl0: int
, xs: funlablst
, xss: funlablst2_vt
, res: funlabset_vt
) : funlabset_vt = let
//
(*
val () =
(
  println! ("auxtrclo: flvl0 = ", flvl0)
) (* end of [val] *)
*)
//
in
//
case+ xs of
| list_cons
    (x, xs) => let
//
// HX-2013-04-12:
// Note that flvl <= flvl0 holds!
//
    val flvl = funlab_get_level (x)
  in
    if flvl >= flvl0 then let
      val ismem = funlabset_vt_ismem (res, x)
    in
      if ismem then
      (
        auxtrclo (flvl0, xs, xss, res)
      ) else let
        val res = funlabset_vt_add (res, x)
        val xs_new = aux_funlab_get_flablst (x) 
//
(*
        val out = stdout_ref
        val () = fprintln! (out, "x = ", x)
        val () = fprintln! (out, "xs_new = ", xs_new)
*)
//
      in
        auxtrclo (flvl0, xs_new, list_vt_cons (xs, xss), res)
      end (* end of [if] *)
    end else let // parent
      val res =
        funlabset_vt_add (res, x) in auxtrclo (flvl0, xs, xss, res)
      // end of [val]
    end (* end of [if] *)
  end // end of [list_vt_cons]
| list_nil () =>
  (
    case+ xss of
    | ~list_vt_cons
        (xs, xss) => auxtrclo (flvl0, xs, xss, res)
    | ~list_vt_nil () => res
  ) (* end of [list_vt_nil] *)
//
end // end of [auxtrclo]

in (* in of [local] *)

implement
funent_eval_flablst
  (fent) = let
//
val opt = funent_get_flablst_fin (fent)
//
in
//
case+ opt of
| Some (fls) => fls
| None () => fls where
  {
    val fl0 = funent_get_lab (fent)
    val flvl = funent_get_level (fent)
    val xs = funent_get_flablst (fent)
    val xss = list_vt_nil () // : funlablst2_vt
    val res = funlabset_vt_nil ()
    val res = funlabset_vt_add (res, fl0)
    val res = auxtrclo (flvl, xs, xss, res)
    val fls = funlabset_vt_listize_free (res)
    val fls = list_of_list_vt (fls)
    val () = funent_set_flablst_fin (fent, Some (fls))
  } // end of [None]
//
end // end of [funent_eval_flablst]

end // end of [local]

(* ****** ****** *)

local

extern
fun funent_set_d2envlst_fin
(
  fent: funent, opt: Option (d2envlst)
) : void = "ext#patsopt_funent_set_d2envlst_fin"

(*
fun
aux_funlab_get_d2envlst
  (flab: funlab): d2envlst = let
//
val opt = funlab_get_funent (flab)
//
in
//
case+ opt of
| Some (fent) => funent_get_d2envlst (fent) | None () => list_nil ()
//
end // end of [aux_funlab_get_d2envlst]
*)
fun
aux_funlab_get_d2envlst
  (flab: funlab): d2envlst = let
//
val-Some (fent) = funlab_get_funent (flab)
//
in
  funent_get_d2envlst (fent)
end // end of [aux_funlab_get_d2envlst]

fun auxd2es
(
  d2es: d2envlst
, vbmap: vbindmap, res: d2envset_vt
) : d2envset_vt = let
in
//
case+ d2es of
//
| list_cons
    (d2e, d2es) => let
(*
//
// HX-2013-04: [d2e] cannot be in [vbmap]
//
    val d2v = d2env_get_var (d2e)
    val opt = $D2E.d2varmap_search (vbmap, d2v)
    val res =
    (
      case+ opt of
      | ~None_vt _ => d2envset_vt_add (res, d2e) | ~Some_vt _ => res
    ) : d2envset_vt
*)
    val res = d2envset_vt_add (res, d2e)
  in
    auxd2es (d2es, vbmap, res)
  end (* end of [list_cons] *)
//
| list_nil () => res
//
end // end of [auxd2es]

//
// HX-2013:-04:
// [vbmap] is not actually used.
//
fun auxtrclo
(
  fls: funlablst
, vbmap: vbindmap, res: d2envset_vt
) : d2envset_vt = let
in
//
case+ fls of
| list_cons
    (fl, fls) => let
    val d2es =
      aux_funlab_get_d2envlst (fl)
    // end of [val]
    val res = auxd2es (d2es, vbmap, res)
  in
    auxtrclo (fls, vbmap, res)
  end (* end of [list_vt_cons] *)
| list_nil () => res
//
end // end of [auxtrclo]

in (* in of [local] *)

implement
funent_eval_d2envlst
  (fent) = let
//
val opt = funent_get_d2envlst_fin (fent)
//
in
//
case+ opt of
| Some (d2es) => d2es
| None () => d2es where
  {
    val fls0 = funent_eval_flablst (fent)
    val vbmap = funent_get_vbindmap (fent)
    val d2es = auxtrclo (fls0, vbmap, d2envset_vt_nil ())
    val d2es = d2envset_vt_listize_free (d2es)
    val d2es = list_of_list_vt (d2es)
    val () = funent_set_d2envlst_fin (fent, Some (d2es))
  } // end of [None]
//
end // end of [funent_eval_d2varlst]

end // end of [local]

(* ****** ****** *)

implement
funlab_is_envful (flab) = let
//
val opt = funlab_get_funent (flab)
val d2es =
(
case+ opt of
| Some (fent) => funent_eval_d2envlst (fent) | None () => list_nil ()
) : d2envlst // end of [val]
//
in
  list_is_cons (d2es)
end // end of [funlab_is_envful]

(* ****** ****** *)

implement
funlab_get_type_fullarg (flab) = let
//
fun aux
(
  d2es: d2envlst, hses: hisexplst
) : hisexplst = let
in
//
case+ d2es of
| list_cons
    (d2e, d2es) => let
    val hse = d2env_get_type (d2e)
  in
    list_cons (hse, aux (d2es, hses))
  end (* end of [list_cons] *)
| list_nil () => hses
//
end (* end of [aux] *)
//
val opt = funlab_get_funent (flab)
val d2es =
(
case+ opt of
| Some (fent) => funent_eval_d2envlst (fent) | None () => list_nil ()
) : d2envlst // end of [val]
//
val hses = funlab_get_type_arg (flab)
//
in
  aux (d2es, hses)
end // end of [funlab_get_type_fullarg]

(* ****** ****** *)

local

(*
fun funent_varbindmap_initize (fent: funent): void
fun funent_varbindmap_uninitize (fent: funent): void
fun the_funent_varbindmap_find (d2v: d2var): Option_vt (primval)
*)

vtypedef
vbindlst_vt = List_vt @(d2var, primval)
vtypedef
vbindmap_vt = $D2E.d2varmap_vt (primval)

val the_vbmap = let
  val map = $D2E.d2varmap_vt_nil () in ref<vbindmap_vt> (map)
end // end of [val]

in (* in of [local] *)

implement
funent_varbindmap_initize
  (fent) = let
//

fun auxmap
(
  map: &vbindmap_vt, vbs: vbindlst_vt
) : void = let
in
//
case+ vbs of
| ~list_vt_cons
    (vb, vbs) => let
    val _(*replaced*) = $D2E.d2varmap_vt_insert (map, vb.0, vb.1)
  in
    auxmap (map, vbs)
  end (* end of [list_cons] *)
| ~list_vt_nil () => ()
//
end // end of [auxmap]
//
fun auxenv
(
  map: &vbindmap_vt, loc0: location, i: int, d2es: d2envlst
) : void = let
in
//
case+ d2es of
| list_cons
    (d2e, d2es) => let
    val d2v = d2env_get_var (d2e)
    val hse = d2env_get_type (d2e)
    val argenv = primval_argenv (loc0, hse, i)
    val _(*replaced*) = $D2E.d2varmap_vt_insert (map, d2v, argenv)
  in
    auxenv (map, loc0, i+1, d2es)
  end (* end of [list_cons] *)
| list_nil () => ()
//
end // end of [auxenv]
//
val loc0 = funent_get_loc (fent)
//
val vbmap = funent_get_vbindmap (fent)
//
val
(
  vbox pf | p
) = ref_get_view_ptr (the_vbmap)
//
val () = $effmask_ref (auxmap (!p, $D2E.d2varmap_listize (vbmap)))
val () = $effmask_ref (auxenv (!p, loc0, 0, funent_eval_d2envlst (fent)))
//
in
  (*nothing*)
end // end of [funent_varbindmap_initize]

implement
funent_varbindmap_uninitize
  (fent) = let
//
val
(
  vbox pf | p
) = ref_get_view_ptr (the_vbmap)
val () = $D2E.d2varmap_vt_free (!p)
val () = !p := $D2E.d2varmap_vt_nil ()
//
in
  // nothing
end // end of [the_funent_varbindmap_uninitize]

implement
the_funent_varbindmap_find
  (d2v) = let
//
val (vbox pf | p) = ref_get_view_ptr (the_vbmap)
//
in
  $D2E.d2varmap_vt_search (!p, d2v)
end // end of [the_funent_varbindmap_find]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_environ.dats] *)
