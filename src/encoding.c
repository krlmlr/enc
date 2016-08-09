#include <sys/time.h>

#define USE_RINTERNALS
#include <R.h>
#include <Rinternals.h>
#include <R_ext/RS.h>

#define BYTES_MASK (1<<1)
#define LATIN1_MASK (1<<2)
#define UTF8_MASK (1<<3)
#define CACHED_MASK (1<<5)
#define ASCII_MASK (1<<6)

# define IS_BYTES(x) ((x)->sxpinfo.gp & BYTES_MASK)
# define IS_LATIN1(x) ((x)->sxpinfo.gp & LATIN1_MASK)
# define IS_ASCII(x) ((x)->sxpinfo.gp & ASCII_MASK)
# define IS_UTF8(x) ((x)->sxpinfo.gp & UTF8_MASK)
# define ENC_KNOWN(x) ((x)->sxpinfo.gp & (LATIN1_MASK | UTF8_MASK))

SEXP encoding(SEXP x)
{
  if (TYPEOF(x) != STRSXP)
    error("a character vector argument expected");

  R_xlen_t n = XLENGTH(x);
  SEXP ans;
  PROTECT(ans = allocVector(STRSXP, n));
  for (R_xlen_t i = 0; i < n; i++) {
    char *tmp;
    SEXP xi = STRING_ELT(x, i);
    if(IS_BYTES(xi)) tmp = "bytes";
    else if(IS_LATIN1(xi)) tmp = "latin1";
    else if(IS_UTF8(xi)) tmp = "UTF-8";
    else if(IS_ASCII(xi)) tmp = "ASCII";
    else tmp = "unknown";
    SET_STRING_ELT(ans, i, mkChar(tmp));
  }
  UNPROTECT(1);
  return ans;
}

SEXP all_utf8(SEXP x)
{
  if (TYPEOF(x) != STRSXP)
    error("a character vector argument expected");

  R_xlen_t n = XLENGTH(x);
  SEXP ans;
  PROTECT(ans = allocVector(LGLSXP, 1));
  LOGICAL(ans)[0] = TRUE;
  for (R_xlen_t i = 0; i < n; i++) {
    SEXP xi = STRING_ELT(x, i);
    if(IS_UTF8(xi) || IS_ASCII(xi))
      continue;

    LOGICAL(ans)[0] = FALSE;
    break;
  }
  UNPROTECT(1);
  return ans;
}
