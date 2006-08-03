################################################################################
#
# Watcom WMAKE Makefile for PDCurses library - Win32 Watcom C/C++ 10.6+
#
# Usage: wmake -f [win32\]wccwin32.mak [DEBUG=Y] [target]
#
# where target can be any of:
# [all|demos|pdcurses.lib|panel.lib|testcurs.exe...]
#
################################################################################
#
# First, set the environment variable PDCURSES_SRCDIR, or edit the line
# below; for example, "set PDCURSES_SRCDIR=c:\pdcurses".
#
################################################################################
PDCURSES_HOME	= $(%PDCURSES_SRCDIR)
################################################################################
# Nothing below here should require changing.
################################################################################

!include $(PDCURSES_HOME)\version

srcdir		= $(PDCURSES_HOME)\pdcurses
osdir		= $(PDCURSES_HOME)\win32
pandir		= $(PDCURSES_HOME)\panel
demodir		= $(PDCURSES_HOME)\demos

CC		= wcc386
TARGET		= nt

!ifeq DEBUG Y
CFLAGS		= /d2 /DPDCDEBUG
LDFLAGS		= D W A op q sys $(TARGET)
!else
CFLAGS		= /oneatx
LDFLAGS		= op q sys $(TARGET)
!endif

CPPFLAGS	= /i=$(PDCURSES_HOME) #/DPDC_WIDE

CCFLAGS		= /ei /zq /wx $(CFLAGS) $(CPPFLAGS)

LINK		= wlink

LIBEXE		= wlib /q /n /t

LIBCURSES	= pdcurses.lib
LIBPANEL	= panel.lib

PDCLIBS		= $(LIBCURSES) $(LIBPANEL)
DEMOS		= testcurs.exe newdemo.exe xmas.exe tuidemo.exe &
firework.exe ptest.exe rain.exe worm.exe

################################################################################
all:	$(PDCLIBS) $(DEMOS)

clean
	-del *.obj
	-del *.lib
	-del *.exe
	-del *.err

demos:	$(DEMOS)

#------------------------------------------------------------------------

LIBOBJS = addch.obj addchstr.obj addstr.obj attr.obj beep.obj bkgd.obj &
border.obj clear.obj color.obj delch.obj deleteln.obj getch.obj &
getstr.obj getyx.obj inch.obj inchstr.obj initscr.obj inopts.obj &
insch.obj insstr.obj instr.obj kernel.obj mouse.obj move.obj outopts.obj &
overlay.obj pad.obj printw.obj refresh.obj scanw.obj scr_dump.obj &
scroll.obj slk.obj termattr.obj terminfo.obj touch.obj util.obj &
window.obj pdcdebug.obj pdcwin.obj

PDCOBJS = pdcclip.obj pdcdisp.obj pdcgetsc.obj pdckbd.obj pdcscrn.obj &
pdcsetsc.obj pdcutil.obj

PANOBJS = panel.obj


$(LIBCURSES) : $(LIBOBJS) $(PDCOBJS)
	$(LIBEXE) $@ $(LIBOBJS) $(PDCOBJS)

$(LIBPANEL) : $(PANOBJS)
	$(LIBEXE) $@ $(PANOBJS)

.c: $(srcdir);$(osdir);$(pandir);$(demodir)
.c.obj: .autodepend
	$(CC) $(CCFLAGS) $<

#------------------------------------------------------------------------

firework.exe:	firework.obj $(LIBCURSES)
	$(LINK) $(LDFLAGS) n $@ f firework.obj l $(LIBCURSES)

newdemo.exe:	newdemo.obj $(LIBCURSES)
	$(LINK) $(LDFLAGS) n $@ f newdemo.obj l $(LIBCURSES)

ptest.exe:	ptest.obj $(LIBCURSES) $(LIBPANEL)
	$(LINK) $(LDFLAGS) n $@ f ptest.obj l $(LIBCURSES) l $(LIBPANEL)

rain.exe:	rain.obj $(LIBCURSES)
	$(LINK) $(LDFLAGS) n $@ f rain.obj l $(LIBCURSES)

testcurs.exe:	testcurs.obj $(LIBCURSES)
	$(LINK) $(LDFLAGS) n $@ f testcurs.obj l $(LIBCURSES)

tuidemo.exe:	tuidemo.obj tui.obj $(LIBCURSES)
	$(LINK) $(LDFLAGS) n $@ f tuidemo.obj f tui.obj l $(LIBCURSES)

worm.exe:	worm.obj $(LIBCURSES)
	$(LINK) $(LDFLAGS) n $@ f worm.obj l $(LIBCURSES)

xmas.exe:	xmas.obj $(LIBCURSES)
	$(LINK) $(LDFLAGS) n $@ f xmas.obj l $(LIBCURSES)


dist: .symbolic $(PDCLIBS)
	echo PDCurses $(VERDOT) for Watcom C++ Win32 > file_id.diz
	echo ------------------------------------------ >> file_id.diz
	echo Public Domain Curses library for >> file_id.diz
	echo Open Watcom 1.3 for Win32. >> file_id.diz
	echo Source available in PDCURS$(VER).ZIP >> file_id.diz
	echo Public Domain. >> file_id.diz
	zip -9jX pdc$(VER)_wcc_w32 &
	$(PDCURSES_HOME)\README $(PDCURSES_HOME)\HISTORY &
	$(PDCURSES_HOME)\maintain.er &
	$(PDCURSES_HOME)\curses.h $(PDCURSES_HOME)\curspriv.h &
	$(PDCURSES_HOME)\panel.h $(PDCURSES_HOME)\term.h &
	$(LIBCURSES) $(LIBPANEL) file_id.diz
	del file_id.diz
