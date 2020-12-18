cmake_minimum_required(VERSION 3.13.4)
project(pdcurses)

# if(MSVC)
#     add_compile_options(/WX)
# else()
#     add_compile_options(-Werror)
# endif()

include_directories(${CMAKE_SOURCE_DIR})

add_subdirectory(pdcurses)
add_subdirectory(wincon)
add_subdirectory(demos)
