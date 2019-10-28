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
source "${scriptDirectoryPath}/include/configuration.sh"

# FUNCTIONS
function __BA:API:Get() {
	local applicationKey="$1"
	local apiName="$2"
	local apiResource="$3"

	# public variable apiURL is set
	if ! __BA:Configuration:Load "${applicationKey}" "${apiName}" "${apiResource}"; then
		printf "Loading environment configuration failed.\n\n"
		exit 1
	fi

	local response=$(curl --silent --header "Content-Type: application/json" --header "Accept: application/json" -X GET ${apiSecureConnection} --user "${apiCredentials}" "${apiURL}")
	local responseReturnCode=$?

	if [[ $responseReturnCode -ne 0 ]]; then
		printf "Loading data from REST API with GET method failed.\n\n"
		exit 1
	fi

	BAAPIResponse="${response}"
}

function __BA:API:Post() {
	local applicationKey="$1"
	local apiName="$2"
	local apiResource="$3"
	local payload="$4"

	# public variable apiURL is set
	if ! __BA:Configuration:Load "${applicationKey}" "${apiName}" "${apiResource}"; then
		printf "Loading environment configuration failed.\n\n"
		exit 1
	fi

	local response=$(curl --silent --header "Content-Type: application/json" --header "Accept: application/json" -X POST -d "${payload}" ${apiSecureConnection} --user "${apiCredentials}" "${apiURL}")
	local responseReturnCode=$?

	if [[ $responseReturnCode -ne 0 ]]; then
		printf "Sending data to REST API with POST method failed.\n\n"
		exit 1
	fi
}

function __BA:API:Put() {
	local applicationKey="$1"
	local apiName="$2"
	local apiResource="$3"
	local payload="$4"

	# public variable apiURL is set
	if ! __BA:Configuration:Load "${applicationKey}" "${apiName}" "${apiResource}"; then
		printf "Loading environment configuration failed.\n\n"
		exit 1
	fi

	local response=$(curl --silent --header "Content-Type: application/json" --header "Accept: application/json" -X PUT -d "${payload}" ${apiSecureConnection} --user "${apiCredentials}" "${apiURL}")
	local responseReturnCode=$?

	if [[ $responseReturnCode -ne 0 ]]; then
		printf "Sending data to REST API with PUT method failed.\n\n"
		exit 1
	fi

	BAAPIResponse="${response}"
}

function __BA:API:Delete() {
	local applicationKey="$1"
	local apiName="$2"
	local apiResource="$3"

	# public variable apiURL is set
	if ! __BA:Configuration:Load "${applicationKey}" "${apiName}" "${apiResource}"; then
		printf "Loading environment configuration failed.\n\n"
		exit 1
	fi

	local response=$(curl --silent --header "Content-Type: application/json" --header "Accept: application/json" -X DELETE ${apiSecureConnection} --user "${apiCredentials}" "${apiURL}")
	local responseReturnCode=$?

	if [[ $responseReturnCode -ne 0 ]]; then
		printf "Deleting data from REST API with DELETE method failed.\n\n"
		exit 1
	fi

	BAAPIResponse="${response}"
}
