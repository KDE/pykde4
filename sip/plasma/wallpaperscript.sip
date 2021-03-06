// Copyright 2009 Simon Edwards <simon@simonzone.com>

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

namespace Plasma
{
class WallpaperScript : Plasma::ScriptEngine
{
%TypeHeaderCode
#include <plasma/scripting/wallpaperscript.h>
%End

public:
    explicit                WallpaperScript (QObject* parent /TransferThis/ = 0);
    ~WallpaperScript ();
    void                    setWallpaper (Plasma::Wallpaper* wallpaper);
    Plasma::Wallpaper*      wallpaper () const;
    virtual void            initWallpaper (const KConfigGroup& config);
    virtual void            paint (QPainter* painter, const QRectF& exposedRect);
    virtual void            save (KConfigGroup& config);
    virtual QWidget*        createConfigurationInterface (QWidget* parent /Transfer/);
    virtual void            mouseMoveEvent (QGraphicsSceneMouseEvent* event);
    virtual void            mousePressEvent (QGraphicsSceneMouseEvent* event);
    virtual void            mouseReleaseEvent (QGraphicsSceneMouseEvent* event);
    virtual void            wheelEvent (QGraphicsSceneWheelEvent* event);
protected:
    QString                 mainScript () const;
    const Plasma::Package*  package () const;
    bool                    isInitialized () const;
    QRectF                  boundingRect () const;
    Plasma::DataEngine*     dataEngine (const QString& name) const;
    void                    setResizeMethodHint (Plasma::Wallpaper::ResizeMethod resizeMethod);
    void                    setTargetSizeHint (const QSizeF& targetSize);
    void                    setConfigurationRequired (bool needsConfiguring, const QString& reason = QString());
    void                    render (const QString& sourceImagePath, const QSize& size, Plasma::Wallpaper::ResizeMethod resizeMethod = Plasma::Wallpaper::ScaledResize, const QColor& color = QColor(0,0,0));
    void                    setUsingRenderingCache (bool useCache);
    bool                    findInCache (const QString& key, QImage& image, unsigned int lastModified = 0);
    void                    insertIntoCache (const QString& key, const QImage& image);
    void                    setContextualActions (const QList<QAction*>& actions);
    void                    update (const QRectF& exposedArea);
    void                    configNeedsSaving ();
    virtual void            renderCompleted (const QImage& image);
    virtual void            urlDropped (const KUrl& url);
    KPluginInfo             description () const;
public:
    void                    setUrls (const KUrl::List urls);
};
};
