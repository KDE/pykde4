//
//     Copyright 2009 Simon Edwards <simon@simonzone.com>

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


class KFileItemActions : QObject
{
%TypeHeaderCode
#include <kfileitemactions.h>
%End

public:
                            KFileItemActions (QObject* parent /TransferThis/ = 0);
    void                    setItemListProperties (const KFileItemListProperties& itemList);
    void                    setParentWidget (QWidget* widget);
    KAction*                preferredOpenWithAction (const QString& traderConstraint);
    int                     addServiceActionsTo (QMenu* menu);
    ~KFileItemActions ();
    static KService::List   associatedApplications (const QStringList& mimeTypeList, const QString& traderConstraint);
    void                    addOpenWithActionsTo (QMenu* menu, const QString& traderConstraint = QString());
    void                    runPreferredApplications (const KFileItemList& fileOpenList, const QString& traderConstraint);
signals:
    void                    openWithDialogAboutToBeShown ();
};
// KFileItemActions


