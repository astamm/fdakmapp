#' Simulated data for examples.
#'
#' A data set containing 30 simulated uni-dimensional curves.
#'
#' @format A list with abscissas x and values y:
#' \describe{
#'   \item{x}{Matrix 30x200;}
#'   \item{y}{Array 30x1x200.}
#' }
#'
"simulated30"

#' Simulated data from the CSDA paper
#'
#' A data set containing 90 simulated uni-dimensional curves.
#'
#' @format A list with abscissas x and values y:
#' \describe{
#'   \item{x}{Vector of size 100;}
#'   \item{y}{Matrix if size 90x100.}
#' }
#'
"simulated90"

#' Subset of the AneuRisk65 benchmark data set
#'
#' A data set containing the first derivative of the three-dimensional
#' coordinates of the centerline of the internal carotid artery of 65 patients.
#'
#' @format A list with 2 components:
#' \describe{
#'   \item{x}{A 65 x 1380 matrix containing, in each row, the evaluation grid
#'   for each patient;}
#'   \item{y}{A 65 x 3 x 1380 array containing, in each row, the values of the
#'   first derivative of each of the 3D coordinates of the ICA centerline,
#'   stored by a row in a matrix.}
#' }
#'
#' @source This is a subset of the [AneuRisk65 benchmark data
#'   set](https://statistics.mox.polimi.it/aneurisk/) provided by the AneuRisk
#'   project.
#'
#' @references \enumerate{
#'   \item Sangalli, L.M., Secchi, P. and Vantini, S. (2014), [AneuRisk65:
#'   three-dimensional cerebral vascular
#'   geometries](http://projecteuclid.org/euclid.ejs/1414588176), Electronic
#'   Journal of Statistics, 8 (2), 1879-1890.
#'   \item Sangalli, L.M., Secchi, P. and Vantini, S. (2014), [Analysis of
#'   AneuRisk65 data: K-mean
#'   Alignment](http://projecteuclid.org/euclid.ejs/1414588177), Electronic
#'   Journal of Statistics, 8 (2), 1891-1904.
#' }
#'
"aneurisk65"
