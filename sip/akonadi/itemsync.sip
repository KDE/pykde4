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

class ItemSync : Akonadi::Job
{
%TypeHeaderCode
#include <akonadi/itemsync.h>
%End

public:
    explicit                ItemSync (const Akonadi::Collection& collection, QObject* parent /TransferThis/ = 0);
    void                    setFullSyncItems (const Akonadi::Item::List& items);
    void                    setTotalItems (int amount);
    void                    setStreamingEnabled (bool enable);
    void                    deliveryDone ();

    void                    setIncrementalSyncItems (const Akonadi::Item::List& changedItems, const Akonadi::Item::List& removedItems);

    void                    setFetchScope (Akonadi::ItemFetchScope& fetchScope);
    Akonadi::ItemFetchScope&  fetchScope ();

protected:
    void                    doStart ();
    virtual bool            updateItem (const Akonadi::Item& storedItem, Akonadi::Item& newItem);
public:
    ~ItemSync ();
protected:
    void                    slotResult (KJob* job);
public:
    void                    rollback ();
    enum TransactionMode
    {
        SingleTransaction,
        MultipleTransactions,
        NoTransaction
    };
    void                    setTransactionMode (Akonadi::ItemSync::TransactionMode mode);
};
// ItemSync

};
// Akonadi


