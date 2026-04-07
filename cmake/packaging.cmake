# SPDX-License-Identifier: MIT
# CPack configuration for binary/source archives.

include_guard(GLOBAL)

set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VENDOR "project_xxx")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Embedded C starter template")
set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CMAKE_SYSTEM_NAME}")

# Portable default generators; can be overridden by users/CI.
set(CPACK_GENERATOR "TGZ;ZIP")
set(CPACK_SOURCE_GENERATOR "TGZ")
set(CPACK_SOURCE_IGNORE_FILES
    "/build/"
    "/install/"
    "/[.]git/"
    "/[.]idea/"
    "/[.]vscode/"
)

include(CPack)
