//
//     Copyright 2008 Jim Bublitz <jbublitz@nwinternet.com>
//     Earlier copyrights 1998 - 2007 Jim Bublitz also apply

//                 Generated by twine

// This file is part of PyKDE4.

// PyKDE4 is free software; you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as
// published by the Free Software Foundation; either version 2.1 of
// the License, or (at your option) any later version.

// PyKDE4 is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.




class KGlobalAccel : QObject
{
%TypeHeaderCode
#include <kglobalaccel.h>
%End



public:
    enum actionIdFields
    {
        ComponentUnique,
        ActionUnique,
        ComponentFriendly,
        ActionFriendly
    };

    static KGlobalAccel*    self ();
    static void             stealShortcutSystemwide (const QKeySequence& seq);
    static void             activateGlobalShortcutContext (const QString& contextUnique, const QString& contextFriendly, const KComponentData& component = KGlobal::mainComponent());
    static bool             cleanComponent (const QString& componentUnique);
    static bool             isComponentActive (const QString& componentName);
    static QList<KGlobalShortcutInfo>  getGlobalShortcutsByKey (const QKeySequence& seq);
    static bool             isGlobalShortcutAvailable (const QKeySequence& seq, const QString& component = QString());
    static bool             promptStealShortcutSystemwide (QWidget* parent /Transfer/, const QList<KGlobalShortcutInfo>& shortcuts, const QKeySequence& seq);
    bool                    isEnabled () const;
    void                    setEnabled (bool enabled);
    void                    overrideMainComponentData (const KComponentData& componentData);
    QList<QStringList>      allMainComponents ();
    QList<QStringList>      allActionsForComponent (const QStringList& actionId);
    static QStringList      findActionNameSystemwide (const QKeySequence& seq);
    static bool             promptStealShortcutSystemwide (QWidget* parent /Transfer/, const QStringList& actionIdentifier, const QKeySequence& seq);

private:
                            KGlobalAccel ();
    ~KGlobalAccel ();
};
// KGlobalAccel


