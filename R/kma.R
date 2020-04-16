#' K-mean alignment and variants for functional data
#'
#' @param x A matrix of size nObs x nPts storing the evaluation grid of each
#'   observation.
#' @param y An 3D array of size nObs x nDim x nPts storing the observation
#'   values.
#' @param seeds A vector of integers of size \code{n_clust} specifying the
#'   indices of the initial templates. Defaults to \code{NULL}, which boils down
#'   to randomly sampled indices.
#' @param warping_options A numeric vector supplied as a helper to the chosen
#'   \code{warping_method} to decide on warping parameter bounds.
#' @param n_clust An integer specifying the number of clusters (default: 1).
#' @param maximum_number_of_iterations An integer specifying the maximum number
#'   of iterations before the algorithm stops (default: 100).
#' @param number_of_threads An integer specifying the number of threads used for
#'   parallelization (default: 1). Not working for now.
#' @param parallel_method An integer value specifying the type of desired
#'   parallelization for template computation, If 0 (default), templates are
#'   computed in parallel. If 1, parallelization occurs within a single template
#'   computation (only for the medoid method as of now).
#' @param space An integer value specifying the space according to which
#'   operations should be performed. If 0 (default), the Eucliden space is used.
#'   If 1, unit quaternion space is used instead.
#' @param distance_relative_tolerance A number specifying a relative tolerance
#'   on the distance update between two iterations. If all observations have not
#'   sufficiently improved in that sense, the algorithm stops. Defaults to 1e-3.
#' @param use_fence A boolean specifying whether the fence algorithm should be
#'   used to robustify the algorithm against outliers (default: \code{FALSE}).
#'   Not working for now.
#' @param check_total_similarity A boolean specifying whether an additional
#'   stopping criterion based on improvement of the total dissimilarity should
#'   be used (default: \code{TRUE}).
#' @param use_verbose A boolean specifying whether the algorithm should output
#'   details of the steps to the console (default: \code{TRUE}).
#' @param compute_overall_center A boolean specifying whether the overall center
#'   should be also computed (default: \code{FALSE}).
#' @param warping_method A string specifying the warping method. Choices are
#'   \code{"none"}, \code{"shift"}, \code{"dilation"} and \code{"affine"}
#'   (default).
#' @param center_method A string specifying the center method. Choices are
#'   \code{"medoid"} and \code{"mean"} (default).
#' @param dissimilarity_method A string specifying the dissimilarity method.
#'   Choices are \code{"pearson"} and \code{"l2"} (default).
#' @param optimizer_method A string specifying the optimizer method. The only
#'   choice for now is \code{"bobyqa"}.
#'
#' @return The function output is a \code{kmap} object, which is a list with the following elements:
#' \item{x}{ as input.}
#' \item{y}{ as input. }
#' \item{seeds}{ vector with the indeces used in the algorithm.}
#' \item{warping_method}{ as input.}
#' \item{similarity_method}{ as input. }
#' \item{center_method}{ as input. }
#' \item{iterations}{scalar: total number of iterations performed by kma function.}
#' \item{n_clust}{ as input. }
#' \item{x.center.orig }{numeric vector \emph{n_out}: abscissa of the center computed if \emph{comp_original_center}=TRUE.}
#' \item{y.center.orig }{numeric vector \emph{n_out} or matrix \emph{n_out} X \emph{n_dim}: value of the center computed if \emph{comp_original_center}=TRUE.}
#' \item{similarity.origin}{numeric vector \emph{n_obs} dissimilarity,similarity or distance of the original center respect the obserbations computed if \emph{comp_original_center}=TRUE.}
#' \item{x.final }{matrix [n.func X grid.size]: aligned abscissas.}
#' \item{n.clust.final }{ scalar: final number of clusters. Note that n.clust.final may differ from initial number of clusters (i.e.,from n.clust) if some clusters are found to be empty.}
#' \item{x.centers.final }{matrix [n.clust.final X grid.size]: abscissas of the final function centers.}
#' \item{y.centers.final }{matrix [n.clust.final X n.out] or array [n.clust.final X n.out x n_dim] , contain the evaluations of the final functions centers.}
#' \item{templates_vec }{list iteration : each element of the list contain centers of that iteration.}
#' \item{x_out_vec }{list iteration : each element of the list contain the abscissa of the centers of that iteration.}
#' \item{labels}{vector n_obs: cluster assignments.}
#' \item{similarity.final}{vector [n_obs]: similarities,dissimilarities or distance between each function and the center of the cluster the function is assigned to.}
#' \item{parameters.list}{list [iterations]: warping parameters at each iteration.}
#' \item{parameters}{matrix [n_par X n_obs]: warping parameters applied to the original abscissas x to obtain the aligned abscissas x.final.}
#' \item{timer}{vector: time of execution by step. }
#' @export
#'
#' @examples
#' x <- simulated30$x
#' y <- array(dim = c(dim(x)[1], 1, dim(x)[2]))
#' y[, 1, ] <- simulated30$y[, , 1]
#'
#' res <- kma(
#'   x,
#'   y,
#'   seeds = c(21, 13),
#'   n_clust = 2,
#'   center_method = "medoid",
#'   warping_method = "affine",
#'   dissimilarity_method = "pearson"
#' )
kma <- function(x, y,
                seeds = NULL,
                warping_options = c(0.15, 0.15),
                n_clust = 1,
                maximum_number_of_iterations = 100,
                number_of_threads = 1,
                parallel_method = 0,
                space = 0,
                distance_relative_tolerance = 0.001,
                use_fence = FALSE,
                check_total_similarity = TRUE,
                use_verbose = TRUE,
                compute_overall_center = FALSE,
                warping_method = 'affine',
                center_method = 'mean',
                dissimilarity_method = 'l2',
                optimizer_method = 'bobyqa')
{
  # Handle one-dimensional data
  if (length(dim(y)) == 2) {
    y <- array(y, c(dim(y)[1], 1, dim(y)[2]))
  }

  # Handle vector grid
  if (is.vector(x))
   x <- matrix(x, dim(y)[1], dim(y)[3], byrow = TRUE)

  # Handle seeds
  if (is.null(seeds))
    seeds <- sample(0:(dim(y)[1] - 1), n_clust)
  else
    seeds <- seeds - 1

  out <- kmap(
    x,
    y,
    seeds,
    warping_options,
    n_clust,
    maximum_number_of_iterations,
    number_of_threads,
    parallel_method,
    space,
    distance_relative_tolerance,
    use_fence,
    check_total_similarity,
    use_verbose,
    compute_overall_center,
    warping_method,
    center_method,
    dissimilarity_method,
    optimizer_method
  )

  ## gestione timer  ################################################
  time <- diff(round(out$timer / 1000000000, 4))
  t <- data.frame(0, 0, 0, 0, 0, 0)
  names(t) <-
    c("start", "warping", "fece/norm", "templates", "output", "total")
  rownames(t) <- c("sec")
  t[1] <- time[1]
  for (i in 0:(out$iterations - 1)) {
    t[2] = t[2] + time[2 + (i * 3)]
    t[3] = t[3] + time[3 + (i * 3)]
    t[4] = t[4] + time[4 + (i * 3)]
  }
  t[5] = time[out$iterations * 3 + 2]
  t[6] = out$timer[length(out$timer)] / 1000000000
  out$timer <- t
    #######################################################################

  out <- c(
    x = list(x),
    y = list(y),
    seeds = list(seeds),
    warping_method = list(warping_method),
    similarity_method = list(dissimilarity_method),
    center_method = list(center_method),
    out
  )

  class(out) <- "kma"

  out
}