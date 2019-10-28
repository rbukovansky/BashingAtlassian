#!/usr/bin/env bash

# Copyright 2019 Richard Bukovanský
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Author: Richard Bukovanský, richard.bukovansky@gmail.com
# This file is part of Bashing Altassian project
# https://github.com/rbukovansky/BashingAtlassian
#
# SPDX-License-Indentifier: Apache-2.0

# Script running switches
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

# LOAD LIBRARIES
source "${scriptDirectoryPath}/include/functions.sh"
source "${scriptDirectoryPath}/include/yaml.sh"

# FUNCTIONS
# private function __BA:Configuration:Load
#
function __BA:Configuration:Load() {
	local applicationKey="$1"
	local apiName="$2"
	local apiResource="$3"

	local configFilePath="${scriptDirectoryPath}/config/${environmentKey}.config.yaml"

	if __BA:fileExists "${configFilePath}"; then
		#load configuration from
		eval "create_variables \"${configFilePath}\" \"\""
	else
		printf "Selected environment configuration file was not found.\n\n"
		exit 1
	fi

	local applicationProtocolVarName="${applicationKey}_protocol[0]"
	eval "local applicationProtocol=\"\${${applicationProtocolVarName}}\""
	local applicationServerVarName="${applicationKey}_server[0]"
	eval "local applicationServer=\"\${${applicationServerVarName}}\""
	local applicationCredentialsVarName="${applicationKey}_credentials[0]"
	eval "local applicationCredentials=\"\${${applicationCredentialsVarName}}\""
	local applicationSecureConnectionVarName="${applicationKey}_secure[0]"
	eval "local applicationSecureConnection=\"\${${applicationSecureConnectionVarName}}\""


	if [[ -z applicationProtocol || -z applicationServer || -z applicationCredentials || -z applicationSecureConnection ]]; then
		printf "Wrong configuration, something is not properly set.\n\n"
		exit 1
	fi

	applicationBaseURL="${applicationProtocol}://${applicationServer}"
	apiURL="${applicationBaseURL}/rest/${apiName}/latest/${apiResource}"
	apiCredentials="${applicationCredentials}"

	if [[ "${applicationSecureConnection}" == "true" ]]; then
		apiSecureConnection=""
	else
		apiSecureConnection="--insecure"
	fi
}

#WORKER

environmentKey=""

if [[ -n "${BA_DEFAULT_ENVIRONMENT}" ]]; then
	environmentKey="${BA_DEFAULT_ENVIRONMENT}"
else
	environmentKey="${BA_PARSED_ENVIRONMENT}"
fi

if [[ -z "${environmentKey}" ]]; then
	printf "The default environment is not set or application calling BashingAtlassian library did not provide one.\n\n"
	exit 1
fi

# if [[ -n "${BA_ACCESS_TOKEN}"]]
