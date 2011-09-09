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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: May, 2011
//
(* ****** ****** *)

staload UT = "pats_utils.sats"
typedef lstord (a:type) = $UT.lstord (a)

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload LOC = "pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload LAB = "pats_label.sats"
typedef label = $LAB.label

staload FIL = "pats_filename.sats"
typedef filename = $FIL.filename

staload SYN = "pats_syntax.sats"
typedef dcstextdef = $SYN.dcstextdef
typedef i0nt = $SYN.i0nt
typedef c0har = $SYN.c0har
typedef f0loat = $SYN.f0loat
typedef s0tring = $SYN.s0tring
typedef l0ab = $SYN.l0ab
typedef l0abeled (a:type) = $SYN.l0abeled (a)

(* ****** ****** *)

staload "pats_staexp1.sats"
typedef s1exp = s1exp
staload "pats_dynexp1.sats"
typedef d1exp = d1exp

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

abstype d2cst_type
typedef d2cst = d2cst_type
typedef d2cstlst = List (d2cst)

abstype d2var_type
typedef d2var = d2var_type
typedef d2varlst = List (d2var)
typedef d2varopt = Option (d2var)

abstype d2mac_type
typedef d2mac = d2mac_type

(* ****** ****** *)

datatype d2itm =
  | D2ITMcon of d2conlst
  | D2ITMcst of d2cst
  | D2ITMe1xp of e1xp
  | D2ITMmacdef of d2mac
  | D2ITMmacvar of d2var
  | D2ITMsymdef of d2itmlst (* overloaded symbol *)
  | D2ITMvar of d2var
// end of [d2itm]

where d2itmlst = List (d2itm)

typedef d2itmopt = Option (d2itm)
viewtypedef d2itmopt_vt = Option_vt (d2itm)

(* ****** ****** *)

typedef d2sym = '{
  d2sym_loc= location
, d2sym_qua= $SYN.d0ynq, d2sym_sym= symbol
, d2sym_itm= d2itmlst
} // end of [d2sym]

(* ****** ****** *)

fun d2cst_make (
  id: symbol
, loc: location
, fil: filename
, dck: dcstkind
, decarg: s2qualst
, arylst: List int
, typ: s2exp
, extdef: dcstextdef
) : d2cst // end of [d2cst_make]

fun fprint_d2cst : fprint_type (d2cst)
fun print_d2cst (x: d2cst): void
fun prerr_d2cst (x: d2cst): void

(* ****** ****** *)

fun d2cst_get_loc (x: d2cst): location
fun d2cst_get_fil (_: d2cst): filename
fun d2cst_get_sym (x: d2cst): symbol
fun d2cst_get_kind (x: d2cst): dcstkind
fun d2cst_get_arylst (x: d2cst): List int
fun d2cst_get_decarg (x: d2cst): s2qualst
fun d2cst_set_decarg (x: d2cst, s2qs: s2qualst): void
fun d2cst_get_typ (x: d2cst): s2exp
fun d2cst_get_extdef (x: d2cst): dcstextdef
fun d2cst_get_stamp (x: d2cst): stamp

(* ****** ****** *)

fun lt_d2cst_d2cst (x1: d2cst, x2: d2cst):<> bool
overload < with lt_d2cst_d2cst
fun lte_d2cst_d2cst (x1: d2cst, x2: d2cst):<> bool
overload <= with lte_d2cst_d2cst

fun compare_d2cst_d2cst (x1: d2cst, x2: d2cst):<> Sgn
overload compare with compare_d2cst_d2cst

(* ****** ****** *)

fun d2var_make (loc: location, id: symbol): d2var

fun fprint_d2var : fprint_type (d2var)
fun print_d2var (x: d2var): void
fun prerr_d2var (x: d2var): void

(* ****** ****** *)

fun d2var_get_loc (x: d2var): location

fun d2var_get_sym (x: d2var): symbol

fun d2var_get_isfix (x: d2var): bool
fun d2var_set_isfix (x: d2var, isfix: bool): void

fun d2var_get_isprf (x: d2var): bool
fun d2var_set_isprf (x: d2var, isprf: bool): void

fun d2var_get_level (x: d2var): int
fun d2var_set_level (x: d2var, level: int): void

fun d2var_get_linval (x: d2var): int

fun d2var_get_decarg (x: d2var): s2qualst
fun d2var_set_decarg (x: d2var, decarg: s2qualst): void

fun d2var_get_addr (x: d2var): s2expopt
fun d2var_set_addr (x: d2var, s2eopt: s2expopt): void

fun d2var_get_view (x: d2var): d2varopt
fun d2var_set_view (x: d2var, d2vopt: d2varopt): void

fun d2var_get_type (x: d2var): s2expopt
fun d2var_set_type (x: d2var, s2eopt: s2expopt): void
fun d2var_get_mastype (x: d2var): s2expopt
fun d2var_set_mastype (x: d2var, s2eopt: s2expopt): void

fun d2var_get_stamp (x: d2var): stamp

fun compare_d2var_d2var (x1: d2var, x2: d2var):<> Sgn
overload compare with compare_d2var_d2var

fun compare_d2vsym_d2vsym (x1: d2var, x2: d2var):<> Sgn

(* ****** ****** *)

datatype macarg =
  MACARGone of d2var | {n:nat} MACARGlst of (int n, list (d2var, n))
// end of [macarg]

typedef macarglst = List (macarg)

fun d2mac_get_loc (x: d2mac): location

fun d2mac_get_sym (x: d2mac): symbol

fun d2mac_get_kind (x: d2mac): int (* 1/0: long/short form *)

fun d2mac_get_narg (x: d2mac): int

fun d2mac_get_arglst (x: d2mac): macarglst

fun d2mac_get_stamp (x: d2mac): stamp

fun fprint_d2mac : fprint_type (d2mac)
fun print_d2mac (x: d2mac): void
fun prerr_d2mac (x: d2mac): void

(* ****** ****** *)

fun fprint_d2itm : fprint_type (d2itm)
fun print_d2itm (x: d2itm): void
fun prerr_d2itm (x: d2itm): void

fun fprint_d2itmlst : fprint_type (d2itmlst)
fun print_d2itmlst (xs: d2itmlst): void
fun prerr_d2itmlst (xs: d2itmlst): void

(* ****** ****** *)

fun d2sym_make (
  loc: location, dq: $SYN.d0ynq, id: symbol, d2is: d2itmlst
) : d2sym // end of [d2sym_make]

fun fprint_d2sym : fprint_type (d2sym)

(* ****** ****** *)

datatype p2at_node =
  | P2Tany of () // wildcard
  | P2Tvar of (int(*refknd*), d2var)
//
  | P2Tbool of bool
  | P2Tint of string(*rep*)
  | P2Tchar of char
  | P2Tstring of string
  | P2Tfloat of string(*rep*)
//
  | P2Tempty of ()
  | P2Tcon of ( // constructor pattern
      int(*freeknd*), d2con, s2qualst, s2exp(*con*), int(*npf*), p2atlst
    ) // end of [P2Tcon]
  | P2Tlist of (int(*npf*), p2atlst)
  | P2Tlst of (p2atlst)
  | P2Ttup of (int(*knd*), int(*npf*), p2atlst)
(*
  | P2Trec of (int(*knd*), int(*npf*), labp2atlst)
*)
//
  | P2Tas of (int(*refknd*), d2var, p2at)
  | P2Texist of (s2varlst, p2at) // existential opening
//
  | P2Tann of (p2at, s2exp) // ascribed pattern
//
  | P2Terr of () // HX: placeholder for indicating an error
// end of [p2at_node]

where
p2at = '{
  p2at_loc= location
, p2at_svs= lstord (s2var)
, p2at_dvs= lstord (d2var)
(*
, p2at_typ= ref@ (s2expopt)
*)
, p2at_node= p2at_node
}
and p2atlst = List (p2at)
and p2atopt = Option (p2at)

(* ****** ****** *)

fun p2atlst_svs_union (p2ts: p2atlst): lstord (s2var)
fun p2atlst_dvs_union (p2ts: p2atlst): lstord (d2var)

(* ****** ****** *)

fun p2at_make (
  loc: location
, svs: lstord (s2var), dvs: lstord (d2var)
, node: p2at_node
) : p2at // end of [p2at_make]

fun p2at_any (loc: location): p2at
fun p2at_anys (loc: location): p2at

fun p2at_var (
  loc: location, refknd: int, d2v: d2var
) : p2at // end of [p2at_var]

fun p2at_bool (loc: location, b: bool): p2at
fun p2at_int (loc: location, rep: string): p2at
fun p2at_char (loc: location, c: char): p2at
fun p2at_string (loc: location, str: string): p2at
fun p2at_float (loc: location, rep: string): p2at

fun p2at_empty (loc: location): p2at

fun p2at_con (
  loc: location
, freeknd: int
, d2c: d2con
, s2qs: s2qualst
, s2e(*con*): s2exp
, npf: int, darg: p2atlst
) : p2at // end of [p2at_con]

fun p2at_list // HX: flat tuple
  (loc: location, npf: int, p2ts: p2atlst): p2at
// end of [p2at_list]

fun p2at_lst (loc: location, p2ts: p2atlst): p2at

fun p2at_tup (
  loc: location, knd: int, npf: int, p2ts: p2atlst
) : p2at // end of [p2at_tup]

fun p2at_as (
  loc: location, refknd: int, d2v: d2var, p2t: p2at
) : p2at // end of [p2at_as]

fun p2at_exist
  (loc: location, s2vs: s2varlst, p2t: p2at): p2at
// end of [p2at_exist]

fun p2at_ann (loc: location, p2t: p2at, s2e: s2exp): p2at

fun p2at_err (loc: location): p2at

(* ****** ****** *)

fun fprint_p2at (out: FILEref, x: p2at): void
fun fprint_p2atlst (out: FILEref, xs: p2atlst): void

(* ****** ****** *)

datatype
d2ecl_node =
  | D2Cnone of () // for something already erased
  | D2Clist of d2eclist // for list of declarations
//
  | D2Csymintr of ($SYN.i0delst)
  | D2Csymelim of ($SYN.i0delst) // for temporary use
  | D2Coverload of ($SYN.i0de, d2itmopt) // symbol overloading
//
  | D2Cstavars of s2tavarlst // for [stavar] declarations
  | D2Csaspdec of s2aspdec (* for static assumption *)
  | D2Cextype of (string(*name*), s2exp(*def*))
  | D2Cextval of (string(*name*), d2exp(*def*))
  | D2Cextcode of (int(*knd*), int(*pos*), string(*code*))
//
  | D2Cdatdec of (int(*knd*), s2cstlst) // datatype declarations
  | D2Cexndec of (d2conlst) // exception constructor declarations
//
  | D2Cdcstdec of (dcstkind, d2cstlst) // dyn. const. declarations
//
  | D2Cvaldecs of
      (valkind, v2aldeclst) // (nonrec) value declarations
    // end of [D2Cvaldecs]
  | D2Cvaldecs_rec of
      (valkind, v2aldeclst) // (reccursive) value declarations
    // end of [D2Cvaldecs_rec]
  | D2Cvardecs of (v2ardeclst) // variable declarations
  | D2Cfundecs of (funkind, s2qualst, f2undeclst)
//
  | D2Cimpdec of i2mpdec // val/fun/prval/prfun implementation
//
  | D2Cinclude of d2eclist (* file inclusion *)
  | D2Cstaload of (
      symbolopt(*id*), filename, int(*loadflag*), int(*loaded*), filenv
    ) // end of [D2staload]
  | D2Cdynload of filename (* dynamic load *)
  | D2Clocal of (d2eclist(*head*), d2eclist(*body*)) // local declaration
// end of [d2ecl_node]

and
d2exp_node =
//
  | D2Evar of d2var
//
  | D2Ebool of bool
  | D2Eint of string(*rep*)
  | D2Echar of char
  | D2Estring of string
  | D2Efloat of string(*rep*)
//
  | D2Ei0nt of i0nt
  | D2Ec0har of c0har
  | D2Ef0loat of f0loat
  | D2Es0tring of s0tring
//
  | D2Ecstsp of $SYN.cstsp
//
  | D2Etop of () // unspecified
  | D2Eempty of () // the void-value
//
  | D2Eextval of (s2exp(*typ*), string(*code*))
//
  | D2Econ of (* dynamic constructor *)
      (d2con, s2exparglst, int (*pfarity*), d2explst)
  | D2Ecst of d2cst
//
  | D2Eloopexn of int(*knd*)
//
  | D2Efoldat of (* folding at a given address *)
      (s2exparglst, d2exp)
  | D2Efreeat of (* freeing at a given address *)
      (s2exparglst, d2exp)
//
  | D2Elet of (d2eclist, d2exp) // let-expression
  | D2Ewhere of (d2exp, d2eclist) // where-expression
//
  | D2Eapps of (d2exp, d2exparglst)
  | D2Eassgn of (d2exp(*left*), d2exp(*right*))
  | D2Ederef of (d2exp(*leftval*))
//
  | D2Eifhead of // dynamic conditional
      (i2nvresstate, d2exp, d2exp, d2expopt)
  | D2Esifhead of // static conditional
      (i2nvresstate, s2exp, d2exp, d2exp)
//
  | D2Ecasehead of ( // dynamic case-expression
      caskind, i2nvresstate, d2explst, c2laulst
    ) // end of [D2Ecaseof]
  | D2Escasehead of ( // static case-expression
      i2nvresstate, s2exp, sc2laulst
    ) // end of [D2Escaseof]
//
  | D2Elst of (int(*lin*), s2expopt, d2explst) // list
  | D2Etup of (int(*knd*), int(*npf*), d2explst) // tuple
  | D2Erec of (int (*knd*), int (*npf*), labd2explst) // record
  | D2Eseq of d2explst // sequence-expressions // sequence
//
  | D2Earrsub of (* array subscription *)
      (d2sym, d2exp, location(*ind*), d2explstlst(*ind*))
  | D2Earrinit of (* array initialization *)
      (s2exp (*elt*), d2expopt (*asz*), d2explst (*ini*))
  | D2Earrsize of (* $arrsz expression *)
      (s2expopt (*element type*), d2explst (*elements*))
//
  | D2Eraise of d2exp // raised exception
  | D2Edelay of (int(*knd*), d2exp(*body*)) // $delay and $ldelay
//
  | D2Eptrof of d2exp // taking the address of
  | D2Eviewat of d2exp // taking view at a given address
  | D2Esel of (d2exp, d2lablst) // record field selection
//
  | D2Eexist of (s2exparg, d2exp) // witness-carrying expression
//
  | D2Elam_dyn of (* boxed dynamic abstraction *)
      (int(*lin*), int(*npf*), p2atlst(*arg*), d2exp(*body*))
  | D2Elaminit_dyn of (* flat dynamic abstraction *)
      (int(*lin*), int(*npf*), p2atlst(*arg*), d2exp(*body*))
  | D2Elam_met of (ref(d2varlst), s2explst(*met*), d2exp(*body*))
//
  | D2Elam_sta of (s2varlst, s2explst, d2exp) // static abstraction
//
  | D2Efix of (
      int(*knd: 0/1: flat/boxed*), d2var(*fixvar*), d2exp(*body*)
    ) // end of [D2Efix]
//
  | D2Eann_type of (d2exp, s2exp) // ascribled expression
  | D2Eann_seff of (d2exp, s2eff) // ascribed with effects
  | D2Eann_funclo of (d2exp, funclo) // ascribed with funtype
//
  | D2Eerr of () // HX: placeholder for indicating an error
// end of [d2exp_node]

and d2exparg =
  | D2EXPARGsta of s2exparglst
  | D2EXPARGdyn of (location(*arg*), int (*pfarity*), d2explst)
// end of [d2exparg]

and d2lab_node =
  | D2LABlab of label | D2LABind of d2explstlst
// end of [d2lab_node]

where
d2ecl = '{
  d2ecl_loc= location, d2ecl_node= d2ecl_node
}
and d2eclist = List (d2ecl)

and
d2exp = '{
  d2exp_loc= location, d2exp_node= d2exp_node
}
and d2explst = List (d2exp)
and d2expopt = Option (d2exp)
and d2explstlst = List (d2explst)

and labd2exp = l0abeled (d2exp)
and labd2explst = List (labd2exp)

and d2exparglst = List (d2exparg)

(* ****** ****** *)

and d2lab = '{
  d2lab_loc= location, d2lab_node= d2lab_node
} // end of [d2lab]

and d2lablst = List d2lab

(* ****** ****** *)

and i2nvarg = '{
  i2nvarg_var= d2var, i2nvarg_typ= s2expopt
}
and i2nvarglst = List i2nvarg

and i2nvresstate = '{
  i2nvresstate_svs= s2varlst
, i2nvresstate_gua= s2explst
, i2nvresstate_arg= i2nvarglst
, i2nvresstate_met= s2explstopt
} // end of [i2nvresstate]

and loopi2nv = '{
  loopi2nv_loc= location
, loopi2nv_svs= s2varlst
, loopi2nv_gua= s2explst
, loopi2nv_met= s2explstopt (* metric *)
, loopi2nv_arg= i2nvarglst (* argument *)
, loopi2nv_res= i2nvresstate (* result *)
} // end of [loopi2nv]

(* ****** ****** *)

and m2atch = '{
  m2atch_loc= location
, m2atch_exp= d2exp, m2atch_pat= p2atopt
} // end of [m2atch]

and m2atchlst = List (m2atch)

(* ****** ****** *)

and c2lau = '{
  c2lau_loc= location
, c2lau_pat= p2atlst
, c2lau_gua= m2atchlst
, c2lau_seq= int
, c2lau_neg= int
, c2lau_body= d2exp
} // end of [c2lau]

and c2laulst = List (c2lau)

and sc2lau = '{
  sc2lau_loc= location
, sc2lau_pat= sp2at
, sc2lau_body= d2exp
} // end of [sc2lau]

and sc2laulst = List (sc2lau)

(* ****** ****** *)

and v2aldec = '{
  v2aldec_loc= location
, v2aldec_pat= p2at
, v2aldec_def= d2exp
, v2aldec_ann= s2expopt
} // end of [v2aldec]

and v2aldeclst = List (v2aldec)

(* ****** ****** *)

and v2ardec = '{
  v2ardec_loc= location
, v2ardec_knd= int (* BANG: knd = 1 *)
, v2ardec_dvar= d2var // dynamic address
, v2ardec_svar= s2var // static address
, v2ardec_typ= s2expopt
, v2ardec_wth= d2varopt // proof of @-view
, v2ardec_ini= d2expopt
} // end of [v2ardec]

and v2ardeclst = List (v2ardec)

(* ****** ****** *)

and f2undec = '{
  f2undec_loc= location
, f2undec_var= d2var
, f2undec_def= d2exp
, f2undec_ann= s2expopt
} // end of [f2undec]

and f2undeclst = List f2undec

(* ****** ****** *)

and i2mpdec = '{
  i2mpdec_loc= location
, i2mpdec_locid= location
, i2mpdec_cst= d2cst
, i2mpdec_imparg= s2varlst // static variables
, i2mpdec_tmparg= s2explstlst // static args
, i2mpdec_tmpgua= s2explstlst // static guards
, i2mpdec_def= d2exp
} // end of [i2mpdec]

(* ****** ****** *)
//
// HX: dynamic expressions
//
(* ****** ****** *)

fun d2exp_make
  (loc: location, node: d2exp_node): d2exp
// end of [d2exp_make]

fun d2exp_var (loc: location, d2v: d2var): d2exp

fun d2exp_bool (loc: location, b: bool): d2exp
fun d2exp_int (loc: location, rep: string): d2exp
fun d2exp_char (loc: location, c: char): d2exp
fun d2exp_string (loc: location, s: string): d2exp
fun d2exp_float (loc: location, rep: string): d2exp

fun d2exp_i0nt (loc: location, x: i0nt): d2exp
fun d2exp_c0har (loc: location, x: c0har): d2exp
fun d2exp_f0loat (loc: location, x: f0loat): d2exp
fun d2exp_s0tring (loc: location, x: s0tring): d2exp

fun d2exp_top (loc: location): d2exp
fun d2exp_empty (loc: location): d2exp

fun d2exp_extval
  (loc: location, typ: s2exp, code: string): d2exp
// end of [d2exp_extval]

fun d2exp_con (
  loc: location
, d2c: d2con, sarg: s2exparglst, npf: int, darg: d2explst
) : d2exp // end of [d2exp_con]

fun d2exp_cst (loc: location, d2c: d2cst): d2exp
fun d2exp_cstsp (loc: location, cst: $SYN.cstsp): d2exp

fun d2exp_loopexn (loc: location, knd: int): d2exp

fun d2exp_foldat
  (loc: location, s2as: s2exparglst, d2e: d2exp): d2exp
fun d2exp_freeat
  (loc: location, s2as: s2exparglst, d2e: d2exp): d2exp

fun d2exp_let
  (loc: location, d2cs: d2eclist, body: d2exp): d2exp
// end of [d2exp_let]
fun d2exp_where
  (loc: location, body: d2exp, d2cs: d2eclist): d2exp
// end of [d2exp_where]

fun d2exp_assgn
  (loc: location, _left: d2exp, _right: d2exp): d2exp
// end of [d2exp_assgn]
fun d2exp_deref (loc: location, d2e_lval: d2exp): d2exp

fun d2exp_apps (
  loc: location, d2e_fun: d2exp, d2as: d2exparglst
) : d2exp // end of [d2exp_apps]
fun d2exp_app_sta (
  loc: location, d2e_fun: d2exp, sarg: s2exparglst
) : d2exp // end of [d2exp_app_sta]
fun d2exp_app_dyn (
  loc: location
, d2e_fun: d2exp
, locarg: location, npf: int, darg: d2explst
) : d2exp // end of [d2exp_app_dyn]
fun d2exp_app_sta_dyn (
  loc_dyn: location
, loc_sta: location
, d2e_fun: d2exp
, sarg: s2exparglst
, locarg: location, npf: int, darg: d2explst
) : d2exp // end of [d2exp_app_sta_dyn]

(* ****** ****** *)

fun d2exp_ifhead (
  loc: location
, res: i2nvresstate, _cond: d2exp, _then: d2exp, _else: d2expopt
) : d2exp // end of [d2exp_ifhead]

fun d2exp_sifhead (
  loc: location
, res: i2nvresstate, _cond: s2exp, _then: d2exp, _else: d2exp
) : d2exp // end of [d2exp_sifhead]

(* ****** ****** *)

fun d2exp_casehead (
  loc: location
, knd: caskind
, res: i2nvresstate
, d2es: d2explst
, c2ls: c2laulst
) : d2exp // end of [d2exp_casehead]

fun d2exp_scasehead (
  loc: location, res: i2nvresstate, s2e: s2exp, sc2ls: sc2laulst
) : d2exp // end of [d2exp_scasehead]

(* ****** ****** *)

fun d2exp_lst (
  loc: location, lin: int, elt: s2expopt, d2es: d2explst
) : d2exp // end of [d2exp_lst]

fun d2exp_tup (
  loc: location, knd: int, npf: int, d2es: d2explst
) : d2exp // end of [d2exp_tup]

fun d2exp_rec (
  loc: location, knd: int, npf: int, ld2es: labd2explst
) : d2exp // end of [d2exp_rec]

fun d2exp_seq (loc: location, d2es: d2explst): d2exp

(* ****** ****** *)

fun d2exp_arrsub (
  loc: location
, d2s: d2sym, arr: d2exp, ind: location, ind: d2explstlst
) : d2exp // end of [d2exp_arrsub]

fun d2exp_arrinit (
  loc: location
, elt: s2exp, asz: d2expopt, ini: d2explst
) : d2exp // end of [d2exp_arrinit]

fun d2exp_arrsize (
  loc: location, elt: s2expopt, elts: d2explst
) : d2exp // end of [d2exp_arrsize]

(* ****** ****** *)

fun d2exp_raise (loc: location, d2e: d2exp): d2exp
fun d2exp_delay (loc: location, knd: int, d2e: d2exp): d2exp

(* ****** ****** *)

fun d2exp_ptrof (loc: location, d2e: d2exp): d2exp
fun d2exp_viewat (loc: location, d2e: d2exp): d2exp
fun d2exp_sel_dot (loc: location, rt: d2exp, labs: d2lablst): d2exp
fun d2exp_sel_ptr (loc: location, rt: d2exp, lab: d2lab): d2exp

(* ****** ****** *)

fun d2exp_exist (loc: location, s2a: s2exparg, d2e: d2exp): d2exp

(* ****** ****** *)

fun d2exp_lam_dyn
  (loc: location, lin: int, npf: int, arg: p2atlst, body: d2exp): d2exp
fun d2exp_laminit_dyn
  (loc: location, knd: int, npf: int, arg: p2atlst, body: d2exp): d2exp

fun d2exp_lam_met
  (loc: location, r: ref (d2varlst), met: s2explst, body: d2exp): d2exp
// end of [d2exp_lam_met]
fun d2exp_lam_met_new (loc: location, met: s2explst, body: d2exp): d2exp

fun d2exp_lam_sta (
  loc: location, s2vs: s2varlst, s2ps: s2explst, body: d2exp
) : d2exp // end of [d2exp_lam_sta]

fun d2exp_fix (loc: location, knd: int, f: d2var, body: d2exp): d2exp

(* ****** ****** *)

fun d2exp_ann_type (loc: location, d2e: d2exp, ann: s2exp): d2exp
fun d2exp_ann_seff (loc: location, d2e: d2exp, s2fe: s2eff): d2exp
fun d2exp_ann_funclo (loc: location, d2e: d2exp, fc: funclo): d2exp

(* ****** ****** *)

fun d2exp_err (loc: location): d2exp

(* ****** ****** *)

fun labd2exp_make (l: l0ab, d2e: d2exp): labd2exp

(* ****** ****** *)

fun d2lab_lab (loc: location, lab: label): d2lab
fun d2lab_ind (loc: location, ind: d2explstlst): d2lab

fun fprint_d2lab : fprint_type (d2lab)

(* ****** ****** *)

fun i2nvarg_make (d2v: d2var, typ: s2expopt): i2nvarg

val i2nvresstate_nil : i2nvresstate

fun i2nvresstate_make
  (s2vs: s2varlst, s2ps: s2explst, arg: i2nvarglst): i2nvresstate
fun i2nvresstate_make_met (
  s2vs: s2varlst, s2ps: s2explst, arg: i2nvarglst, met: s2explstopt
) : i2nvresstate // end of [i2nvresstate_make_met]

fun i2nvresstate_update (res: i2nvresstate): i2nvresstate

(* ****** ****** *)

fun loopi2nv_make (
  loc: location
, svs: s2varlst
, gua: s2explst
, met: s2explstopt
, arg: i2nvarglst
, res: i2nvresstate
) : loopi2nv // end of [loopi2nv_make]

fun loopi2nv_update (i2nv: loopi2nv): loopi2nv

(* ****** ****** *)

fun m2atch_make (
  loc: location, d2e: d2exp, p2topt: p2atopt
) : m2atch // end of [m2atch_make]

fun c2lau_make (
  loc: location
, p2ts: p2atlst
, gua: m2atchlst
, seq: int, neg: int
, body: d2exp
) : c2lau // end of [c2lau_make]

fun sc2lau_make
  (loc: location, sp2t: sp2at, body: d2exp): sc2lau
// end of [sc2lau_make]

(* ****** ****** *)

fun d2cst_get_def (d2c: d2cst): d2expopt
fun d2cst_set_def (d2c: d2cst, def: d2expopt): void

(* ****** ****** *)

fun d2mac_make (
  loc: location, name: symbol, knd: int, args: macarglst, def: d2exp
) : d2mac // end of [d2mac_make]

fun d2mac_get_def (x: d2mac): d2exp
fun d2mac_set_def (x: d2mac, def: d2exp): void

(* ****** ****** *)

fun v2aldec_make (
  loc: location, p2t: p2at, def: d2exp, ann: s2expopt
) : v2aldec // end of [v2aldec_make]

fun v2ardec_make (
  loc: location
, knd: int
, d2v: d2var
, s2v: s2var
, typ: s2expopt
, wth: d2varopt
, ini: d2expopt
) : v2ardec // end of [v2ardec_make]

(* ****** ****** *)

fun f2undec_make (
  loc: location, d2v_fun: d2var, def: d2exp, ann: s2expopt
) : f2undec // end of [f2undec_make]

(* ****** ****** *)

fun i2mpdec_make (
  loc: location
, locid: location
, d2c: d2cst
, imparg: s2varlst
, tmparg: s2explstlst, tmpgua: s2explstlst
, def: d2exp
) : i2mpdec // end of [i2mpdec_make]

(* ****** ****** *)
//
// HX: various declarations
//
(* ****** ****** *)

fun d2ecl_none (loc: location): d2ecl
fun d2ecl_list (loc: location, xs: d2eclist): d2ecl

fun d2ecl_symintr
  (loc: location, ids: $SYN.i0delst): d2ecl
fun d2ecl_symelim
  (loc: location, ids: $SYN.i0delst): d2ecl
fun d2ecl_overload
  (loc: location, id: $SYN.i0de, opt: d2itmopt): d2ecl
// end of [d2ecl_overload]

fun d2ecl_stavars (loc: location, xs: s2tavarlst): d2ecl

fun d2ecl_saspdec (loc: location, dec: s2aspdec): d2ecl

fun d2ecl_extype
  (loc: location, name: string, def: s2exp): d2ecl
fun d2ecl_extval
  (loc: location, name: string, def: d2exp): d2ecl
fun d2ecl_extcode
  (loc: location, knd: int, pos: int, code: string): d2ecl
// end of [d2ecl_extcode]

fun d2ecl_datdec (
  loc: location, knd: int, s2cs: s2cstlst
) : d2ecl // end of [d2ecl_datdec]
fun d2ecl_exndec (loc: location, d2cs: d2conlst): d2ecl

fun d2ecl_dcstdec (
  loc: location, knd: dcstkind, d2cs: d2cstlst
) : d2ecl // end of [d2ecl_dcstdec]

(* ****** ****** *)

fun d2ecl_valdecs (
  loc: location, knd: valkind, d2cs: v2aldeclst
) : d2ecl // end of [d2ecl_valdecs]

fun d2ecl_valdecs_rec (
  loc: location, knd: valkind, d2cs: v2aldeclst
) : d2ecl // end of [d2ecl_valdecs_rec]

fun d2ecl_vardecs (loc: location, d2cs: v2ardeclst): d2ecl

fun d2ecl_fundecs (
  loc: location
, knd: funkind, decarg: s2qualst, d2cs: f2undeclst
) : d2ecl // end of [d2ecl_fundecs]

(* ****** ****** *)

fun d2ecl_impdec (loc: location, d2c: i2mpdec): d2ecl

(* ****** ****** *)

fun d2ecl_include (loc: location, d2cs: d2eclist): d2ecl

fun d2ecl_staload (
  loc: location
, idopt: symbolopt
, fil: filename, loadflag: int, loaded: int, fenv: filenv
) : d2ecl // end of [d2ecl_staload]

fun d2ecl_dynload (loc: location, fil: filename): d2ecl

fun d2ecl_local (loc: location, ds1: d2eclist, ds2: d2eclist): d2ecl

(* ****** ****** *)

(* end of [pats_dynexp2.sats] *)