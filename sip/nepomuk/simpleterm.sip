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

namespace Nepomuk
{
namespace Query
{
class SimpleTerm : Nepomuk::Query::Term
{
%TypeHeaderCode
#include <nepomuk/simpleterm.h>
%End

public:
    ~SimpleTerm ();
    Nepomuk::Query::Term    subTerm () const;
    void                    setSubTerm (const Nepomuk::Query::Term& term);
protected:
                            SimpleTerm (const Nepomuk::Query::Term& term);
//ig                            SimpleTerm (TermPrivate*);
};
};
};
