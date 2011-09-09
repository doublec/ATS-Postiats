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
// Start Time: May, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/pointer.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload
STP = "pats_stamp.sats"
typedef stamp = $STP.stamp
overload compare with $STP.compare_stamp_stamp

staload
SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol
typedef symbolopt = $SYM.symbolopt

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

abstype hitypnul // HX: this is just a place holder
extern castfn hitypnul_none (x: ptr null): hitypnul

(* ****** ****** *)

typedef
d2cst_struct = @{
  d2cst_sym= symbol
, d2cst_loc= location
, d2cst_fil= filename
, d2cst_kind= dcstkind
, d2cst_decarg= s2qualst // template arg
, d2cst_arylst= List int // arity
, d2cst_typ= s2exp // assigned type
, d2cst_extdef= dcstextdef // external dcst definition
, d2cst_def= d2expopt // definition
, d2cst_stamp= stamp // unique stamp
, d2cst_hityp= hitypnul // type erasure
} // end of [d2cst_struct]

(* ****** ****** *)

local

assume d2cst_type = ref (d2cst_struct)

in // in of [local]

implement
d2cst_make (
  id
, loc
, fil
, dck
, decarg
, arylst
, typ
, extdef
) = let
//
val stamp = $STP.d2cst_stamp_make ()
val (pfgc, pfat | p) = ptr_alloc<d2cst_struct> ()
prval () = free_gc_elim {d2cst_struct} (pfgc)
//
val () = p->d2cst_sym := id
val () = p->d2cst_loc := loc
val () = p->d2cst_fil := fil
val () = p->d2cst_kind := dck
val () = p->d2cst_decarg := decarg
val () = p->d2cst_arylst := arylst
val () = p->d2cst_typ := typ
val () = p->d2cst_extdef := extdef
val () = p->d2cst_def := None ()
val () = p->d2cst_stamp := stamp
val () = p->d2cst_hityp := hitypnul_none (null)
//
in // in of [let]
//
ref_make_view_ptr (pfat | p)
//
end // end of [d2cst_make]

implement
d2cst_get_sym (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_sym
end // end of [d2cst_get_sym]

implement
d2cst_get_loc (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_loc
end // end of [d2cst_get_loc]

implement
d2cst_get_fil (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_fil
end // end of [d2cst_get_fil]

implement
d2cst_get_kind (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_kind
end // end of [d2cst_get_kind]

implement
d2cst_get_decarg (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_decarg
end // end of [d2cst_get_decarg]

implement
d2cst_get_arylst (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_arylst
end // end of [d2cst_get_arylst]

implement
d2cst_get_typ (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_typ
end // end of [d2cst_get_typ]

implement
d2cst_get_extdef (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_extdef
end // end of [d2cst_get_extdef]

implement
d2cst_get_def (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_def
end // end of [d2cst_get_def]
implement
d2cst_set_def (d2c, def) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_def := def
end // end of [d2cst_set_def]

implement
d2cst_get_stamp (d2c) = let
  val (vbox pf | p) = ref_get_view_ptr (d2c) in p->d2cst_stamp
end // end of [d2cst_get_stamp]

end // end of [local]

(* ****** ****** *)

implement
fprint_d2cst (out, x) =
  $SYM.fprint_symbol (out, d2cst_get_sym (x))
// end of [fprint_d2cst]

implement print_d2cst (x) = fprint_d2cst (stdout_ref, x)
implement prerr_d2cst (x) = fprint_d2cst (stderr_ref, x)

(* ****** ****** *)

(* end of [pats_dynexp2_dcst.dats] *)