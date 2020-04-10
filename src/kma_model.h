// Copyright (C) 2017 Alessandro Zito (zito.ales@gmail.com)
//
// This file is part of Fdakmapp.
//
// Fdakmapp is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Fdakmapp is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
//   You should have received a copy of the GNU General Public License
//   along with Fdakmapp.  If not, see <http://www.gnu.org/licenses/>.

#ifndef _KMA_MODEL_HPP
#define _KMA_MODEL_HPP

#include <RcppArmadillo.h>

#include "dissimilarity.h"
#include "warping.h"
#include "center_methods.h"
#include "optimizer.h"

/// Main class.
/** This class handles loading of the problem and execution of the algorithm.
 */
class KmaModel
{
public:
    KmaModel()
    {
        m_InputGrids.reset();
        m_InputValues.reset();
        m_SeedVector.reset();

        m_NumberOfClusters = 1;
        m_MaximumNumberOfIterations = 100;
        m_NumberOfObservations = 1;
        m_NumberOfDimensions = 1;
        m_NumberOfPoints = 1;
        m_NumberOfThreads = 1;
        m_ParallelMethod = 0;

        m_ShiftUpperBound = 0.15;
        m_DilationUpperBound = 0.15;
        m_Tolerance = 0.001;

        m_UseFence = false;
        m_CheckTotalSimilarity = true;
        m_UseVerbose = true;
        m_ComputeOriginalCenters = false;

        std::string m_InterpolationMethod = "linear";
        std::string m_WarpingMethod = "affine";
        std::string m_CenterMethod = "mean";
        std::string m_DissimilarityMethod = "pearson";
        std::string m_OptimizerMethod = "bobyqa";
    }

    void SetInputData(const arma::mat &grids, const arma::cube &values);
    void SetWarpingMethod(const std::string &val);
    void SetCenterMethod(const std::string &method, const double &span);
    void SetDissimilarityMethod(const std::string &val);
    void SetOptimizerMethod(const std::string &val);

    void SetSeedVector(const arma::urowvec &val) {m_SeedVector = val;}

    void SetNumberOfClusters(const unsigned int &val) {m_NumberOfClusters = val;}
    void SetMaximumNumberOfIterations(const unsigned int &val) {m_MaximumNumberOfIterations = val;}
    void SetNumberOfThreads(const unsigned int &val) {m_NumberOfThreads = val;}
    void SetParallelMethod(const unsigned int &val) {m_ParallelMethod = val;}

    void SetShiftUpperBound(const double &val) {m_ShiftUpperBound = val;}
    void SetDilationUpperBound(const double &val) {m_DilationUpperBound = val;}
    void SetTolerance(const double &val) {m_Tolerance = val;}

    void SetUseFence(const bool &val) {m_UseFence = val;}
    void SetCheckTotalSimilarity(const bool &val) {m_CheckTotalSimilarity = val;}
    void SetUseVerbose(const bool &val) {m_UseVerbose = val;}
    void SetComputeOriginalCenters(const bool &val) {m_ComputeOriginalCenters = val;}

    void SetInterpolationMethod(const std::string &val) {m_InterpolationMethod = val;}

    // Method to get a description of the model.
    void Print(
            const std::string &warpingMethod,
            const std::string &centerMethod,
            const std::string &dissimilarityMethod,
            const std::string &optimizerMethod
    );

    /// Method to execute the algorithm.
    Rcpp::List FitModel();

private:
    arma::mat m_InputGrids;
    arma::cube m_InputValues;
    arma::urowvec m_SeedVector;

    unsigned int m_NumberOfClusters;
    unsigned int m_MaximumNumberOfIterations;
    unsigned int m_NumberOfObservations;
    unsigned int m_NumberOfDimensions;
    unsigned int m_NumberOfPoints;
    unsigned int m_NumberOfThreads;
    unsigned int m_ParallelMethod;

    double m_ShiftUpperBound;
    double m_DilationUpperBound;
    double m_Tolerance;

    bool m_UseFence;
    bool m_CheckTotalSimilarity;
    bool m_UseVerbose;
    bool m_ComputeOriginalCenters;

    std::string m_InterpolationMethod;

    std::shared_ptr<WarpingFunction> m_WarpingPointer;
    std::shared_ptr<Dissimilarity> m_DissimilarityPointer;
    std::shared_ptr<CenterMethod> m_CenterPointer;
    std::shared_ptr<OptimizerMethod> m_OptimizerPointer;
};

#endif
