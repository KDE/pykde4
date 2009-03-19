# Copyright (C) 2007 Simon Edwards <simon@simonzone.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Library General Public
# License as published by the Free Software Foundation; either
# version 2 of the License or (at your option) version 2.1 or 
# version 3 or, at the discretion of KDE e.V. (which shall act as
# a proxy as in section 14 of the GPLv3), any later version.
# 
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Library General Public License for more details.
# 
# You should have received a copy of the GNU Library General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston MA  02110-1301 USA
#
pluginType = CW_FILTER

def getFilter():
    import PyKDE4.kdeui
    import PyKDE4.kio

    # Load in the lists of KDE widgets.
    kde_widgets = {}
    for name,mod in [ ('PyKDE4.kdeui',PyKDE4.kdeui), ('PyKDE4.kio',PyKDE4.kio)]:
        for symbol in dir(mod):
            kde_widgets[symbol] = name

    def _kdefilter(widgetname, baseclassname, module):
        if widgetname in kde_widgets:
            return (MATCH, (widgetname, baseclassname, kde_widgets[widgetname]))
        else:
            return (NO_MATCH, None)
    return _kdefilter
