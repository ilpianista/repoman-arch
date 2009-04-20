# Makefile for Repoman
#
# Copyright (C) 2008-2009 Andrea Scarpino <bash.lnx@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

SHELL = /bin/bash
INSTALL = /bin/install -c
MSGFMT = /usr/bin/msgfmt
SED = /bin/sed
DESTDIR =
bindir = /usr/bin
libdir = /usr/lib/repoman
sysconfdir = /etc
localedir = /usr/share/locale


PROGRAMS = repoman
install: 
	$(INSTALL) -d $(DESTDIR)$(bindir)
	$(INSTALL) -d $(DESTDIR)$(libdir)
	$(INSTALL) -d $(DESTDIR)$(sysconfdir)
	$(INSTALL) -m755 repoman $(DESTDIR)$(bindir)
	$(INSTALL) -m644 etc/repoman.conf $(DESTDIR)$(sysconfdir)
	$(INSTALL) -m644 lib/basicfunctions.sh $(DESTDIR)$(libdir)
	for file in po/*.po; \
	do \
	  lang=$$(echo $$file | $(SED) -e 's#.*/\([^/]\+\).po#\1#'); \
	  $(INSTALL) -d $(DESTDIR)$(localedir)/$$lang/LC_MESSAGES; \
	  $(MSGFMT) -o $(DESTDIR)$(localedir)/$$lang/LC_MESSAGES/repoman.mo $$file; \
	done
