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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: May, 2012
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libc"
#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

staload "libc/SATS/stdio.sats"

(* ****** ****** *)

%{
extern
atstype_ptr
atslib_fopen_exn
(
  atstype_string path
, atstype_string mode
) {
  FILE *filp ;
  filp = fopen ((char*)path, (char*)mode) ;
  if (!filp) ATSLIBfailexit("fopen") ; // HX: failure
  return filp ;
} // end of [atslib_fopen_exn]
%}

(* ****** ****** *)

%{
extern
atsvoid_t0ype
atslib_fclose_exn
  (atstype_ptr filp) {
  int err ;
  err = fclose ((FILE*)filp) ;
  if (0 > err) ATSLIBfailexit("fclose") ;
  return ;
} // end of [atslib_fclose_exn]
%}

(* ****** ****** *)

%{
extern
atsvoid_t0ype
atslib_fflush_exn
(
  atstype_ptr filp
) {
  int err = fflush((FILE*)filp) ;
  if (0 > err) ATSLIBfailexit("fflush") ;
  return ;
} /* end of [atslib_fflush_exn] */
%}

(* ****** ****** *)

%{
extern
atsvoid_t0ype
atslib_fputc_exn
(
  atstype_int c, atstype_ptr filp
) {
  int err ;
  err = fputc(c, (FILE*)filp) ;
  if (0 > err) {
    ATSLIBfailexit("fputc") ; // abnormal exit
  } /* end of [if] */
  return ;  
} /* end of [atslib_fputc_exn] */
%}

(* ****** ****** *)

%{
extern
atsvoid_t0ype
atslib_fgets_exn
(
  atstype_ptr buf0
, atstype_int bsz0
, atstype_ptr filp
) {
  char *buf, *pres ;
  buf = (char*)buf0 ;
  pres = fgets(buf, (int)bsz0, (FILE*)filp) ;
  if (!pres)
  {
    if (feof((FILE*)filp))
    {
      buf[0] = '\000' ; // EOF is reached
    } else {
      ATSLIBfailexit("fgets") ; // abnormal exit
    } // end of [if]
  } /* end of [if] */
  return ;  
} /* end of [atslib_fgets_exn] */
%}

(* ****** ****** *)

%{
extern
atstype_ptr
atslib_fgets_gc
(
  atstype_int bsz0
, atstype_ptr filp0
)
{
  int bsz = bsz0 ;
  FILE *filp = (FILE*)filp0 ;
  int ofs = 0, ofs2 ;
  char *buf, *buf2, *pres ;
  buf = atspre_malloc_gc(bsz) ;
  while (1) {
    buf2 = buf+ofs ;
    pres = fgets(buf2, bsz-ofs, filp) ;
    if (!pres)
    {
      if (feof(filp))
      {
        *buf2 = '\000' ; return buf ;
      } else {
        atspre_mfree_gc(buf) ; return (char*)0 ;
      } // end of [if]
    }
    ofs2 = strlen(buf2) ;
    if (ofs2==0) return buf ;
    ofs += ofs2 ; // HX: ofs > 0
    if (buf[ofs-1]=='\n') return buf ;
    bsz *= 2 ; buf2 = buf ;
    buf = atspre_malloc_gc(bsz) ;
    memcpy(buf, buf2, ofs) ;
    atspre_mfree_gc(buf2) ;
  }
  return buf ; // HX: deadcode
} // end of [atslib_fgets_gc]
%}

(* ****** ****** *)

%{
extern
atsvoid_t0ype
atslib_fputs_exn
(
  atstype_string str, atstype_ptr filp
) {
  int err ;
  err = fputs((char*)str, (FILE*)filp) ;
  if (0 > err) {
    ATSLIBfailexit("fputs") ; // abnormal exit
  } /* end of [if] */
  return ;  
} /* end of [atslib_fputs_exn] */
%}

(* ****** ****** *)

%{
extern
atsvoid_t0ype
atslib_puts_exn
(
  atstype_string str
) {
  int err ;
  err = puts((char*)str) ;
  if (0 > err) {
    ATSLIBfailexit("puts") ; // abnormal exit
  } /* end of [if] */
  return ;  
} /* end of [atslib_puts_exn] */
%}

(* ****** ****** *)

%{
extern
atstype_ptr
atslib_popen_exn
(
  atstype_string cmd
, atstype_string type
) {
  FILE *filp ;
  filp = popen((char*)cmd, (char*)type) ;
  if (!filp) {
    ATSLIBfailexit("popen") ; // abnormal exit
  } /* end of [if] */
  return filp ;
} /* end of [atslib_popen_exn]
%}

(* ****** ****** *)

%{
extern
atstype_int
atslib_pclose_exn
(
  atstype_ptr filp
) {
  int res ;
  res = pclose((FILE*)filp) ;
  if (0 > res) {
    ATSLIBfailexit("pclose") ; // abnormal exit
  } /* end of [if] */
  return res ;
} /* end of [atslib_pclose_exn]
%}

(* ****** ****** *)

%{
extern
atstype_ptr
atslib_tmpfile_exn(
) {
  FILE *filp = tmpfile() ;
  if (!filp) ATSLIBfailexit("tmpfile") ;
  return (filp) ;
} // end of [atslib_tmpfile_exn]
%}

(* ****** ****** *)

(* end of [stdio.dats] *)
