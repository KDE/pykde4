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


class KJobTrackerInterface : QObject
{
%TypeHeaderCode
#include <kjobtrackerinterface.h>
%End


public:
                            KJobTrackerInterface (QObject* parent /TransferThis/ = 0);
    virtual void            registerJob (KJob* job);
    virtual void            unregisterJob (KJob* job);

protected:
    virtual void            finished (KJob* job);
    virtual void            suspended (KJob* job);
    virtual void            resumed (KJob* job);
    virtual void            description (KJob* job, const QString& title, const QPair<QString,QString>& field1, const QPair<QString,QString>& field2);
    virtual void            infoMessage (KJob* job, const QString& plain, const QString& rich);
    virtual void            warning (KJob* job, const QString& plain, const QString& rich);
    virtual void            totalAmount (KJob* job, KJob::Unit unit, qulonglong amount);
    virtual void            processedAmount (KJob* job, KJob::Unit unit, qulonglong amount);
    virtual void            percent (KJob* job, unsigned long percent);
    virtual void            speed (KJob* job, unsigned long value);
public:
    ~KJobTrackerInterface ();
};
// KJobTrackerInterface


