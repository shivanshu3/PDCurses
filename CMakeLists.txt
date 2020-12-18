cmake_minimum_required(VERSION 3.13.4)
project(pdcurses)

include_directories(${CMAKE_SOURCE_DIR})

add_compile_definitions(_CRT_SECURE_NO_WARNINGS)

file(GLOB PDCURSES_WINCON_C_FILES wincon/*.c)
file(GLOB PDCURSES_MAIN_C_FILES pdcurses/*.c)

add_library(pdcurses STATIC ${PDCURSES_MAIN_C_FILES} ${PDCURSES_WINCON_C_FILES})

add_subdirectory(demos)
