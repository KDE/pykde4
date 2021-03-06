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

class KDateComboBox : KComboBox
{
%TypeHeaderCode
#include <kdatecombobox.h>
%End

public:
    enum Option
    {
        EditDate,
        SelectDate,
        DatePicker,
        DateKeywords,
        WarnOnInvalid
    };
    typedef QFlags<KDateComboBox::Option> Options;
    explicit                KDateComboBox (QWidget* parent /TransferThis/ = 0);
    virtual ~KDateComboBox ();
    QDate                   date () const;
    const KCalendarSystem*  calendar () const;
    bool                    isValid () const;
    KDateComboBox::Options  options () const;
    QDate                   minimumDate () const;
    QDate                   maximumDate () const;
    void                    resetMaximumDate ();
    void                    setDateRange (const QDate& minDate, const QDate& maxDate, const QString& minWarnMsg = QString(), const QString& maxWarnMsg = QString());
    void                    resetDateRange ();
    void                    setCalendar (KCalendarSystem* calendar = 0);
signals:
    void                    dateEntered (const QDate& date);
    void                    dateChanged (const QDate& date);
    void                    dateEdited (const QDate& date);
public:
    void                    setDate (const QDate& date);
    void                    setCalendarSystem (KLocale::CalendarSystem calendarSystem);
    void                    setOptions (KDateComboBox::Options options);
    void                    setDisplayFormat (KLocale::DateFormat format);
    void                    setMinimumDate (const QDate& minTime, const QString& minWarnMsg = QString());
    void                    resetMinimumDate ();
    void                    setMaximumDate (const QDate& maxDate, const QString& maxWarnMsg = QString());
    void                    setDateMap (QMap<QDate,QString> dateMap);
protected:
    virtual bool            eventFilter (QObject* object, QEvent* event);
    virtual void            showPopup ();
    virtual void            hidePopup ();
    virtual void            mousePressEvent (QMouseEvent* event);
    virtual void            wheelEvent (QWheelEvent* event);
    virtual void            keyPressEvent (QKeyEvent* event);
    virtual void            focusInEvent (QFocusEvent* event);
    virtual void            focusOutEvent (QFocusEvent* event);
    virtual void            resizeEvent (QResizeEvent* event);
    virtual void            assignDate (const QDate& date);
    virtual void            assignCalendarSystem (KLocale::CalendarSystem calendarSystem);
public:
    QMap<QDate,QString>     dateMap () const;
    KLocale::CalendarSystem  calendarSystem () const;
    bool                    isNull () const;
    KLocale::DateFormat     displayFormat () const;
};
