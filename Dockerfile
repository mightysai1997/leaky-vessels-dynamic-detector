# © 2024 Snyk Limited
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
FROM golang:1.21-alpine3.19 as builder

WORKDIR /workspace
COPY . /workspace/
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w"

FROM alpine:3.20.3

WORKDIR /
COPY --from=builder /workspace/ebpf-detector .
ENTRYPOINT ["/ebpf-detector"]
