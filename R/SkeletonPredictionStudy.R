# @file SkeletonPredictionStudy.R
#
# Copyright 2020 Observational Health Data Sciences and Informatics
#
# This file is part of SkeletonPredictionStudy
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' SkeletonPredictionStudy
#' 
#' @description A package for running prediction model development studies using data in the OMOP CDM
#'
#' @docType package
#' @name SkeletonPredictionStudy
#' @importFrom dplyr %>%
#' @importFrom rlang .data



covSet_test<- createCovariateSettings( 
			useDemographicsAge = TRUE 
 )
 
 
pop_settings=createStudyPopulationSettings(binary = T,
			includeAllOutcomes = T,
			firstExposureOnly = FALSE, 
			washoutPeriod = 0,
			removeSubjectsWithPriorOutcome = TRUE, 
			priorOutcomeLookback = 99999,
			requireTimeAtRisk = T,
			minTimeAtRisk = 364, 
			riskWindowStart = 0,
			startAnchor = "cohort start",
			riskWindowEnd = 99999, 
			endAnchor = "cohort start",
			restrictTarToCohortEnd = F)
			


pre_process=createPreprocessSettings(minFraction = 0.001,
									normalize = TRUE,
									removeRedundancy = TRUE )
#restriction settings
restrict_plp_data=	createRestrictPlpDataSettings (studyStartDate = "",
												studyEndDate = "",
												firstExposureOnly = F,
												washoutPeriod = 0,
												sampleSize = NULL)
												
						


splitSettings <- createDefaultSplitSetting(
                    trainFraction = 0.75,
                    testFraction = 0.25,
                    type = 'subject',
                    nfold = 3,
                    splitSeed = 123)						
 
modelDesign1 <- createModelDesign(
  targetId = 1, 
  outcomeId = 2, 
  restrictPlpDataSettings = restrict_plp_data, 
  populationSettings = pop_settings, 
  covariateSettings = covSet_test, 
  featureEngineeringSettings = createFeatureEngineeringSettings(),
  sampleSettings = createSampleSettings(), 
  preprocessSettings = pre_process, 
  modelSettings = setLassoLogisticRegression()
  )
  
  
  
 modelDesign2 <- createModelDesign(
  targetId = 1, 
  outcomeId = 2, 
  restrictPlpDataSettings = restrict_plp_data, 
  populationSettings = pop_settings, 
  covariateSettings = covSet_test, 
  featureEngineeringSettings = createFeatureEngineeringSettings(),
  sampleSettings = createSampleSettings(), 
  preprocessSettings = pre_process, 
  modelSettings = setGradientBoostingMachine()
   )
  
