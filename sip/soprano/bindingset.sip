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

class BindingSet
{
%TypeHeaderCode
#include <soprano/bindingset.h>
%End

public:
                            BindingSet ();
                            BindingSet (const Soprano::BindingSet& other);
    QStringList             bindingNames () const;
    Soprano::Node           operator [] (int offset) const;
    Soprano::Node           operator [] (const QString name) const;
    Soprano::Node           value (int offset) const;
    Soprano::Node           value (const QString& name) const;
    bool                    contains (const QString& name) const;
    int                     count () const;
    void                    insert (const QString& name, const Soprano::Node& value);
    void                    replace (int offset, const Soprano::Node& value);
    void                    replace (const QString& name, const Soprano::Node& value);
    ~BindingSet ();
    bool                    operator == (const Soprano::BindingSet& other) const;
    bool                    operator != (const Soprano::BindingSet& other) const;
};
// BindingSet

};
// Soprano


//ig QDebug                  operator << (QDebug s, const Soprano::BindingSet&);
QTextStream&            operator << (QTextStream& s, const Soprano::BindingSet&);
