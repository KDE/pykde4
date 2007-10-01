/* vi: ts=8 sts=4 sw=4
 *
 * This file is part of the KDE project, module kdecore.
 * Copyright (C) 2000 Geert Jansen <jansen@kde.org>
 *                    Antonio Larrosa <larrosa@kde.org>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License version 2 as published by the Free Software Foundation.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 *
 */

#ifndef KICONTHEME_H
#define KICONTHEME_H

#include <kdeui_export.h>

#include <QtCore/QString>
#include <QtCore/QStringList>
#include <QtCore/QList>

class QAction;
//class KIconThemeDir;

/**
 * One icon as found by KIconTheme. Also serves as a namespace containing
 * icon related constants.
 * @see KIconEffect
 * @see KIconTheme
 * @see KIconLoader
 */
class KDEUI_EXPORT K3Icon
{
public:
    K3Icon();
    ~K3Icon();

    /**
     * Return true if this icon is valid, false otherwise.
     */
    bool isValid() const;

    /**
     * Defines the context of the icon.
     */
    enum Context {
      Any, ///< Some icon with unknown purpose.
      Action, ///< An action icon (e.g. 'save', 'print').
      Application, ///< An icon that represents an application.
      Device, ///< An icon that represents a device.
      FileSystem, ///< An icon that represents a file system.
      MimeType, ///< An icon that represents a mime type (or file type).
      Animation, ///< An icon that is animated.
      Category, ///< An icon that represents a category.
      Emblem, ///< An icon that adds information to an existing icon.
      Emote, ///< An icon that expresses an emotion.
      International, ///< An icon that represents a country's flag.
      Place, ///< An icon that represents a location (e.g. 'home', 'trash').
      StatusIcon ///< An icon that represents an event.
    };

    /**
     * The type of the icon.
     */
    enum Type {
      Fixed, ///< Fixed-size icon.
      Scalable, ///< Scalable-size icon.
      Threshold ///< A threshold icon.
    };

    /**
     * The type of a match.
     */
    enum MatchType {
      MatchExact, ///< Only try to find an exact match.
      MatchBest   ///< Take the best match if there is no exact match.

    };

    // if you add a group here, make sure to change the config reading in
    // KIconLoader too
    /**
     * The group of the icon.
     */
    enum Group {
	/// No group
	NoGroup=-1,
	/// Desktop icons
	Desktop=0,
	/// First group
	FirstGroup=0,
	/// Toolbar icons
	Toolbar,
	/// Main toolbar icons
        MainToolbar,
	/// Small icons, e.g. for buttons
	Small,
	/// Panel (Kicker) icons
	Panel,
	/// Icons for use in dialog titles, page lists, etc
	Dialog,
	/// Last group
	LastGroup,
	/// User icons
	User
         };

    /**
     * These are the standard sizes for icons.
     */
    enum StdSizes {
        /// small icons for menu entries
        SizeSmall=16,
        /// slightly larger small icons for toolbars, panels, etc
        SizeSmallMedium=22,
        /// medium sized icons for the desktop
        SizeMedium=32,
        /// large sized icons for the panel
        SizeLarge=48,
        /// huge sized icons for iconviews
        SizeHuge=64,
        /// enormous sized icons for iconviews
        SizeEnormous=128
         };

    /**
     * Defines the possible states of an icon.
     */
    enum States { DefaultState, ///< The default state.
		  ActiveState,  ///< Icon is active.
		  DisabledState, ///< Icon is disabled.
		  LastState      ///< Last state (last constant)
    };

    /**
     * The size in pixels of the icon.
     */
    int size;

    /**
     * The context of the icon.
     */
    Context context;

    /**
     * The type of the icon: Fixed, Scalable or Threshold.
     **/
    Type type;

    /**
     * The threshold in case type == Threshold
     */
    int threshold;

    /**
     * The full path of the icon.
     */
    QString path;

private:
    class KIconPrivate;
    KIconPrivate * d;
};

inline KIconLoader::Group& operator++(KIconLoader::Group& group) { group = static_cast<KIconLoader::Group>(group+1); return group; }
inline KIconLoader::Group operator++(KIconLoader::Group& group,int) { KIconLoader::Group ret = group; ++group; return ret; }

/**
 * Class to use/access icon themes in KDE. This class is used by the
 * iconloader but can be used by others too.
 * @see KIconLoader
 */
class KDEUI_EXPORT KIconTheme
{
public:
    /**
     * Load an icon theme by name.
     * @param name the name of the theme (e.g. "hicolor" or "keramik")
     * @param appName the name of the application. Can be null. This argument
     *        allows applications to have themed application icons.
     */
    explicit KIconTheme(const QString& name, const QString& appName=QString());
    ~KIconTheme();

    /**
     * The stylized name of the icon theme.
     * @return the (human-readable) name of the theme
     */
    QString name() const;

    /**
     * The internal name of the icon theme (same as the name argument passed
     *  to the constructor).
     * @return the internal name of the theme
     */
    QString internalName() const;

    /**
     * A description for the icon theme.
     * @return a human-readable description of the theme, QString()
     *         if there is none
     */
    QString description() const;

    /**
     * Return the name of the "example" icon. This can be used to
     * present the theme to the user.
     * @return the name of the example icon, QString() if there is none
     */
    QString example() const;

    /**
     * Return the name of the screenshot.
     * @return the name of the screenshot, QString() if there is none
     */
    QString screenshot() const;

    /**
     * Returns the toplevel theme directory.
     * @return the directory of the theme
     */
    QString dir() const;

    /**
     * The themes this icon theme falls back on.
     * @return a list of icon themes that are used as fall-backs
     */
    QStringList inherits() const;

    /**
     * The icon theme exists?
     * @return true if the icon theme is valid
     */
    bool isValid() const;

    /**
     * The icon theme should be hidden to the user?
     * @return true if the icon theme is hidden
     */
    bool isHidden() const;

    /**
     * The minimum display depth required for this theme. This can either
     * be 8 or 32.
     * @return the minimum bpp (8 or 32)
     */
    int depth() const;

    /**
     * The default size of this theme for a certain icon group.
     * @param group The icon group. See KIconLoader::Group.
     * @return The default size in pixels for the given icon group.
     */
    int defaultSize(KIconLoader::Group group) const;

    /**
     * Query available sizes for a group.
     * @param group The icon group. See KIconLoader::Group.
     * @return a list of available sized for the given group
     */
    QList<int> querySizes(KIconLoader::Group group) const;

    /**
     * Query available icons for a size and context.
     * @param size the size of the icons
     * @param context the context of the icons
     * @return the list of icon names
     */
    QStringList queryIcons(int size, KIconLoader::Context context = KIconLoader::Any) const;

    /**
     * Query available icons for a context and preferred size.
     * @param size the size of the icons
     * @param context the context of the icons
     * @return the list of icon names
     */
    QStringList queryIconsByContext(int size, KIconLoader::Context context = KIconLoader::Any) const;


    /**
     * Lookup an icon in the theme.
     * @param name The name of the icon, without extension.
     * @param size The desired size of the icon.
     * @param match The matching mode. KIconLoader::MatchExact returns an icon
     * only if matches exactly. KIconLoader::MatchBest returns the best matching
     * icon.
     * @return A K3Icon class that describes the icon. If an icon is found,
     * @see KIconLoader::isValid will return true, and false otherwise.
     */
    K3Icon iconPath(const QString& name, int size, KIconLoader::MatchType match) const;

    /**
     * Returns true if the theme has any icons for the given context.
     */
    bool hasContext( KIconLoader::Context context ) const;

    /**
     * List all icon themes installed on the system, global and local.
     * @return the list of all icon themes
     */
    static QStringList list();

    /**
     * Returns the current icon theme.
     * @return the name of the current theme
     */
    static QString current();

    /**
     * Reconfigure the theme.
     */
    static void reconfigure();

    /**
     * Returns the default icon theme.
     * @return the name of the default theme name
     */
    static QString defaultThemeName();

    /**
     * Defines the context menus that assignIconsToContextMenus is
     * aware of.
     *
     * For ReadOnlyText the menu is expected to have one entry.
     *
     * TextEditor is expected to have the full complement of
     * undo, redo, cut, copy, paste and clear.
     */
    enum ContextMenus { TextEditor,
                        ReadOnlyText };

    /**
     * Assigns standard icons to the various standard text edit context menus.
     */
    static void assignIconsToContextMenu(ContextMenus type, QList<QAction*> actions);

private:
    class KIconThemePrivate;
    KIconThemePrivate * const d;
};

#endif
