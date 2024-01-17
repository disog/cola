cmake_minimum_required(VERSION 3.15)
cmake_policy(SET CMP0091 NEW)
cmake_policy(SET CMP0042 NEW)

project(@diegosogari/cola
  VERSION 0.1.0
  DESCRIPTION "JavaScript Node-API port of the [Adaptagrams](http://www.adaptagrams.org/) project"
  HOMEPAGE_URL "https://github.com/diegosogari/cola#readme"
  LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 11)
set(SOURCES src/cola.cc)
set(COLA_LIBS
  libtopology.a
  libcola.a
  libvpsc.a
  libavoid.a
)

if (EMSCRIPTEN)
  add_executable(binding ${SOURCES})
else ()
  add_library(binding SHARED ${SOURCES})
endif ()

target_include_directories(binding PRIVATE
  deps/adaptagrams/cola
)
target_compile_options(binding PRIVATE
  -Werror
  -Wall
  -Wextra
  -Wpedantic
  -Wno-type-limits
  -Wno-unused-function
  -Wno-unused-parameter
  -Wno-deprecated-copy
  -Wno-deprecated-declarations
)
target_compile_definitions(binding PRIVATE
  NAPI_VERSION=9
  NAPI_CPP_EXCEPTIONS
  # NODE_ADDON_API_DISABLE_DEPRECATED # SWIG still uses the deprecated symbols
)

if (MSVC)
  if(CMAKE_JS_NODELIB_DEF AND CMAKE_JS_NODELIB_TARGET)
    # Generate node.lib
    execute_process(COMMAND ${CMAKE_AR} /def:${CMAKE_JS_NODELIB_DEF} /out:${CMAKE_JS_NODELIB_TARGET} ${CMAKE_STATIC_LINKER_FLAGS})
  endif()
  target_compile_definitions(binding PRIVATE
    _HAS_EXCEPTIONS=1
    VCCLCompilerTool.ExceptionHandling=1
    VCCLCompilerTool.EnablePREfast=true
    VCCLCompilerTool.AdditionalOptions=[/wo6246,/wo28182]
  )
elseif (XCODE)
  target_compile_options(binding PRIVATE
    -fvisibility=hidden
    -Wno-sometimes-uninitialized
  )
  target_compile_definitions(binding PRIVATE
    GCC_ENABLE_CPP_RTTI=NO
    GCC_ENABLE_CPP_EXCEPTIONS=YES
    CLANG_CXX_LIBRARY=libc++
    MACOSX_DEPLOYMENT_TARGET=10.7
  )
endif ()

if (EMSCRIPTEN)
  list(TRANSFORM COLA_LIBS REPLACE \(.*\)\\.a ${CMAKE_SOURCE_DIR}/build-cola-wasm/\\1/.libs/\\1.a)
  set(EMNAPI_DIR ${CMAKE_SOURCE_DIR}/node_modules/emnapi)
  target_include_directories(binding PRIVATE
    ${EMNAPI_DIR}/include
    ${CMAKE_JS_INC}
  )
  target_link_libraries(binding
    ${COLA_LIBS}
    ${EMNAPI_DIR}/lib/wasm32-emscripten/libemnapi-basic.a
  )
  target_link_options(binding PRIVATE
    --no-entry
    -fwasm-exceptions
    -sALLOW_MEMORY_GROWTH
    -sMODULARIZE
    -sEXPORT_ES6
    -sWASM_BIGINT
    -sSTANDALONE_WASM
    -sEXPORTED_FUNCTIONS=['_napi_register_wasm_v1','_node_api_module_get_api_version_v1']
    --js-library=${EMNAPI_DIR}/dist/library_napi.js
  )
  target_compile_options(binding PRIVATE
    -fno-rtti
    -fwasm-exceptions
    -Wno-sometimes-uninitialized
    -Wno-defaulted-function-deleted
  )
  target_compile_definitions(binding PRIVATE
    __STDC_FORMAT_MACROS
    NAPI_EXTERN=__attribute__\(\(__import_module__\("env"\)\)\)
  )
  set_target_properties(binding PROPERTIES SUFFIX ".js")
else ()
  list(TRANSFORM COLA_LIBS REPLACE \(.*\)\\.a ${CMAKE_SOURCE_DIR}/build-cola-node/\\1/.libs/\\1.a)
  target_include_directories(binding PRIVATE ${CMAKE_JS_INC})
  target_link_libraries(binding ${COLA_LIBS})
  set_target_properties(binding PROPERTIES PREFIX "" SUFFIX ".node")
endif ()