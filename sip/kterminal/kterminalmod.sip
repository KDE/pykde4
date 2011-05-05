%Copying

 Copyright (c) 2011 Shaheed Haque (srhaque@theiet.org)

 This file is part of PyKDE4.

 PyKDE4 is free software; you can redistribute it and/or modify
 it under the terms of the GNU Lesser General Public License as
 published by the Free Software Foundation; either version 2.1 of
 the License, or (at your option) any later version.

 PyKDE4 is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http:www.gnu.org/licenses/>.

%End

/**
 * Compile using something like:
 *
 * sip -I /usr/share/sip/PyQt4 -I /usr/share/sip/PyKDE4 -t WS_X11 -t Qt_4_7_1 -c . kterminalmod.sip
 */
%Module PyKDE4.kterminal

%Include kterminal.sip
