//
//     Copyright 2008 Simon Edwards <simon@simonzone.com>

//                 Generated by twine
//            PyKDE4 module soprano  version KDE 4.1.0

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
typedef Iterator<Soprano::Statement> StatementIteratorBase;
typedef IteratorBackend<Soprano::Statement> StatementIteratorBackendBase;
class StatementIterator : Soprano::StatementIteratorBase
{
%TypeHeaderCode
#include <soprano/statementiterator.h>
namespace Soprano
{
typedef Iterator<Soprano::Statement> StatementIteratorBase;
typedef IteratorBackend<Soprano::Statement> StatementIteratorBackendBase;
};
%End

public:
                            StatementIterator ();
                            StatementIterator (Soprano::StatementIteratorBackendBase* sti);
                            StatementIterator (const Soprano::StatementIterator& sti);
    QList<Soprano::Statement>  allStatements ();
    Soprano::NodeIterator   iterateSubjects () const;
    Soprano::NodeIterator   iteratePredicates () const;
    Soprano::NodeIterator   iterateObjects () const;
    Soprano::NodeIterator   iterateContexts () const;
};   // StatementIterator

};   // Soprano

