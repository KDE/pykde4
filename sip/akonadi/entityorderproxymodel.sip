// Copyright 2010 Simon Edwards <simon@simonzone.com>

//                 Generated by twine2

// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU Library General Public License as
// published by the Free Software Foundation; either version 2, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details

// You should have received a copy of the GNU Library General Public
// License along with this program; if not, write to the
// Free Software Foundation, Inc.,
// 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

namespace Akonadi
{
class EntityOrderProxyModel : QSortFilterProxyModel
{
%TypeHeaderCode
#include <akonadi/entityorderproxymodel.h>
%End

public:
                            EntityOrderProxyModel (QObject* parent /TransferThis/ = 0);
    virtual ~EntityOrderProxyModel ();
    void                    setOrderConfig (KConfigGroup& group);
    void                    saveOrder ();
    void                    clearOrder (const QModelIndex& index);
    void                    clearTreeOrder ();
    virtual bool            lessThan (const QModelIndex& left, const QModelIndex& right) const;
    virtual bool            dropMimeData (const QMimeData* data, Qt::DropAction action, int row, int column, const QModelIndex& parent);
    virtual QModelIndexList  match (const QModelIndex& start, int role, const QVariant& value, int hits = 1, Qt::MatchFlags flags = Qt::MatchFlags(Qt::MatchStartsWith|Qt::MatchWrap)) const;
protected:
    virtual QString         parentConfigString (const QModelIndex& index) const;
    virtual QString         configString (const QModelIndex& index) const;
};
};
