#' Integrated Path Stability Selection (IPSS)
#'
#' A lightweight wrapper around the Python IPSS package for fast feature selection with false discovery control.
#'
#' @param X A numeric matrix of shape \code{n x p}, where \code{n} is the number of samples and \code{p} is the number of features.
#' @param y A numeric response vector of length \code{n}.
#' @param ... Additional arguments passed to the Python \code{ipss} function.
#'
#' @return A list containing:
#' \describe{
#'   \item{efp_scores}{Named numeric vector of E(FP) scores (length \code{p}).}
#'   \item{q_values}{Named numeric vector of q-values (length \code{p}).}
#'   \item{runtime}{Runtime in seconds (numeric).}
#'   \item{selected_features}{Integer vector of selected feature indices.}
#'   \item{stability_paths}{Numeric matrix of estimated selection probabilities (\code{n_lambdas x p}).}
#' }
#'
#' @examples
#' \dontrun{
#' X <- matrix(rnorm(100 * 200), 100, 200)
#' y <- X[,1] + X[,2] + X[,3] + rnorm(100)
#' out <- ipss(X, y, selector = 'l1')
#' }
#'
#' @export
ipss <- function(X, y, ...) {
	np <- reticulate::import("numpy", convert = FALSE)
	X <- np$array(X)
	y <- np$array(y)
	ipss <- reticulate::import("ipss")
	results <- ipss$ipss(X, y, ...)
	names(results$efp_scores) <- as.character(as.integer(names(results$efp_scores)) + 1L)
	names(results$q_values)   <- as.character(as.integer(names(results$q_values)) + 1L)
	results$selected_features <- as.integer(results$selected_features) + 1L
	return(results)
}


