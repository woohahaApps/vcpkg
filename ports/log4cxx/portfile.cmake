
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO stephen-webb/logging-log4cxx
    REF master
    SHA512 452fdf5fd5224ed4a480082ee98abc838d3b3c77dcfa7c18b6f6949ba6cf273d925ba2b873892ce5659914fd1839fc10003195f1a93602d7462e553e18491c0a
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DLOG4CXX_INSTALL_PDB=OFF # Installing pdbs failed on debug static. So, disable it and let vcpkg_copy_pdbs() do it
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
