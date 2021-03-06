# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

timesTwo <- function(x) {
    .Call('_mimosa_timesTwo', PACKAGE = 'mimosa', x)
}

randomShuffle <- function(a) {
    .Call('_mimosa_randomShuffle', PACKAGE = 'mimosa', a)
}

#' Make matrix of permutations for mantel test with a row for each permutation and a column for each sample
#'
#' @param nSamples number of samples
#' @param nPerm number of permutations
make_perm_mat <- function(nSamples, nPerm) {
    .Call('_mimosa_make_perm_mat', PACKAGE = 'mimosa', nSamples, nPerm)
}

