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

class KSambaShareData
{
%TypeHeaderCode
#include <ksambasharedata.h>
%End

public:
    enum GuestPermission
    {
        GuestsNotAllowed,
        GuestsAllowed
    };
    enum UserShareError
    {
        UserShareOk,
        UserShareExceedMaxShares,
        UserShareNameOk,
        UserShareNameInvalid,
        UserShareNameInUse,
        UserSharePathOk,
        UserSharePathInvalid,
        UserSharePathNotExists,
        UserSharePathNotDirectory,
        UserSharePathNotAbsolute,
        UserSharePathNotAllowed,
        UserShareAclOk,
        UserShareAclInvalid,
        UserShareAclUserNotValid,
        UserShareCommentOk,
        UserShareGuestsOk,
        UserShareGuestsInvalid,
        UserShareGuestsNotAllowed,
        UserShareSystemError
    };
                            KSambaShareData ();
                            KSambaShareData (const KSambaShareData& other);
    ~KSambaShareData ();
    QString                 name () const;
    QString                 path () const;
    QString                 comment () const;
    QString                 acl () const;
    KSambaShareData::GuestPermission  guestPermission () const;
    KSambaShareData::UserShareError  setName (const QString& name);
    KSambaShareData::UserShareError  setPath (const QString& path);
    KSambaShareData::UserShareError  setComment (const QString& comment);
    KSambaShareData::UserShareError  setAcl (const QString& acl);
    KSambaShareData::UserShareError  setGuestPermission (const KSambaShareData::GuestPermission& permission = KSambaShareData::GuestsNotAllowed);
    KSambaShareData::UserShareError  save ();
    KSambaShareData::UserShareError  remove ();
    bool                    operator == (const KSambaShareData& other) const;
    bool                    operator != (const KSambaShareData& other) const;
};
