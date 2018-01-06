#!/bin/bash

# Copyright 2017 Caicloud Inc. All Rights Reserved.
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

set -o errexit
set -o nounset
set -o pipefail

ROOT=$(dirname ${BASH_SOURCE})/..
BOILERPLATE=${ROOT}/hack/custom-boilerplate.go.txt
CODEGEN_PKG=${CODEGEN_PKG:-$(cd ${ROOT}; ls -d -1 ./vendor/k8s.io/code-generator 2>/dev/null || echo ../code-generator)}

echo "CODEGEN_PKG: ${CODEGEN_PKG}"

# generate the code with:
# --output-base    because this script should also be able to run inside the vendor dir of
#                  k8s.io/kubernetes. The output-base is needed for the generators to output into the vendor dir
#                  instead of the $GOPATH directly. For normal projects this can be dropped.

${CODEGEN_PKG}/generate-groups.sh "all" \
  github.com/caicloud/kubeflow-clientset github.com/caicloud/kubeflow-clientset/apis \
  kubeflow:v1alpha1 \
  --go-header-file ${BOILERPLATE}
