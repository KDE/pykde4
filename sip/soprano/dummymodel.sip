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

namespace Soprano
{
namespace Util
{

class DummyModel : Soprano::Model
{
%TypeHeaderCode
#include <soprano/dummymodel.h>
%End

public:
                            DummyModel ();
    Soprano::Error::ErrorCode  addStatement (const Soprano::Statement& statement);
    Soprano::Error::ErrorCode  addStatement (const Soprano::Node& subject, const Soprano::Node& predicate, const Soprano::Node& object, const Soprano::Node& context = Soprano::Node());
// No C++ implementation
//ig    Soprano::Error::ErrorCode  addStatements (const QList<Soprano::Statement>& statements);
    Soprano::Error::ErrorCode  removeStatement (const Soprano::Statement& statement);
    Soprano::Error::ErrorCode  removeStatement (const Soprano::Node& subject, const Soprano::Node& predicate, const Soprano::Node& object, const Soprano::Node& context = Soprano::Node());
    Soprano::Error::ErrorCode  removeAllStatements (const Soprano::Statement& statement);
// No C++ implementation
//ig    Soprano::Error::ErrorCode  removeStatements (const QList<Soprano::Statement>& statements);
//ig    Soprano::Error::ErrorCode  removeContext (const Soprano::Node&);
//ig    Soprano::Error::ErrorCode  removeAllStatements ();
    Soprano::StatementIterator  listStatements (const Soprano::Statement& partial) const;
    Soprano::StatementIterator  listStatements (const Soprano::Node& subject, const Soprano::Node& predicate, const Soprano::Node& object, const Soprano::Node& context = Soprano::Node()) const;
// No C++ implementation
//ig    Soprano::StatementIterator  listStatements () const;
//ig    Soprano::StatementIterator  listStatementsInContext (const Soprano::Node& context) const;
    Soprano::NodeIterator   listContexts () const;
    Soprano::QueryResultIterator  executeQuery (const QString& query, Soprano::Query::QueryLanguage language, const QString& userQueryLanguage = QString()) const;
    bool                    containsAnyStatement (const Soprano::Statement& statement) const;
    bool                    containsAnyStatement (const Soprano::Node& subject, const Soprano::Node& predicate, const Soprano::Node& object, const Soprano::Node& context = Soprano::Node()) const;
    bool                    containsStatement (const Soprano::Statement& statement) const;
    bool                    containsStatement (const Soprano::Node& subject, const Soprano::Node& predicate, const Soprano::Node& object, const Soprano::Node& context = Soprano::Node()) const;
// No C++ implementation
//ig    bool                    containsContext (const Soprano::Node& context) const;
    bool                    isEmpty () const;
    int                     statementCount () const;
    Soprano::Error::ErrorCode  write (QTextStream& os) const;
    Soprano::Node           createBlankNode ();
    ~DummyModel ();
};
// DummyModel

};
// Util

};
// Soprano


