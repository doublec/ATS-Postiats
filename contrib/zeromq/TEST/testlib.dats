//
// Some library code for testing
//
(* ****** ****** *)

#define ATS_PACKNAME "testlib"

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

staload "zeromq/SATS/zmq.sats"

(* ****** ****** *)

local
//
#include "zeromq/DATS/zmq.dats"
//
in (* in of [local] *)
//
// HX: it is intentionally left to be empty
//
end // end of [local]

(* ****** ****** *)

(* end of [testlib.dats] *)
