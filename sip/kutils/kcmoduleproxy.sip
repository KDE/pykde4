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





%ModuleHeaderCode
//ctscc
#include <dialog.h>
#include <kcmoduleproxy.h>
#include <kcmultidialog.h>
#include <kemoticons.h>
#include <kemoticonsprovider.h>
#include <kidletime.h>
#include <kpluginselector.h>
#include <kprintpreview.h>
#include <pluginpage.h>
#include <qobject.h>
%End

class KCModuleProxy : QWidget
{
%TypeHeaderCode
#include <kcmoduleproxy.h>
%End


public:
    explicit                KCModuleProxy (const KCModuleInfo& info, QWidget* parent /TransferThis/ = 0, const QStringList& args = QStringList());
    explicit                KCModuleProxy (const QString& serviceName, QWidget* parent /TransferThis/ = 0, const QStringList& args = QStringList());
    explicit                KCModuleProxy (const KService::Ptr& service, QWidget* parent /TransferThis/ = 0, const QStringList& args = QStringList());
    void                    load ();
    void                    save ();
    QString                 quickHelp () const;
    const KAboutData*       aboutData () const;
    KCModule::Buttons       buttons () const;
    QString                 rootOnlyMessage () const;
    bool                    useRootOnlyMessage () const;
    KComponentData          componentData () const;
    bool                    changed () const;
    KCModule*               realModule () const;
    KCModuleInfo            moduleInfo () const;
    QString                 dbusService () const;
    QString                 dbusPath () const;
    QSize                   minimumSizeHint () const;
    void                    defaults ();
    void                    deleteClient ();

signals:
    void                    changed (bool state);
    void                    changed (KCModuleProxy* mod);
    void                    childClosed ();
    void                    quickHelpChanged ();

protected:
    void                    showEvent (QShowEvent*);


//  Subclasses of QObject

%ConvertToSubClassCode
    // CTSCC for subclasses of 'QObject'
    sipType = NULL;

    if (dynamic_cast<KEmoticons*>(sipCpp))
        sipType = sipType_KEmoticons;
    else if (dynamic_cast<KEmoticonsProvider*>(sipCpp))
        sipType = sipType_KEmoticonsProvider;
    else if (dynamic_cast<KIdleTime*>(sipCpp))
        sipType = sipType_KIdleTime;
    else if (dynamic_cast<KSettings::PluginPage*>(sipCpp))
        sipType = sipType_KSettings_PluginPage;
    else if (dynamic_cast<KCModuleProxy*>(sipCpp))
        sipType = sipType_KCModuleProxy;
    else if (dynamic_cast<KPluginSelector*>(sipCpp))
        sipType = sipType_KPluginSelector;
    else if (dynamic_cast<KCMultiDialog*>(sipCpp))
        {
        sipType = sipType_KCMultiDialog;
        if (dynamic_cast<KSettings::Dialog*>(sipCpp))
            sipType = sipType_KSettings_Dialog;
        }
    else if (dynamic_cast<KPrintPreview*>(sipCpp))
        sipType = sipType_KPrintPreview;
%End

public:
    ~KCModuleProxy ();
};
// KCModuleProxy




