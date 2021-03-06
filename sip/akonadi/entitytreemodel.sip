// Copyright 2009 Simon Edwards <simon@simonzone.com>

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
class EntityTreeModel : QAbstractItemModel
{
%TypeHeaderCode
#include <akonadi/entitytreemodel.h>
%End

public:
    enum Roles
    {
        ItemIdRole,
        ItemRole,
        MimeTypeRole,
        CollectionIdRole,
        CollectionRole,
        RemoteIdRole,
        CollectionChildOrderRole,
        AmazingCompletionRole,
        ParentCollectionRole,
        ColumnCountRole,
        LoadedPartsRole,
        AvailablePartsRole,
        SessionRole,
        CollectionRefRole,
        CollectionDerefRole,
        PendingCutRole,
        EntityUrlRole,
        UnreadCountRole,
        FetchStateRole,
        CollectionSyncProgressRole,
        UserRole,
        TerminalUserRole,
        EndRole
    };
    enum HeaderGroup
    {
        EntityTreeHeaders,
        CollectionTreeHeaders,
        ItemListHeaders,
        UserHeaders,
        EndHeaderGroup
    };
    virtual ~EntityTreeModel ();
    enum ItemPopulationStrategy
    {
        NoItemPopulation,
        ImmediatePopulation,
        LazyPopulation
    };
    void                    setShowSystemEntities (bool show);
    bool                    systemEntitiesShown () const;
    void                    setItemPopulationStrategy (Akonadi::EntityTreeModel::ItemPopulationStrategy strategy);
    Akonadi::EntityTreeModel::ItemPopulationStrategy  itemPopulationStrategy () const;
    void                    setIncludeRootCollection (bool include);
    bool                    includeRootCollection () const;
    void                    setRootCollectionDisplayName (const QString& name);
    QString                 rootCollectionDisplayName () const;
    enum CollectionFetchStrategy
    {
        FetchNoCollections,
        FetchFirstLevelChildCollections,
        FetchCollectionsRecursive,
        InvisibleCollectionFetch
    };
    void                    setCollectionFetchStrategy (Akonadi::EntityTreeModel::CollectionFetchStrategy strategy);
    Akonadi::EntityTreeModel::CollectionFetchStrategy  collectionFetchStrategy () const;
    virtual int             columnCount (const QModelIndex& parent = QModelIndex()) const;
    virtual int             rowCount (const QModelIndex& parent = QModelIndex()) const;
    virtual QVariant        data (const QModelIndex& index, int role = Qt::DisplayRole) const;
    virtual QVariant        headerData (int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    virtual Qt::ItemFlags   flags (const QModelIndex& index) const;
    virtual QStringList     mimeTypes () const;
    virtual Qt::DropActions  supportedDropActions () const;
    virtual QMimeData*      mimeData (const QModelIndexList& indexes) const;
    virtual bool            dropMimeData (const QMimeData* data, Qt::DropAction action, int row, int column, const QModelIndex& parent);
    virtual bool            setData (const QModelIndex& index, const QVariant& value, int role = Qt::EditRole);
    virtual QModelIndex     index (int row, int column, const QModelIndex& parent = QModelIndex()) const;
    virtual QModelIndex     parent (const QModelIndex& index) const;
    virtual bool            canFetchMore (const QModelIndex& parent) const;
    virtual void            fetchMore (const QModelIndex& parent);
    virtual bool            hasChildren (const QModelIndex& parent = QModelIndex()) const;
    virtual QModelIndexList  match (const QModelIndex& start, int role, const QVariant& value, int hits = 1, Qt::MatchFlags flags = Qt::MatchFlags(Qt::MatchStartsWith|Qt::MatchWrap)) const;
protected:
    void                    clearAndReset ();
    virtual QVariant        entityData (const Akonadi::Item& item, int column, int role = Qt::DisplayRole) const;
    virtual QVariant        entityData (const Akonadi::Collection& collection, int column, int role = Qt::DisplayRole) const;
    virtual QVariant        entityHeaderData (int section, Qt::Orientation orientation, int role, Akonadi::EntityTreeModel::HeaderGroup headerGroup) const;
    virtual int             entityColumnCount (Akonadi::EntityTreeModel::HeaderGroup headerGroup) const;
    virtual bool            entityMatch (const Akonadi::Item& item, const QVariant& value, Qt::MatchFlags flags) const;
    virtual bool            entityMatch (const Akonadi::Collection& collection, const QVariant& value, Qt::MatchFlags flags) const;
public:
    explicit                EntityTreeModel (Akonadi::ChangeRecorder* monitor, QObject* parent /TransferThis/ = 0);
protected:
//ig                            EntityTreeModel (Akonadi::ChangeRecorder* monitor, EntityTreeModelPrivate* d, QObject* parent /TransferThis/ = 0);
public:
    static QModelIndex      modelIndexForCollection (const QAbstractItemModel* model, const Akonadi::Collection& collection);
    static QModelIndexList  modelIndexesForItem (const QAbstractItemModel* model, const Akonadi::Item& item);
    enum FetchState
    {
        IdleState,
        FetchingState
    };
    bool                    includeUnsubscribed () const;
    void                    setIncludeUnsubscribed (bool show);
//force
private:
    virtual bool removeColumns(int, int, const QModelIndex&);
    virtual bool removeRows(int, int, const QModelIndex&);
    virtual bool insertColumns(int, int, const QModelIndex&);
    virtual bool insertRows(int, int, const QModelIndex&);
//end
};
};
