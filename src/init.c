#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL

#include "encoding.h"
#include <R_ext/Rdynload.h>

static const R_CallMethodDef CallEntries[] = {
  {"all_utf8", (DL_FUNC) &all_utf8, 1},
  {"encoding", (DL_FUNC) &encoding, 1},
  {NULL, NULL, 0}
};

void R_init_enc(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
  R_forceSymbols(dll, TRUE);
}
