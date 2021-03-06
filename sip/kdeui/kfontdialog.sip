//
//     Copyright 2008 Jim Bublitz <jbublitz@nwinternet.com>
//     Earlier copyrights 1998 - 2007 Jim Bublitz also apply

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


class KFontDialog : KDialog
{
%TypeHeaderCode
#include <kfontdialog.h>
%End


public:
    explicit                KFontDialog (QWidget* parent /TransferThis/ = 0, const KFontChooser::DisplayFlags& flags = KFontChooser::NoDisplayFlags, const QStringList& fontlist = QStringList(), Qt::CheckState* sizeIsRelativeState = 0) [(QWidget* = 0, const KFontChooser::DisplayFlags& = KFontChooser::NoDisplayFlags, const QStringList& = QStringList(), Qt::CheckState* = 0)];
%MethodCode
Py_BEGIN_ALLOW_THREADS
    sipCpp= new sipKFontDialog (a0, *a1, *a2, &a3);
    Py_END_ALLOW_THREADS
%End

    void                    setFont (const QFont& font, bool onlyFixed = 0);
    QFont                   font () const;
    void                    setSizeIsRelative (Qt::CheckState relative);
    Qt::CheckState          sizeIsRelative () const;
    static SIP_PYTUPLE      getFont (QFont& theFont, const KFontChooser::DisplayFlags& flags = KFontChooser::NoDisplayFlags, QWidget* parent /Transfer/ = 0, Qt::CheckState* sizeIsRelativeState = Qt::Unchecked) [int (QFont&, const KFontChooser::DisplayFlags& = KFontChooser::NoDisplayFlags, QWidget* = 0, Qt::CheckState* = 0)];
%MethodCode
int result;
    Py_BEGIN_ALLOW_THREADS
    result = KFontDialog::getFont (*a0, *a1, a2, &a3);
    Py_END_ALLOW_THREADS
#if PY_MAJOR_VERSION >= 3
    sipRes = PyLong_FromLong (result);
#else
    sipRes = PyInt_FromLong (result);
#endif
%End

    static SIP_PYTUPLE      getFontDiff (QFont& theFont, KFontChooser::FontDiffFlags& diffFlags, const KFontChooser::DisplayFlags& flags = KFontChooser::NoDisplayFlags, QWidget* parent /Transfer/ = 0, Qt::CheckState sizeIsRelativeState = Qt::Unchecked) [int (QFont&, KFontChooser::FontDiffFlags&, const KFontChooser::DisplayFlags& = KFontChooser::NoDisplayFlags, QWidget* = 0, Qt::CheckState* = 0)];
%MethodCode
int result;
    Py_BEGIN_ALLOW_THREADS
    result = KFontDialog::getFontDiff (*a0, *a1, *a2, a3, &a4);
    Py_END_ALLOW_THREADS

#if PY_MAJOR_VERSION >= 3
    sipRes = PyLong_FromLong (result);
#else
    sipRes = PyInt_FromLong (result);
#endif
%End

    static SIP_PYTUPLE      getFontAndText (QFont& theFont, QString& theString, const KFontChooser::DisplayFlags& flags = KFontChooser::NoDisplayFlags, QWidget* parent /Transfer/ = 0, Qt::CheckState sizeIsRelativeState = Qt::Unchecked) [int (QFont&, QString&, const KFontChooser::DisplayFlags& = KFontChooser::NoDisplayFlags, QWidget* = 0, Qt::CheckState* = 0)];
%MethodCode
int result;
    Py_BEGIN_ALLOW_THREADS
    result = KFontDialog::getFontAndText (*a0, *a1, *a2, a3, &a4);
    Py_END_ALLOW_THREADS

#if PY_MAJOR_VERSION >= 3
    sipRes = PyLong_FromLong (result);
#else
    sipRes = PyInt_FromLong (result);
#endif
%End


signals:
    void                    fontSelected (const QFont& font);

private:
//force
                            KFontDialog (const KFontDialog&);
//end
public:
    ~KFontDialog ();
};
// KFontDialog


