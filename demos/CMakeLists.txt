add_executable(basic_demo basic_demo.c)
target_link_libraries(basic_demo pdcurses)

add_executable(firework firework.c)
target_link_libraries(firework pdcurses)

add_executable(tuidemo tuidemo.c tui.c)
target_link_libraries(tuidemo pdcurses)
