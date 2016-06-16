#include <sys/time.h>
#include <sys/resource.h>

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
  SEXP ans;
  R_xlen_t i, n;
  char *tmp;

  if (TYPEOF(x) != STRSXP)
    error("a character vector argument expected");
  n = XLENGTH(x);
  PROTECT(ans = allocVector(STRSXP, n));
  for (i = 0; i < n; i++) {
    if(IS_BYTES(STRING_ELT(x, i))) tmp = "bytes";
    else if(IS_LATIN1(STRING_ELT(x, i))) tmp = "latin1";
    else if(IS_UTF8(STRING_ELT(x, i))) tmp = "UTF-8";
    else tmp = "unknown";
    SET_STRING_ELT(ans, i, mkChar(tmp));
  }
  UNPROTECT(1);
  return ans;
}
