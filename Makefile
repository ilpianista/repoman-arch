# Makefile for Repoman
#
# Copyright (C) 2008-2011 Andrea Scarpino <andrea@archlinux.org>
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
DESTDIR =
bindir = /usr/bin
sysconfdir = /etc

all:

install: all
	$(INSTALL) -d $(DESTDIR)$(bindir)
	$(INSTALL) -d $(DESTDIR)$(sysconfdir)
	$(INSTALL) -m755 repoman $(DESTDIR)$(bindir)
	$(INSTALL) -m644 etc/repoman.conf $(DESTDIR)$(sysconfdir)
