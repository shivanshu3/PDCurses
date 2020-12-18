file(GLOB PDCURSES_MAIN_C_FILES *.c)

add_library(pdcurses_main STATIC ${PDCURSES_MAIN_C_FILES})
