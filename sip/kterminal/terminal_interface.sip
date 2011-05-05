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

class TerminalInterface
{
%TypeHeaderCode
#include <kde_terminal_interface.h>
%End

public:
  ~TerminalInterface();

  /**
   * This starts @p program, with arguments @p args
   */
  virtual void startProgram( const QString& program,
                             const QStringList& args ) = 0;
                             
  /**
   * If a shell is currently shown, this sends it a cd
   * command. Otherwise, this starts a shell, and sends it a cd
   * command too...
   */
  virtual void showShellInDir( const QString& dir ) = 0;

  /**
   * This sends @param text as input to the currently running
   * program..
   */
  virtual void sendInput( const QString& text ) = 0;
};
