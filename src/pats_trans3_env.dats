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
// Start Time: October, 2011
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_exp_up"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_stacst2.sats"
staload "pats_patcst2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

staload "pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
c3str_prop
  (loc, s2e) = '{
  c3str_loc= loc
, c3str_kind= C3STRKINDmain
, c3str_node= C3STRprop (s2e)
} // end of [c3str_prop]

implement
c3str_itmlst
  (loc, knd, s3is) = '{
  c3str_loc= loc
, c3str_kind= knd
, c3str_node= C3STRitmlst (s3is)
} // end of [c3str_itmlst]

implement
c3str_case_exhaustiveness
  (loc, casknd, p2tcs) = '{
  c3str_loc= loc
, c3str_kind= C3STRKINDcase_exhaustiveness (casknd, p2tcs)
, c3str_node= C3STRprop (s2exp_bool (false))
} // end of [c3str_case_exhaustiveness]

(* ****** ****** *)

implement
h3ypo_prop
  (loc, s2p) = '{
  h3ypo_loc= loc, h3ypo_node = H3YPOprop (s2p)
} // end of [h3ypo_prop]

implement
h3ypo_bind
  (loc, s2v1, s2e2) = '{
  h3ypo_loc= loc, h3ypo_node = H3YPObind (s2v1, s2e2)
} // end of [h3ypo_bind]

implement
h3ypo_eqeq
  (loc, s2e1, s2e2) = '{
  h3ypo_loc= loc, h3ypo_node = H3YPOeqeq (s2e1, s2e2)
} // end of [h3ypo_eqeq]

(* ****** ****** *)

implement
s2exp_Var_make_srt
  (loc, s2t) = let
  val s2V = s2Var_make_srt (loc, s2t)
  val () = trans3_env_add_sVar (s2V)
(*
  val () = s2Var_set_sVarset (s2V, the_s2Varset_env_get_prev ())
*)
in
  s2exp_Var (s2V)
end // end of [s2exp_Var_make_srt]

implement
s2exp_Var_make_var (loc, s2v) = let
(*
  val () = begin
    print "s2exp_Var_make_var: s2v = "; print_s2var s2v; print_newline ()
  end // end of [val]
*)
  val s2V = s2Var_make_var (loc, s2v)
(*
  val () = s2Var_set_sVarset (s2V, the_s2Varset_env_get_prev ())
*)
(*
  val () = begin
    print "s2exp_Var_make_var: s2V = "; print s2V; print_newline ()
  end // end of [val]
*)
  val () = trans3_env_add_sVar (s2V)
in
  s2exp_Var (s2V)
end // end of [s2exp_Var_make_var]


(* ****** ****** *)

local

fun stasub_s2varlst_instantiate_none (
  sub: &stasub
, locarg: location, s2vs: s2varlst
, err: &int // HX: [err] is not used
) : void = let
//
macdef loop = stasub_s2varlst_instantiate_none
//
in
//
case+ s2vs of
| list_cons (s2v, s2vs) => let
    val s2e =
      s2exp_Var_make_var (locarg, s2v)
    // end of [val]
    val () = stasub_add (sub, s2v, s2e)
  in
    loop (sub, locarg, s2vs, err)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [stasub_s2varlst_instantiate_none]

fun stasub_s2varlst_instantiate_some (
  sub: &stasub
, locarg: location
, s2vs: s2varlst, s2es: s2explst
, err: &int
) : void = let
//
macdef loop = stasub_s2varlst_instantiate_some
//
fun auxerr1 (
  locarg: location, serr: int
) : void = let
  val () = prerr_error3_loc (locarg)
  val () = filprerr_ifdebug "stasub_s2varlst_instantiate_some"
  val () = prerr ": static arity mismatch"
  val () = if serr > 0 then prerr ": more arguments are expected."
  val () = if serr < 0 then prerr ": less arguments are expected."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_s2varlst_instantiate_arity (locarg, serr))
end // end of [auxerr1]
fun auxerr2 (
  locarg: location, s2t1: s2rt, s2t2: s2rt
) : void = let
  val () = prerr_error3_loc (locarg)
  val () = filprerr_ifdebug "stasub_s2varlst_instantiate_some"
  val () = prerr ": mismatch of sorts:\n"
  val () = prerr "the needed sort is ["
  val () = prerr_s2rt (s2t1)
  val () = prerr "];"
  val () = prerr_newline ()
  val () = prerr "the actual sort is ["
  val () = prerr_s2rt (s2t2)
  val () = prerr "]."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_s2varlst_instantiate_srtck (locarg, s2t1, s2t2))
end // end of [auxerr2]
//
in
//
case+ s2vs of
| list_cons (s2v, s2vs) => (
  case+ s2es of
  | list_cons (s2e, s2es) => let
      val s2t1 = s2var_get_srt (s2v)
      val s2t2 = s2e.s2exp_srt
      val ismat = s2rt_ltmat1 (s2t2, s2t1)
    in
      if ismat then let
        val () = stasub_add (sub, s2v, s2e)
      in
        loop (sub, locarg, s2vs, s2es, err)
      end else let
        val () = err := err + 1
        val () = auxerr2 (locarg, s2t1, s2t2)
        val s2e = s2exp_err (s2t1)
        val () = stasub_add (sub, s2v, s2e)
      in
        loop (sub, locarg, s2vs, s2es, err)
      end (* end of [if] *)
    end // end of [list_cons]
  | list_nil () => let
      val () = err := err + 1
      val () = auxerr1 (locarg, 1) // HX: more arguments expected
    in
      // nothing
    end // end of [list_nil]
  ) // end of [list_cons]
| list_nil () => (
  case+ s2es of
  | list_cons _ => let
      val () = err := err + 1
      val () = auxerr1 (locarg, ~1) // HX: less arguments expected
    in
      // nothing
    end // end of [list_cons]
  | list_nil () => ()
  ) // end of [list_nil]
end // end of [stasub_s2varlst_instantiate_some]

fun stasub_s2varlst_instcollect (
  sub: &stasub
, locarg: location
, s2vs: s2varlst
, res: s2explst_vt
) : s2explst_vt = let
//
macdef loop = stasub_s2varlst_instcollect
//
in
//
case+ s2vs of
| list_cons (s2v, s2vs) => let
(*
    val () = (
      print "stasub_addsvs: s2v = "; print_s2var s2v; print_newline ()
    ) // end of [val]
*)
    val s2e =
      s2exp_Var_make_var (locarg, s2v)
    // end of [val]
    val () = stasub_add (sub, s2v, s2e)
    val res = list_vt_cons (s2e, res)
  in
    loop (sub, locarg, s2vs, res)
  end // end of [list_cons]
| list_nil () => list_vt_reverse (res)
//
end // end of [stasub_s2varlst_instcollect]

in // in of [local]

implement
s2exp_exiuni_instantiate_all
  (knd, s2e0, locarg, err) = let // HX: [err] is not used
//
fun loop (
  sub: &stasub
, s2f: s2hnf
, s2ps_res: &s2explst_vt
, err: &int
) :<cloref1> s2exp = let
  val s2e = s2hnf2exp (s2f)
  var s2vs: s2varlst
  and s2ps: s2explst
  var s2e1: s2exp // scope
  val ans = uns2exp_exiuni (knd, s2e, s2vs, s2ps, s2e1)
in
//
case+ ans of
| true => let
    // HX: [sub] should be properly extended first
    val () = stasub_s2varlst_instantiate_none (sub, locarg, s2vs, err)
    val s2ps = s2explst_subst_vt (sub, s2ps)
    val () = s2ps_res := list_vt_reverse_append (s2ps, s2ps_res)
    val s2f1 = s2exp2hnf (s2e1)
  in
    loop (sub, s2f1, s2ps_res, err)
  end // end of [S2Euni]
| false => s2exp_subst (sub, s2e)
//
end // end of [loop]
//
var sub
  : stasub = stasub_make_nil ()
// end of [var]
val s2f0 = s2exp2hnf (s2e0)
var s2ps_res: s2explst_vt = list_vt_nil ()
val s2e_res = loop (sub, s2f0, s2ps_res, err)
val () = stasub_free (sub)
val s2ps_res = list_vt_reverse (s2ps_res)
//
in
  (s2e_res, s2ps_res)
end // end of [s2exp_uni_instantiate_all]

implement
s2exp_exi_instantiate_all
  (s2e0, locarg, err) =
  s2exp_exiuni_instantiate_all (0, s2e0, locarg, err)
// end of [s2exp_exi_instantiate_all]
implement
s2exp_uni_instantiate_all
  (s2e0, locarg, err) =
  s2exp_exiuni_instantiate_all (1, s2e0, locarg, err)
// end of [s2exp_uni_instantiate_all]

(* ****** ****** *)

implement
s2exp_uni_instantiate_sexparglst
  (s2e0, s2as, err) = let
//
fun auxerr (
  locarg: location
) : void = let
  val () = prerr_error3_loc (locarg)
  val () = filprerr_ifdebug "s2exp_uni_instantiate_sexparglst"
  val () = prerr ": the static application is overly done."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_s2varlst_instantiate_napp (locarg, 1))
end (* end of [auxerr] *)
//
fun loop (
  sub: &stasub
, s2f: s2hnf
, s2ps_res: &s2explst_vt
, s2as: s2exparglst
, err: &int
) : s2exp = let
  val s2e = s2hnf2exp (s2f)
in
//
case+ s2as of
| list_cons (s2a, s2as1) => let
    val locarg = s2a.s2exparg_loc
  in
    case+ s2a.s2exparg_node of
    | S2EXPARGall () => (
      case+ s2e.s2exp_node of
      | S2Euni (s2vs, s2ps, s2e1) => let
          // HX: [sub] should be properly extended first
          val () = stasub_s2varlst_instantiate_none (sub, locarg, s2vs, err)
          val s2ps = s2explst_subst_vt (sub, s2ps)
          val () = s2ps_res := list_vt_reverse_append (s2ps, s2ps_res)
          val s2f1 = s2exp2hnf (s2e1)
        in
          loop (sub, s2f1, s2ps_res, s2as, err)
        end
      | _ => loop (sub, s2f, s2ps_res, s2as1, err)
      ) // end of [S2EXPARGall]
    | S2EXPARGone () => (
      case+ s2e.s2exp_node of
      | S2Euni (s2vs, s2ps, s2e1) => let
          // HX: [sub] should be properly extended first
          val () = stasub_s2varlst_instantiate_none (sub, locarg, s2vs, err)
          val s2ps = s2explst_subst_vt (sub, s2ps)
          val () = s2ps_res := list_vt_reverse_append (s2ps, s2ps_res)
          val s2f1 = s2exp2hnf (s2e1)
        in
          loop (sub, s2f1, s2ps_res, s2as1, err)
        end // end of [S2Euni]
      | _ => let
          val () = err := err + 1
          val () = auxerr (locarg)
        in
          loop (sub, s2f, s2ps_res, s2as1, err)
        end (* end of [_] *)
      ) // end of [S2EXPARGone]
    | S2EXPARGseq (s2es) => (
      case+ s2e.s2exp_node of
      | S2Euni (s2vs, s2ps, s2e1) => let
          // HX: [sub] should be properly extended first
          val () = stasub_s2varlst_instantiate_some (sub, locarg, s2vs, s2es, err)
          val s2ps = s2explst_subst_vt (sub, s2ps)
          val () = s2ps_res := list_vt_reverse_append (s2ps, s2ps_res)
          val s2f1 = s2exp2hnf (s2e1)
        in
          loop (sub, s2f1, s2ps_res, s2as1, err)
        end // end of [S2Euni]
      | _ => let
          val () = err := err + 1
          val () = auxerr (locarg)
        in
          loop (sub, s2f, s2ps_res, s2as1, err)
        end (* end of [_] *)
      ) // end of [S2EXPARGseq]
  end // end of [list_cons]
| list_nil () => let
    val s2e = s2hnf2exp (s2f) in s2exp_subst (sub, s2e)
  end // end of [list_nil]
//
end // end of [loop]
//
var sub
  : stasub = stasub_make_nil ()
// end of [var]
val s2f0 = s2exp2hnf (s2e0)
var s2ps_res: s2explst_vt = list_vt_nil ()
val s2e_res = loop (sub, s2f0, s2ps_res, s2as, err)
val () = stasub_free (sub)
val s2ps_res = list_vt_reverse (s2ps_res)
//
in
  (s2e_res, s2ps_res)
end // end of [s2exp_uni_instantiate_sexparglst]

(* ****** ****** *)

implement
s2exp_tmp_instantiate_rest
  (s2e_tmp, locarg, s2qs, err) = let
//
fun loop (
  locarg: location
, sub: &stasub
, s2qs: s2qualst
, t2mas: t2mpmarglst_vt
, err: &int // HX: unused
) : t2mpmarglst_vt = let
in
  case+ s2qs of
  | list_cons (s2q, s2qs) => let
      val s2vs = s2q.s2qua_svs
      val () = assertloc (list_is_nil (s2q.s2qua_sps))
      val s2es = stasub_s2varlst_instcollect (sub, locarg, s2vs, list_vt_nil)
      val t2ma = t2mpmarg_make (locarg, (l2l)s2es)
      val t2mas = list_vt_cons (t2ma, t2mas)
    in
      loop (locarg, sub, s2qs, t2mas, err)
    end // end of [list_cons]
  | list_nil () => list_vt_reverse (t2mas)
end // end of [loop]
//
var sub
  : stasub = stasub_make_nil ()
// end of [var]
val t2mas = loop (locarg, sub, s2qs, list_vt_nil, err)
val s2e_res = s2exp_subst (sub, s2e_tmp)
val () = stasub_free (sub)
//
in
  (s2e_res, (l2l)t2mas)
end // end of [s2exp_tmp_instantiate_rest]

(* ****** ****** *)

implement
s2exp_tmp_instantiate_tmpmarglst
  (s2e_tmp, locarg, s2qs, t2mas, err) = let
//
fun auxerr (
  locarg: location
) : void = let
  val () = prerr_error3_loc (locarg)
  val () = filprerr_ifdebug "s2exp_tmp_instantiate_tmpmarglst"
  val () = prerr ": the template instantiation is overly done."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_s2varlst_instantiate_napp (locarg, 1))
end (* end of [auxerr] *)
//
var locarg: location = locarg
//
fun auxsome (
  sub: &stasub
, locarg: &location
, s2qs: s2qualst, t2mas: t2mpmarglst
, err: &int
) : s2qualst = let
in
//
case+ s2qs of
| list_cons (s2q, s2qs1) => (
  case+ t2mas of
  | list_cons (t2ma, t2mas) => let
      val s2vs = s2q.s2qua_svs
      val () = assertloc (list_is_nil (s2q.s2qua_sps))
      val () = locarg := t2ma.t2mpmarg_loc
      val s2es = t2ma.t2mpmarg_arg
      val () = stasub_s2varlst_instantiate_some (sub, locarg, s2vs, s2es, err)
    in
      auxsome (sub, locarg, s2qs1, t2mas, err)
    end // end of [list_cons]
  | list_nil () => s2qs
  ) // end of [list_cons]
| list_nil () => (
  case+ t2mas of
  | list_cons (t2ma, t2mas) => let
      val () = err := err + 1
      val () = auxerr (locarg)
      val () = locarg := t2ma.t2mpmarg_loc
    in
      auxsome (sub, locarg, s2qs, t2mas, err)
    end // end of [list_cons]
  | list_nil () => list_nil ()
  ) // end of [list_nil]
//
end // end of [auxsome]
//
var sub
  : stasub = stasub_make_nil ()
// end of [var]
val s2qs = auxsome (sub, locarg, s2qs, t2mas, err)
val s2e_res = s2exp_subst (sub, s2e_tmp)
val () = stasub_free (sub)
//
in
//
case+ s2qs of
| list_cons _ => let
    val locarg = $LOC.location_rightmost (locarg)
    val (s2e2_res, t2mas2) = s2exp_tmp_instantiate_rest (s2e_res, locarg, s2qs, err)
  in
    (s2e2_res, list_append (t2mas, t2mas2))
  end // end of [list_cons]
| list_nil () => (s2e_res, t2mas)
end // end of [s2exp_tmp_instantiate_tmpmarglst]

end // end of [local]

(* ****** ****** *)

extern
fun the_s2Varset_env_push (): void
extern
fun the_s2Varset_env_pop (): s2Varset
extern
fun the_s2Varset_env_get (): s2Varset
extern
fun the_s2Varset_env_add (x: s2Var): void

local

viewtypedef s2Varsetlst_vt = List_vt (s2Varset)
val s2Varset_nil = s2Varset_make_nil ()
val the_s2Varset = ref_make_elt<s2Varset> (s2Varset_nil)
val the_s2Varsetlst = ref_make_elt<s2Varsetlst_vt> (list_vt_nil ())

in // in of [local]

implement
the_s2Varset_env_get () = !the_s2Varset

implement
the_s2Varset_env_add (x) = begin
  !the_s2Varset := s2Varset_add (!the_s2Varset, x)
end // end of [the_s2Varset_env_add]

implement
the_s2Varset_env_push () = let
  val xs = !the_s2Varset
  val () = !the_s2Varset := s2Varset_nil
  val (vbox pf | pp) = ref_get_view_ptr (the_s2Varsetlst)
  val () = !pp := list_vt_cons (xs, !pp)
in
  // nothing
end // end of [the_s2Varset_env_push]

implement
the_s2Varset_env_pop () = let
  val s2Vs = let
    val (vbox pf | pp) = ref_get_view_ptr (the_s2Varsetlst)
  in
    case+ !pp of
    | ~list_vt_cons (xs, xss) => let val () = !pp := xss in xs end
    | list_vt_nil () => let prval () = fold@ (!pp) in s2Varset_nil end
  end : s2Varset
  val xs = !the_s2Varset
  val () = !the_s2Varset := s2Vs
in
  xs
end // end of [the_s2Varset_env_pop]

end // end of [local]

(* ****** ****** *)

extern
fun the_s2varbindmap_pop (): void
extern
fun the_s2varbindmap_push (): void
extern
fun the_s2varbindmap_search (s2v: s2var): Option_vt (s2exp)
extern
fun the_s2varbindmap_insert (s2v: s2var, s2e: s2exp): void

local

val the_s2varbindmap =
  ref_make_elt<s2varbindmap> (s2varbindmap_make_nil ())
// end of [val]

viewtypedef s2varlstlst_vt = List_vt (s2varlst_vt)
val the_s2varlst = ref_make_elt<s2varlst_vt> (list_vt_nil)
val the_s2varlstlst = ref_make_elt<s2varlstlst_vt> (list_vt_nil)

in // in of [local]

implement
the_s2varbindmap_pop () = let
  fun auxrmv (
    map: &s2varbindmap, s2vs: s2varlst_vt
  ) : void =
    case+ s2vs of
    | ~list_vt_cons (s2v, s2vs) => let
        val () = s2varbindmap_remove (map, s2v) in auxrmv (map, s2vs)
      end // end of [list_vt_cons]
    | ~list_vt_nil () => ()
  // end of [auxrmv]
  val s2vs = let
    val (vbox pf | pp) = ref_get_view_ptr (the_s2varlstlst)
  in
    case+ !pp of
    | ~list_vt_cons (xs, xss) => let val () = !pp := xss in xs end
    | list_vt_nil () => let prval () = fold@ (!pp) in list_vt_nil end
  end : s2varlst_vt
  val s2vs = xs where {
    val (vbox pf | p) = ref_get_view_ptr (the_s2varlst)
    val xs = !p
    val () = !p := s2vs
  } // end of [val]
  val () = let
    val (vbox pf | p) = ref_get_view_ptr (the_s2varbindmap)
  in
    $effmask_ref (auxrmv (!p, s2vs))
  end // end of [val]
in
  // nothing
end // end of [the_s2varbindmap_pop]

implement
the_s2varbindmap_push () = let
  val s2vs = s2vs where {
    val (vbox pf | p) = ref_get_view_ptr (the_s2varlst)
    val s2vs = !p
    val () = !p := list_vt_nil ()
  } // end of [val]
  val (vbox pf | pp) = ref_get_view_ptr (the_s2varlstlst)
  val () = !pp := list_vt_cons (s2vs, !pp)
in
  // nothing
end // end of [the_s2varbindmap_push]

implement
fprint_the_s2varbindmap (out) = let
  fun aux (
    out: FILEref, kis: List_vt @(s2var, s2exp)
  ) : void =
    case+ kis of
    | ~list_vt_cons (ki, kis) => let
        val () = fprint_s2var (out, ki.0)
        val () = fprint_string (out, " -> ")
        val () = fprint_s2exp (out, ki.1)
        val () = fprint_newline (out)
      in
        aux (out, kis)
      end // end of [list_vt_cons]
    | ~list_vt_nil () => ()
  // end of [aux]
  val kis = let
    val (vbox pf | p) = ref_get_view_ptr (the_s2varbindmap)
  in
    $effmask_ref (s2varbindmap_listize (!p))
  end // end of [val]
in
  aux (out, kis)
end // end of [fprint_the_s2varbindmap]

implement
the_s2varbindmap_search (s2v) = let
  val (vbox pf | p) = ref_get_view_ptr (the_s2varbindmap)
in
  $effmask_ref (s2varbindmap_search (!p, s2v))
end // end of [the_s2varbindmap_search]

implement
the_s2varbindmap_insert (s2v, s2e) = let
//
val () = let
  val (vbox pf | p) = ref_get_view_ptr (the_s2varlst)
in
  !p := list_vt_cons (s2v, !p)
end // end of [val]
//
val () = let
  val (vbox pf | p) = ref_get_view_ptr (the_s2varbindmap)
in
  $effmask_ref (s2varbindmap_insert (!p, s2v, s2e))
end // end of [val]
//
in
  (* nothing *)
end // end of [the_s2varbindmap_insert]

end // end of [local]

(* ****** ****** *)
//
// HX: it is declared in [pats_staexp2_util.sats]
//
implement
s2exp_hnfize_flag_svar
  (s2e0, s2v, flag) = let
// (*
val () = (
  print "s2exp_hnfize_flag_svar: s2v = "; print_s2var (s2v); print_newline ()
) // end of [val]
// *)
val ans = the_s2varbindmap_search (s2v)
//
in
  case+ ans of
  | ~Some_vt s2e => let
      val () = flag := flag + 1 in s2exp_hnfize (s2e)
    end // end of [Some_vt]
  | ~None_vt () => s2e0 // end of [None_vt]
end // end of [s2exp_hnfize_flag_svar]

(* ****** ****** *)

extern
fun the_s3itmlst_env_push (): void
extern
fun the_s3itmlst_env_pop (): s3itmlst_vt
extern
fun the_s3itmlst_env_add (s3i: s3itm): void

local

viewtypedef s3itmlstlst_vt = List_vt (s3itmlst_vt)
val the_s3itmlst = ref_make_elt<s3itmlst_vt> (list_vt_nil ())
val the_s3itmlstlst = ref_make_elt<s3itmlstlst_vt> (list_vt_nil ())

in // in of [local]

implement
the_s3itmlst_env_push () = let
  val s3is = s3is where {
    val (vbox pf | p) = ref_get_view_ptr (the_s3itmlst)
    val s3is = !p
    val () = !p := list_vt_nil ()
  } // end of [val]
  val () = let
    val (vbox pf | pp) = ref_get_view_ptr (the_s3itmlstlst)
  in
    !pp := list_vt_cons (s3is, !pp)
  end // end of [val]
in
  // nothing
end // end of [the_s3itmlst_env_push]

implement
the_s3itmlst_env_pop () = let
  val s3is = let
    val (vbox pf | pp) = ref_get_view_ptr (the_s3itmlstlst)
  in
    case+ !pp of
    | ~list_vt_cons (xs, xss) => let val () = !pp := xss in xs end
    | list_vt_nil () => let prval () = fold@ (!pp) in list_vt_nil end
  end : s3itmlst_vt
  val s3is = xs where {
    val (vbox pf | p) = ref_get_view_ptr (the_s3itmlst)
    val xs = !p
    val () = !p := s3is
  } // end of [val]
in
  s3is
end // end of [the_s3itmlst_env_pop]

implement
the_s3itmlst_env_add (s3i) = let
  val (vbox pf | p) = ref_get_view_ptr (the_s3itmlst)
in
  !p := list_vt_cons (s3i, !p)
end // end of [the_s3itmlst_env_add]

implement
fprint_the_s3itmlst (out) = let
  val s3is = let
    val (vbox pf | p) = ref_get_view_ptr (the_s3itmlst)
  in
    $UN.castvwtp1 {s3itmlst} (!p)
  end // end of [val]
in
  fprint_s3itmlst (out, s3is)
end // end of [fprint_the_s3itmlst]

implement
fprint_the_s3itmlstlst (out) = let
  val s3iss = let
    val (vbox pf | pp) = ref_get_view_ptr (the_s3itmlstlst)
  in
    $UN.castvwtp1 {s3itmlstlst} (!pp)
  end // end of [val]
in
  fprint_s3itmlstlst (out, s3iss)
end // end of [fprint_the_s3itmlstlst]

end // end of [local]
  
(* ****** ****** *)

implement
trans3_env_add_svar
  (s2v) = () where {
  val s3i = S3ITMsvar (s2v)
  val () = the_s3itmlst_env_add (s3i)
} // end of [trans3_env_add_svar]

implement
trans3_env_add_svarlst (s2vs) =
  list_app_fun<s2var> (s2vs, trans3_env_add_svar)
// end of [trans3_env_add_svarlst]

implement
trans3_env_add_sVar
  (s2V) = () where {
  val s3i = S3ITMsVar (s2V)
(*
  val () = the_s2Varset_env_add (s2V)
*)
  val () = the_s3itmlst_env_add (s3i)
} // end of [trans3_env_add_sVar]

implement
trans3_env_add_sVarlst (s2Vs) =
  list_app_fun<s2Var> (s2Vs, trans3_env_add_sVar)
// end of [trans3_env_add_sVarlst]

implement
trans3_env_add_cstr
  (c3s) = () where {
  val s3i = S3ITMcstr (c3s)
  val () = the_s3itmlst_env_add (s3i)
} // end of [trans3_env_add_cstr]

(* ****** ****** *)

implement
trans3_env_add_prop
  (loc, s2p) = case+ s2p.s2exp_node of
  | _ => let
      val c3s = c3str_prop (loc, s2p) in trans3_env_add_cstr (c3s)
    end // end of [_]
// end of [trans3_env_add_prop]

implement
trans3_env_add_proplst
  (loc, s2ps) = case+ s2ps of
  | list_cons (s2p, s2ps) => (
      trans3_env_add_prop (loc, s2p); trans3_env_add_proplst (loc, s2ps)
    ) // end of [list_cons]
  | list_nil () => ()
// end of [trans3_env_add_proplst]

implement
trans3_env_add_proplst_vt
  (loc, s2ps) = () where {
  val () = trans3_env_add_proplst (loc, $UN.castvwtp1 {s2explst} (s2ps))
  val () = list_vt_free (s2ps)
} // end of [trans3_env_add_proplst_vt]

(* ****** ****** *)

implement
trans3_env_add_eqeq
  (loc, s2e1, s2e2) = let
(*
  val () = (
    print "trans3_env_add_eqeq: s2e1 = "; print_s2exp s2e1; print_newline ();
    print "trans3_env_add_eqeq: s2e2 = "; print_s2exp s2e2; print_newline ();
  ) // end of [val]
*)
  val s2p = s2exp_eqeq (s2e1, s2e2)
in
  trans3_env_add_prop (loc, s2p)
end // end of [trans3_env_add_eqeq]

(* ****** ****** *)
//
// HX: for checking pattern matching exhaustiveness
//
implement
trans3_env_add_patcstlstlst_false
  (loc0, casknd, cp2tcss, s2es) = let
//
fun loop (
  xss: p2atcstlstlst
) :<cloptr1> void =
  case+ xss of
  | list_cons (xs, xss) => let
      val (pfpush | ()) = trans3_env_push ()
      val () = trans3_env_hypadd_patcstlst (loc0, xs, s2es)
      val c3t = c3str_case_exhaustiveness (loc0, casknd, xs)
      val () = trans3_env_add_cstr (c3t)
      val () = trans3_env_pop_and_add_main (pfpush | loc0)
    in
      loop (xss)
    end // end of [list_cons]
  | list_nil () => () // end of [list_nil]
// end of [aux]
in
  loop (cp2tcss)
end // end of [trans3_env_add_patcstlstlst_false]

(* ****** ****** *)

implement
trans3_env_hypadd_prop (loc, s2p) = let
(*
  val () = (
    print "trans3_env_hypadd_prop: s2p = "; print_s2exp s2p; print_newline ()
  ) // end of [val]
*)
  val h3p = h3ypo_prop (loc, s2p); val s3i = S3ITMhypo (h3p)
in
  the_s3itmlst_env_add (s3i)
end // end of [trans3_env_hypadd_prop]

implement
trans3_env_hypadd_proplst
  (loc, s2ps) = case+ s2ps of
  | list_cons (s2p, s2ps) => (
      trans3_env_hypadd_prop (loc, s2p); trans3_env_hypadd_proplst (loc, s2ps)
    ) // end of [list_cons]
  | list_nil () => ()
// end of [trans3_env_hypadd_proplst]

implement
trans3_env_hypadd_proplst_vt
  (loc, s2ps) = () where {
  val () = trans3_env_hypadd_proplst (loc, $UN.castvwtp1 {s2explst} (s2ps))
  val () = list_vt_free (s2ps)
} // end of [trans3_env_hypadd_proplst_vt]

(* ****** ****** *)

implement
trans3_env_hypadd_propopt
  (loc, opt) = case+ opt of
  | Some (s2p) => trans3_env_hypadd_prop (loc, s2p)
  | None () => ()
// end of [trans3_env_hypadd_propopt]

implement
trans3_env_hypadd_propopt_neg
  (loc, opt) = case+ opt of
  | Some (s2p) =>
      trans3_env_hypadd_prop (loc, s2exp_negate (s2p))
    // end of [Some]
  | None () => ()
// end of [trans3_env_hypadd_propopt]

(* ****** ****** *)

implement
trans3_env_hypadd_bind
  (loc, s2v1, s2e2) = let
//
// HX: [s2v1] cannot be bound at this point
//
(*
  val () = begin
    print "trans3_env_hypadd_bind: s2v1 = "; print_s2var s2v1; print_newline ();
    print "trans3_env_hypadd_bind: s2e2 = "; print_s2exp s2e2; print_newline ();
  end // end of [val]
*)
  val () =
    the_s2varbindmap_insert (s2v1, s2e2)
  // end of [val]
  val h3p = h3ypo_bind (loc, s2v1, s2e2)
  val s3i = S3ITMhypo (h3p)
in
  the_s3itmlst_env_add (s3i)
end // end of [trans3_env_hypadd_bind]

implement
trans3_env_hypadd_eqeq
  (loc, s2e1, s2e2) = let
  val h3p = h3ypo_eqeq (loc, s2e1, s2e2); val s3i = S3ITMhypo (h3p)
in
  the_s3itmlst_env_add (s3i)
end // end of [trans3_env_hypadd_eqeq]

(* ****** ****** *)

local

assume trans3_env_push_v = unit_v

in // in of [local]

implement
trans3_env_pop
  (pf | (*none*)) = let
  prval () = unit_v_elim (pf)
  val _(*s2Vs*) = the_s2Varset_env_pop ()
  val () = the_s2varbindmap_pop ()
in
  the_s3itmlst_env_pop ()
end // end of [trans3_env_pop]

implement
trans3_env_pop_and_add
  (pf | loc, knd) = let
  val s3is = trans3_env_pop (pf | (*none*))
  val s3is = list_vt_reverse (s3is)
  val c3s = c3str_itmlst (loc, knd, (l2l)s3is)
in
  trans3_env_add_cstr (c3s)
end // end of [trans3_env_pop_and_add]

implement
trans3_env_pop_and_add_main
  (pf | loc) =
  trans3_env_pop_and_add (pf | loc, C3STRKINDmain())
// end of [trans3_env_pop_and_add_main]

implement
trans3_env_push () = let
  val () = the_s2Varset_env_push ()
  val () = the_s2varbindmap_push ()
  val () = the_s3itmlst_env_push ()
in
  (unit_v () | ())
end // end of [trans3_env_push]

end // end of [local]

(* ****** ****** *)

implement
s2hnf_absuni_and_add
  (loc0, s2f0) = let
  val s2e0 = s2hnf2exp (s2f0)
(*
  val () = begin
    print "s2exp_absuni_and_add: before: s2e0 = "; print_s2exp s2e0;
    print_newline ()
  end // end of [val]
*)
  val s2es2vss2ps = s2exp_absuni (s2e0)
(*
  val () = begin
    print "s2exp_absuni_and_add: after: s2e = "; print_s2exp s2es2vss2ps.0;
    print_newline ()
  end // end of [val]
*)
  val s2vs = s2es2vss2ps.1
  val () = let
    val s2vs =
      $UN.castvwtp1 {s2varlst} (s2vs)
    // end of [val]
    val s2Vs = the_s2Varset_env_get ()
    val () = s2varlst_set_sVarset (s2vs, s2Vs)
    val () = trans3_env_add_svarlst (s2vs)
  in
    // nothing
  end // end of [val]
  val () = list_vt_free (s2vs)
  val s2ps = s2es2vss2ps.2
  val () = trans3_env_hypadd_proplst (loc0, $UN.castvwtp1 {s2explst} (s2ps))
  val () = list_vt_free (s2ps)
in
  s2es2vss2ps.0
end // end of [s2exp_absuni_and_add]

implement
s2hnf_opnexi_and_add
  (loc0, s2f0) = let
  val s2e0 = s2hnf2exp (s2f0)
(*
  val () = begin
    print "s2exp_opnexi_and_add: before: s2e0 = "; print_s2exp s2e0;
    print_newline ()
  end // end of [val]
*)
  val s2es2vss2ps = s2exp_opnexi (s2e0)
(*
  val () = begin
    print "s2exp_opnexi_and_add: after: s2e = "; print_s2exp s2es2vss2ps.0;
    print_newline ()
  end // end of [val]
*)
  val s2vs = s2es2vss2ps.1
  val () = let
    val s2vs =
      $UN.castvwtp1 {s2varlst} (s2vs)
    // end of [val]
    val s2Vs = the_s2Varset_env_get ()
    val () = s2varlst_set_sVarset (s2vs, s2Vs)
    val () = trans3_env_add_svarlst (s2vs)
  in
    // nothing
  end // end of [val]
  val () = list_vt_free (s2vs)
  val s2ps = s2es2vss2ps.2
  val () = trans3_env_hypadd_proplst (loc0, $UN.castvwtp1 {s2explst} (s2ps))
  val () = list_vt_free (s2ps)
in
  s2es2vss2ps.0
end // end of [s2exp_opnexi_and_add]

(* ****** ****** *)

implement
d3exp_open_and_add (d3e) = let
  val s2e = d3e.d3exp_type
  val s2f = s2exp2hnf (s2e)
(*
  val () = (
    print "d3exp_open_and_add: bef: s2e = "; print_s2exp (s2e); print_newline ()
  ) // end of [val]
*)
  val s2e = s2hnf_opnexi_and_add (d3e.d3exp_loc, s2f)
(*
  val () = (
    print "d3exp_open_and_add: aft: s2e = "; print_s2exp (s2e); print_newline ()
  ) // end of [val]
*)
in
  d3exp_set_type (d3e, s2e)
end // end of [d3exp_open_and_add]

implement
d3explst_open_and_add
  (d3es) = list_app_fun (d3es, d3exp_open_and_add)
// end of [d3explst_open_and_add]

(* ****** ****** *)

implement
trans3_env_initialize () = {
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_bool_t0ype)
  val s2c1 = s2cstref_get_cst (the_bool_bool_t0ype)
} // end of [val]
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_g0int_t0ype)
  val s2c1 = s2cstref_get_cst (the_g1int_int_t0ype)
} // end of [val]
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_g0uint_t0ype)
  val s2c1 = s2cstref_get_cst (the_g1uint_int_t0ype)
} // end of [val]
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_char_t0ype)
  val s2c1 = s2cstref_get_cst (the_char_char_t0ype)
} // end of [val]
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_schar_t0ype)
  val s2c1 = s2cstref_get_cst (the_schar_char_t0ype)
} // end of [val]
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_uchar_t0ype)
  val s2c1 = s2cstref_get_cst (the_uchar_char_t0ype)
} // end of [val]
//
val () =
  s2cst_add_sup (s2c1, s2c0) where {
  val s2c0 = s2cstref_get_cst (the_string_type)
  val s2c1 = s2cstref_get_cst (the_string_int_type)
} // end of [val]
//
} // end of [trans3_env_initialize]

(* ****** ****** *)

(* end of [pats_trans3_env.dats] *)