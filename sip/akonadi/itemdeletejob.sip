//
//     Copyright 2008 Simon Edwards <simon@simonzone.com>

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

namespace Akonadi
{

class ItemDeleteJob : Akonadi::Job
{
%TypeHeaderCode
#include <akonadi/itemdeletejob.h>
%End

public:
    explicit                ItemDeleteJob (const Akonadi::Item& item, QObject* parent /TransferThis/ = 0);
    explicit                ItemDeleteJob (const Akonadi::Item::List& items, QObject* parent /TransferThis/ = 0);
    explicit                ItemDeleteJob (const Akonadi::Collection& collection, QObject* parent /TransferThis/ = 0);

protected:
    virtual void            doStart ();
public:
    ~ItemDeleteJob ();
    Akonadi::Item::List     deletedItems () const;
};
// ItemDeleteJob

};
// Akonadi


