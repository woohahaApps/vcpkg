
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO stephen-webb/logging-log4cxx
    REF master
    SHA512 73400110241821ac903c4c1d889adbedf6404eac70da537b634206d59aa3d13bb89e6584eb6646aa21a185b40615aca40972246ba43f8ddf46ecc9d3a73f9551
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DLOG4CXX_INSTALL_PDB=ON
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
