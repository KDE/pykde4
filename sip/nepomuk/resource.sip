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

%ModuleHeaderCode
//ctscc
#include <nepomuk/file.h>
#include <nepomuk/resource.h>
#include <nepomuk/tag.h>
#include <nepomuk/thing.h>
%End


namespace Nepomuk
{

enum ErrorCode
{
    NoError,
    CommunicationError,
    InvalidType,
    UnknownError
};

QString                 errorString (Nepomuk::ErrorCode code);

class Resource
{
%TypeHeaderCode
#include <nepomuk/resource.h>
%End


public:
                            Resource ();
                            Resource (Nepomuk::ResourceManager* manager);
                            Resource (const Nepomuk::Resource&);
                            Resource (const QString& pathOrIdentifier, const QUrl& type = QUrl());
                            Resource (const QString& pathOrIdentifier, const QUrl& type, Nepomuk::ResourceManager* manager);
                            Resource (const QString& pathOrIdentifier, const QString& type);
                            Resource (const QUrl& uri, const QUrl& type = QUrl());
                            Resource (const QUrl& uri, const QUrl& type, Nepomuk::ResourceManager* manager);
//ig                            Resource (ResourceData*);
    Nepomuk::ResourceManager*  manager () const;
    QString                 uri () const;
    QUrl                    resourceUri () const;
    QString                 type () const;
    QUrl                    resourceType () const;
    QList<QUrl>             types () const;
    void                    setTypes (const QList<QUrl>& types);
    void                    addType (const QUrl& type);
    bool                    hasType (const QUrl& typeUri) const;
    QString                 className () const;
    QHash<QString,Nepomuk::Variant>  allProperties () const;
    QHash<QUrl,Nepomuk::Variant>  properties () const;
    bool                    hasProperty (const QUrl& uri) const;
    bool                    hasProperty (const QString& uri) const;
    Nepomuk::Variant        property (const QUrl& uri) const;
    Nepomuk::Variant        property (const QString& uri) const;
    void                    setProperty (const QUrl& uri, const Nepomuk::Variant& value);
    void                    addProperty (const QUrl& uri, const Nepomuk::Variant& value);
    void                    setProperty (const QString& uri, const Nepomuk::Variant& value);
    void                    removeProperty (const QUrl& uri);
    void                    removeProperty (const QUrl& uri, const Nepomuk::Variant& value);
    void                    removeProperty (const QString& uri);
    void                    remove ();
    bool                    exists () const;
    bool                    isValid () const;
    QString                 genericLabel () const;
    QString                 genericDescription () const;
    QString                 genericIcon () const;
    Nepomuk::Thing          pimoThing ();
    bool                    operator == (const Nepomuk::Resource&) const;
    QString                 description () const;
    void                    setDescription (const QString& value);
    static QString          descriptionUri ();
    QStringList             identifiers () const;
    void                    setIdentifiers (const QStringList& value);
    void                    addIdentifier (const QString& value);
    static QString          identifierUri ();
    QStringList             altLabels () const;
    void                    setAltLabels (const QStringList& value);
    void                    addAltLabel (const QString& value);
    static QString          altLabelUri ();
    QList<Nepomuk::Resource>  annotations () const;
    void                    setAnnotations (const QList<Nepomuk::Resource>& value);
    void                    addAnnotation (const Nepomuk::Resource& value);
    static QString          annotationUri ();
    QList<Nepomuk::Tag>     tags () const;
    void                    setTags (const QList<Nepomuk::Tag>& value);
    void                    addTag (const Nepomuk::Tag& value);
    static QString          tagUri ();
    QList<Nepomuk::Resource>  topics () const;
    void                    setTopics (const QList<Nepomuk::Resource>& value);
    void                    addTopic (const Nepomuk::Resource& value);
    static QString          topicUri ();
    QList<Nepomuk::Resource>  isTopicOfs () const;
    void                    setIsTopicOfs (const QList<Nepomuk::Resource>& value);
    void                    addIsTopicOf (const Nepomuk::Resource& value);
    static QString          isTopicOfUri ();
    QList<Nepomuk::Resource>  isRelateds () const;
    void                    setIsRelateds (const QList<Nepomuk::Resource>& value);
    void                    addIsRelated (const Nepomuk::Resource& value);
    static QString          isRelatedUri ();
    QString                 label () const;
    void                    setLabel (const QString& value);
    static QString          labelUri ();
    quint32                 rating () const;
    void                    setRating (const quint32& value /In/);
    static QString          ratingUri ();
    QStringList             symbols () const;
    void                    setSymbols (const QStringList& value);
    void                    addSymbol (const QString& value);
    static QString          symbolUri ();
    QList<Nepomuk::Resource>  annotationOf () const;
    QList<Nepomuk::Resource>  isRelatedOf () const;
    static QList<Nepomuk::Resource>  allResources ();
    virtual ~Resource ();
    bool                    operator != (const Nepomuk::Resource&) const;
%ConvertToSubClassCode
    // CTSCC for subclasses of 'Resource'
    sipType = NULL;

    if (dynamic_cast<Nepomuk::File*>(sipCpp))
        sipType = sipType_Nepomuk_File;
    else if (dynamic_cast<Nepomuk::Tag*>(sipCpp))
        sipType = sipType_Nepomuk_Tag;
    else if (dynamic_cast<Nepomuk::Thing*>(sipCpp))
        sipType = sipType_Nepomuk_Thing;
%End
    bool                    hasProperty (const Nepomuk::Types::Property& p, const Nepomuk::Variant& v) const;
    int                     usageCount () const;
    void                    increaseUsageCount ();
    static Nepomuk::Resource  fromResourceUri (const KUrl& uri, const Nepomuk::Types::Class& type = Nepomuk::Types::Class(), Nepomuk::ResourceManager* manager = 0);
    bool                    isFile () const;
    Nepomuk::File           toFile () const;
};
// Resource

uint                    qHash (const Nepomuk::Resource& res);
};
// Nepomuk


