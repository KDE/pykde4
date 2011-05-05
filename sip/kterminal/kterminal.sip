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

%Import kparts/kpartsmod.sip
%Import QtCore/QtCoremod.sip
%Import QtGui/QtGuimod.sip

%Include terminal_interface.sip
%Include terminal_interface_v2.sip

%ModuleHeaderCode
#pragma GCC visibility push(default)
#include <kde_terminal_interface.h>
#include <kde_terminal_interface_v2.h>
#include <kparts/part.h>

/**
 * KTerminal
 *
 * This class contains helper code to give access to the interfaces exposed
 * by KDE terminals. This is needed to avoid Python code having to learn
 * about the scary qobject_cast'ing which is used from C++ code.
 */
class KTerminal
{
public:
  /**
   * Construct a KTerminal which can be used to access the interfaces of
   * interest.
   *
   * @param part The part whose interfaces we want to expose.
   */
  KTerminal(KParts::Part* part): m_part(part) {}
  TerminalInterface* terminalInterface() { return qobject_cast<TerminalInterface*>(m_part); }
  TerminalInterfaceV2* terminalInterfaceV2() { return qobject_cast<TerminalInterfaceV2*>(m_part); }
protected:
  KParts::Part *m_part;
};
%End

class KTerminal
{
%TypeHeaderCode
#include <kde_terminal_interface.h>
#include <kde_terminal_interface_v2.h>
#include <kparts/part.h>
%End

public:
  KTerminal(KParts::Part* part);
  TerminalInterface* terminalInterface();
  TerminalInterfaceV2* terminalInterfaceV2();
};
