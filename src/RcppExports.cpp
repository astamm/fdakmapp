// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <RcppEigen.h>
#include <Rcpp.h>

using namespace Rcpp;

// kmap
Rcpp::List kmap(const arma::mat& x, const arma::cube& y, const arma::urowvec& seeds, const arma::rowvec& warping_options, const unsigned int& n_clust, const unsigned int& maximum_number_of_iterations, const unsigned int& number_of_threads, const unsigned int& parallel_method, const unsigned int& space, const double& distance_relative_tolerance, const bool& use_fence, const bool& check_total_dissimilarity, const bool& use_verbose, const bool& compute_overall_center, const std::string& warping_method, const std::string& center_method, const std::string& dissimilarity_method, const std::string& optimizer_method);
RcppExport SEXP _fdakmapp_kmap(SEXP xSEXP, SEXP ySEXP, SEXP seedsSEXP, SEXP warping_optionsSEXP, SEXP n_clustSEXP, SEXP maximum_number_of_iterationsSEXP, SEXP number_of_threadsSEXP, SEXP parallel_methodSEXP, SEXP spaceSEXP, SEXP distance_relative_toleranceSEXP, SEXP use_fenceSEXP, SEXP check_total_dissimilaritySEXP, SEXP use_verboseSEXP, SEXP compute_overall_centerSEXP, SEXP warping_methodSEXP, SEXP center_methodSEXP, SEXP dissimilarity_methodSEXP, SEXP optimizer_methodSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const arma::mat& >::type x(xSEXP);
    Rcpp::traits::input_parameter< const arma::cube& >::type y(ySEXP);
    Rcpp::traits::input_parameter< const arma::urowvec& >::type seeds(seedsSEXP);
    Rcpp::traits::input_parameter< const arma::rowvec& >::type warping_options(warping_optionsSEXP);
    Rcpp::traits::input_parameter< const unsigned int& >::type n_clust(n_clustSEXP);
    Rcpp::traits::input_parameter< const unsigned int& >::type maximum_number_of_iterations(maximum_number_of_iterationsSEXP);
    Rcpp::traits::input_parameter< const unsigned int& >::type number_of_threads(number_of_threadsSEXP);
    Rcpp::traits::input_parameter< const unsigned int& >::type parallel_method(parallel_methodSEXP);
    Rcpp::traits::input_parameter< const unsigned int& >::type space(spaceSEXP);
    Rcpp::traits::input_parameter< const double& >::type distance_relative_tolerance(distance_relative_toleranceSEXP);
    Rcpp::traits::input_parameter< const bool& >::type use_fence(use_fenceSEXP);
    Rcpp::traits::input_parameter< const bool& >::type check_total_dissimilarity(check_total_dissimilaritySEXP);
    Rcpp::traits::input_parameter< const bool& >::type use_verbose(use_verboseSEXP);
    Rcpp::traits::input_parameter< const bool& >::type compute_overall_center(compute_overall_centerSEXP);
    Rcpp::traits::input_parameter< const std::string& >::type warping_method(warping_methodSEXP);
    Rcpp::traits::input_parameter< const std::string& >::type center_method(center_methodSEXP);
    Rcpp::traits::input_parameter< const std::string& >::type dissimilarity_method(dissimilarity_methodSEXP);
    Rcpp::traits::input_parameter< const std::string& >::type optimizer_method(optimizer_methodSEXP);
    rcpp_result_gen = Rcpp::wrap(kmap(x, y, seeds, warping_options, n_clust, maximum_number_of_iterations, number_of_threads, parallel_method, space, distance_relative_tolerance, use_fence, check_total_dissimilarity, use_verbose, compute_overall_center, warping_method, center_method, dissimilarity_method, optimizer_method));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_fdakmapp_kmap", (DL_FUNC) &_fdakmapp_kmap, 18},
    {NULL, NULL, 0}
};

RcppExport void R_init_fdakmapp(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
