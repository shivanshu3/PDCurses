file(GLOB PDCURSES_WINCON_C_FILES *.c)

add_library(pdcurses_wincon STATIC ${PDCURSES_WINCON_C_FILES})
