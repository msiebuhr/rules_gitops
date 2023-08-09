# Copyright 2020 Adobe. All rights reserved.
# This file is licensed to you under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License. You may obtain a copy
# of the License at http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software distributed under
# the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
# OF ANY KIND, either express or implied. See the License for the specific language
# governing permissions and limitations under the License.

"""
GtiOps rules repositories initialization
"""

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
load("@aspect_bazel_lib//lib:repositories.bzl", "aspect_bazel_lib_dependencies", "register_jq_toolchains")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("@rules_oci//oci:dependencies.bzl", "rules_oci_dependencies")
load("@rules_oci//oci:repositories.bzl", "LATEST_CRANE_VERSION", "oci_register_toolchains")
load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")
load("@io_bazel_rules_docker//repositories:go_repositories.bzl", container_go_deps = "go_deps")
load("@com_adobe_rules_gitops//skylib/kustomize:kustomize.bzl", "kustomize_setup")

def rules_gitops_repositories():
    """Initializes Declares workspaces the GitOps rules depend on.

    Workspaces that use rules_gitops should call this after rules_gitops_dependencies call.
    """

    bazel_skylib_workspace()
    gazelle_dependencies()
    aspect_bazel_lib_dependencies(override_local_config_platform = True)
    register_jq_toolchains()
    rules_oci_dependencies()
    container_repositories()
    container_go_deps()
    kustomize_setup(name = "kustomize_bin")

    oci_register_toolchains(
        name = "oci",
        crane_version = LATEST_CRANE_VERSION,
    )
