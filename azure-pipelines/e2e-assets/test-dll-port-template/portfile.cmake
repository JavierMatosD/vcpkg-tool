file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/include")
file(COPY "${CMAKE_CURRENT_LIST_DIR}/test.h" DESTINATION "${CURRENT_PACKAGES_DIR}/include")

file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(TOUCH "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright")

if("release-only" IN_LIST FEATURES AND NOT "bad-release-only" IN_LIST FEATURES)
    set(VCPKG_BUILD_TYPE release)
endif()

if(NOT "install-no-lib-release" IN_LIST FEATURES AND NOT "debug-only" IN_LIST FEATURES)
    file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/lib")
    file(COPY "${CMAKE_CURRENT_LIST_DIR}/release/test_dll.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
endif()

if(NOT "install-no-lib-debug" IN_LIST FEATURES AND NOT "release-only" IN_LIST FEATURES)
    file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/debug/lib")
    file(COPY "${CMAKE_CURRENT_LIST_DIR}/debug/test_dll.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")
endif()

if("install-to-lib" IN_LIST FEATURES)
    if(NOT "debug-only" IN_LIST FEATURES)
        file(COPY "${CMAKE_CURRENT_LIST_DIR}/release/test_dll.dll" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
    endif()
    if(NOT "release-only" IN_LIST FEATURES)
        file(COPY "${CMAKE_CURRENT_LIST_DIR}/debug/test_dll.dll" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")
    endif()
else()
    if(NOT "debug-only" IN_LIST FEATURES)
        file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/bin")
        file(COPY "${CMAKE_CURRENT_LIST_DIR}/release/test_dll.dll" DESTINATION "${CURRENT_PACKAGES_DIR}/bin")
    endif()
    if(NOT "release-only" IN_LIST FEATURES)
        file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/debug/bin")
        file(COPY "${CMAKE_CURRENT_LIST_DIR}/debug/test_dll.dll" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/bin")
    endif()
endif()

if("extra-debug" IN_LIST FEATURES)
    file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/debug/test_dll.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib" RENAME "test_dll2.lib")
    file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/debug/test_dll.dll" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/bin" RENAME "test_dll2.dll")
endif()

if("extra-release" IN_LIST FEATURES)
    file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/release/test_dll.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/lib" RENAME "test_dll2.lib")
    file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/release/test_dll.dll" DESTINATION "${CURRENT_PACKAGES_DIR}/bin" RENAME "test_dll2.dll")
endif()

if("policy-skip-architecture-check" IN_LIST FEATURES)
    set(VCPKG_POLICY_SKIP_ARCHITECTURE_CHECK enabled)
endif()
if("policy-skip-appcontainer-check" IN_LIST FEATURES)
    set(VCPKG_POLICY_SKIP_APPCONTAINER_CHECK enabled)
endif()
if("policy-allow-dlls-in-lib" IN_LIST FEATURES)
    set(VCPKG_POLICY_ALLOW_DLLS_IN_LIB enabled)
endif()
if("policy-allow-kernel32-from-xbox" IN_LIST FEATURES)
    set(VCPKG_POLICY_ALLOW_KERNEL32_FROM_XBOX enabled)
endif()
if("policy-dlls-in-static-library" IN_LIST FEATURES)
    set(VCPKG_POLICY_DLLS_IN_STATIC_LIBRARY enabled)
endif()
if("policy-mismatched-number-of-binaries" IN_LIST FEATURES)
    set(VCPKG_POLICY_MISMATCHED_NUMBER_OF_BINARIES enabled)
endif()
if("policy-dlls-without-libs" IN_LIST FEATURES)
    set(VCPKG_POLICY_DLLS_WITHOUT_LIBS enabled)
endif()
