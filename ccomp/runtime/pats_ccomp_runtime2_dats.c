/*
**
** The C code is generated by ATS/Postiats
** The compilation time is: 2013-6-30: 23h:21m
**
*/
typedef
struct {
int exntag ;
char *exnmsg ;
atstkind_type(atstype_ptrk) atslab$0; 
} pats_ccomp_runtime2_tyexn_0 ;

ATSdyncst_mac(atspre_exit) ;
ATSdyncst_mac(atspre_prerr_string) ;
ATSdyncst_mac(atspre_prerr_newline) ;
ATSdyncst_extfun(atsruntime_handle_uncaughtexn_rest, (atstype_exnconptr), atsvoid_t0ype) ;

ATSglobaldec()
atsvoid_t0ype
atsruntime_handle_uncaughtexn(void *arg0)
{
/* tmpvardeclst(beg) */
ATStmpdec_void(tmpret0, atsvoid_t0ype) ;
ATStmpdec(tmp1, atstkind_type(atstype_ptrk)) ;
ATStmpdec(tmp2, atstkind_type(atstype_ptrk)) ;
ATStmpdec_void(tmp3, atsvoid_t0ype) ;
ATStmpdec_void(tmp4, atsvoid_t0ype) ;
ATStmpdec_void(tmp5, atsvoid_t0ype) ;
ATStmpdec_void(tmp6, atsvoid_t0ype) ;
ATStmpdec_void(tmp7, atsvoid_t0ype) ;
ATStmpdec_void(tmp8, atsvoid_t0ype) ;
ATStmpdec_void(tmp9, atsvoid_t0ype) ;
ATStmpdec_void(tmp10, atsvoid_t0ype) ;
ATStmpdec_void(tmp11, atsvoid_t0ype) ;
ATStmpdec_void(tmp12, atsvoid_t0ype) ;
ATStmpdec_void(tmp13, atsvoid_t0ype) ;
ATStmpdec_void(tmp14, atsvoid_t0ype) ;
ATStmpdec_void(tmp15, atsvoid_t0ype) ;
ATStmpdec_void(tmp16, atsvoid_t0ype) ;
/* tmpvardeclst(end) */
/* funbodyinstrlst(beg) */
__patsflab_atsruntime_handle_uncaughtexn:
/*
letpush(beg)
*/
/*
letpush(end)
*/

ATScaseofbeg()
/*
** ibranchlst-beg
*/
ATSbranchbeg() ;
__patstlab_0:
ATSifnot(ATSPATCKexn0(arg0, ATSLIB_056$prelude_AssertExn)) { ATSgoto(__patstlab_2) ; }
__patstlab_1:
/*
ibranch-mbody:
*/
/*
letpush(beg)
*/
ATSINSmove_void(tmp3, atspre_prerr_string(ATSPMVstring("exit(ATS): uncaught exception at run-time"))) ;
ATSINSmove_void(tmp4, atspre_prerr_string(ATSPMVstring(": AssertExn"))) ;
ATSINSmove_void(tmp5, atspre_prerr_newline()) ;
/*
letpush(end)
*/

ATSINSmove_void(tmpret0, atspre_exit(ATSPMVi0nt(1))) ;
/*
INSletpop()
*/
ATSbranchend() ;

ATSbranchbeg() ;
__patstlab_2:
ATSifnot(ATSPATCKexn0(arg0, ATSLIB_056$prelude_NotFoundExn)) { ATSgoto(__patstlab_4) ; }
__patstlab_3:
/*
ibranch-mbody:
*/
/*
letpush(beg)
*/
ATSINSmove_void(tmp6, atspre_prerr_string(ATSPMVstring("exit(ATS): uncaught exception at run-time"))) ;
ATSINSmove_void(tmp7, atspre_prerr_string(ATSPMVstring(": NotFoundExn"))) ;
ATSINSmove_void(tmp8, atspre_prerr_newline()) ;
/*
letpush(end)
*/

ATSINSmove_void(tmpret0, atspre_exit(ATSPMVi0nt(1))) ;
/*
INSletpop()
*/
ATSbranchend() ;

ATSbranchbeg() ;
__patstlab_4:
ATSifnot(ATSPATCKexn1(arg0, ATSLIB_056$prelude_GenerallyExn)) { ATSgoto(__patstlab_6) ; }
__patstlab_5:
ATSINSmove(tmp1, ATSSELcon(arg0, pats_ccomp_runtime2_tyexn_0, atslab$0)) ;
/*
ATSINSfreecon(arg0) ;
*/
/*
ibranch-mbody:
*/
/*
letpush(beg)
*/
ATSINSmove_void(tmp9, atspre_prerr_string(ATSPMVstring("exit(ATS): uncaught exception at run-time"))) ;
ATSINSmove_void(tmp10, atspre_prerr_string(ATSPMVstring(": GenerallyExn: "))) ;
ATSINSmove_void(tmp11, atspre_prerr_string(tmp1)) ;
ATSINSmove_void(tmp12, atspre_prerr_newline()) ;
/*
letpush(end)
*/

ATSINSmove_void(tmpret0, atspre_exit(ATSPMVi0nt(1))) ;
/*
INSletpop()
*/
ATSbranchend() ;

ATSbranchbeg() ;
__patstlab_6:
ATSifnot(ATSPATCKexn1(arg0, ATSLIB_056$prelude_IllegalArgExn)) { ATSgoto(__patstlab_8) ; }
__patstlab_7:
ATSINSmove(tmp2, ATSSELcon(arg0, pats_ccomp_runtime2_tyexn_0, atslab$0)) ;
/*
ATSINSfreecon(arg0) ;
*/
/*
ibranch-mbody:
*/
/*
letpush(beg)
*/
ATSINSmove_void(tmp13, atspre_prerr_string(ATSPMVstring("exit(ATS): uncaught exception at run-time"))) ;
ATSINSmove_void(tmp14, atspre_prerr_string(ATSPMVstring(": IllegalArgExn: "))) ;
ATSINSmove_void(tmp15, atspre_prerr_string(tmp2)) ;
ATSINSmove_void(tmp16, atspre_prerr_newline()) ;
/*
letpush(end)
*/

ATSINSmove_void(tmpret0, atspre_exit(ATSPMVi0nt(1))) ;
/*
INSletpop()
*/
ATSbranchend() ;

ATSbranchbeg() ;
__patstlab_8:
/*
ibranch-mbody:
*/
ATSINSmove_void(tmpret0, atsruntime_handle_uncaughtexn_rest(arg0)) ;
ATSbranchend() ;

/*
** ibranchlst-end
*/
ATScaseofend()

/*
INSletpop()
*/
/* funbodyinstrlst(end) */
ATSreturn_void(tmpret0) ;
} /* end of [atsruntime_handle_uncaughtexn] */
