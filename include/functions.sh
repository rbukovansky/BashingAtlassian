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

# SCRIPT RUNNING SWITCHES
set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace

# FUNCTIONS
function __BA:fileExists() {
	local filePath="$1"

	[[ -f "${filePath}" ]]
}

function __BA:logError() {
	local errorCode="$1"
	local errorMessage="$2"
	local logToFile="$3"
}
