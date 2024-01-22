cmake_minimum_required(VERSION 3.15)
cmake_policy(SET CMP0091 NEW)
cmake_policy(SET CMP0042 NEW)

project(@diegosogari/cola
  VERSION 0.1.0
  DESCRIPTION "JavaScript Node-API port of the [Adaptagrams](http://www.adaptagrams.org/) project"
  HOMEPAGE_URL "https://github.com/diegosogari/cola#readme"
  LANGUAGES CXX
)

if (NOT EMSCRIPTEN)
  message(FATAL_ERROR "Only Wasm target is supported. Run with 'emcmake'.")
endif ()

set(CMAKE_CXX_STANDARD 11)

add_executable(binding src/cola.cc)

set_target_properties(binding PROPERTIES SUFFIX ".js")

target_include_directories(binding PRIVATE
  ${CMAKE_SOURCE_DIR}/deps/adaptagrams/cola
  ${CMAKE_SOURCE_DIR}/node_modules/emnapi/include
  ${CMAKE_JS_INC}
)

target_compile_options(binding PRIVATE
  -fno-rtti
  -fwasm-exceptions
  -Werror
  -Wall
  -Wextra
  -Wpedantic
  -Wno-type-limits
  -Wno-unused-function
  -Wno-unused-parameter
  -Wno-deprecated-copy
  -Wno-deprecated-declarations
  -Wno-sometimes-uninitialized
  -Wno-defaulted-function-deleted
)

target_compile_definitions(binding PRIVATE
  NAPI_VERSION=9
  NAPI_CPP_EXCEPTIONS
  NAPI_EXTERN=__attribute__\(\(__import_module__\("env"\)\)\)
  # NODE_ADDON_API_DISABLE_DEPRECATED # SWIG still uses deprecated symbols
)

target_link_libraries(binding
  ${CMAKE_SOURCE_DIR}/build-cola/libtopology/.libs/libtopology.a
  ${CMAKE_SOURCE_DIR}/build-cola/libcola/.libs/libcola.a
  ${CMAKE_SOURCE_DIR}/build-cola/libvpsc/.libs/libvpsc.a
  ${CMAKE_SOURCE_DIR}/build-cola/libavoid/.libs/libavoid.a
  ${CMAKE_SOURCE_DIR}/node_modules/emnapi/lib/wasm32-emscripten/libemnapi-basic.a
)

# See https://emsettings.surma.technology/
target_link_options(binding PRIVATE
  --no-entry
  -fwasm-exceptions
  -sALLOW_MEMORY_GROWTH
  -sMODULARIZE
  -sEXPORT_ES6
  -sWASM_BIGINT
  -sSTANDALONE_WASM
  -sEXPORTED_FUNCTIONS=['_napi_register_wasm_v1','_node_api_module_get_api_version_v1']
  --js-library=${CMAKE_SOURCE_DIR}/node_modules/emnapi/dist/library_napi.js
)
