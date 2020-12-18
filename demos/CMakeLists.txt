add_executable(basic_demo basic_demo.c)
target_link_libraries(basic_demo pdcurses_main pdcurses_wincon)

add_executable(firework firework.c)
target_link_libraries(firework pdcurses_main pdcurses_wincon)

add_executable(tuidemo tuidemo.c tui.c)
target_link_libraries(tuidemo pdcurses_main pdcurses_wincon)
