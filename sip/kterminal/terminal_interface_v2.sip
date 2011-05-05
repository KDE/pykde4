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

class TerminalInterfaceV2: TerminalInterface
{
%TypeHeaderCode
#include <kde_terminal_interface_v2.h>
%End

public:
  virtual ~TerminalInterfaceV2();

  /**
   * Return terminal PID
   */
  virtual int terminalProcessId() = 0;

  /**
   * Return foregound PID, If there is no foreground process running, returns -1
   */
  virtual int foregroundProcessId() = 0;

  /**
   * Returns sub process name. If there is no sub process running, returns empty QString
   */
  virtual QString foregroundProcessName() = 0;
};
