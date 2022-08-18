#!/usr/bin/env bash

set -e

function main() {
    EXECROOT_PATH="$(head -1 %ROOT_DIR_FILE%)/execroot/${TEST_WORKSPACE}"
    CUE_BINARY="${EXECROOT_PATH}/%CUE_EXECUTABLE%"

    unzip -qo "%SCHEMA_MODULE_ZIP_ARCHIVE%"

    PRESENT_WORKING_DIRECTORY=`pwd`
    ORIGINAL_SCHEMA_PATH="%SCHEMA_PATH%"

    SCHEMA_MODULE_ROOT="%SCHEMA_MODULE_ROOT%"
    SCHEMA_PATH=${ORIGINAL_SCHEMA_PATH#"$SCHEMA_MODULE_ROOT"}
    SCHEMA_PATH=${SCHEMA_PATH#"/"}
    cd "${SCHEMA_MODULE_ROOT}"
    FILES_TO_VET=(%FILES_TO_VET%)

    for FILE_TO_VET in ${FILES_TO_VET[@]}
    do
        FILE_TO_VET=${FILE_TO_VET#"$SCHEMA_MODULE_ROOT"}
        FILE_TO_VET=${FILE_TO_VET#"/"}
        $CUE_BINARY vet "${FILE_TO_VET}" "${SCHEMA_PATH}"
        echo "Vetted ${FILE_TO_VET} successfully."
    done
}

main "$@"