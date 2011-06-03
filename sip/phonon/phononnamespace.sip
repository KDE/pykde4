//
//     Copyright 2008 Simon Edwards <simon@simonzone.com>

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
#include <phonon/phononnamespace.h>
%End

namespace Phonon
{
    const char *phononVersion() /Encoding="ASCII"/;

    enum DiscType {
        NoDisc,
        Cd,
        Dvd,
        Vcd
    };

    enum MetaData {
        ArtistMetaData,
        AlbumMetaData,
        TitleMetaData,
        DateMetaData,
        GenreMetaData,
        TracknumberMetaData,
        DescriptionMetaData,
        MusicBrainzDiscIdMetaData
    };

    enum State
    {
        LoadingState,
        StoppedState,
        PlayingState,
        BufferingState,
        PausedState,
        ErrorState
    };

    enum Category
    {
        NoCategory,
        NotificationCategory,
        MusicCategory,
        VideoCategory,
        CommunicationCategory,
        GameCategory,
        AccessibilityCategory,
        LastCategory
    };

    enum CaptureCategory
    {
        NoCaptureCategory = NoCategory,
        CommunicationCaptureCategory = CommunicationCategory,
        RecordingCaptureCategory,
        ControlCaptureCategory = AccessibilityCategory
    };

    namespace Capture
    {
        enum DeviceType
        {
            AudioType,
            VideoType
        };
    };

    enum ErrorType {
        NoError,
        NormalError,
        FatalError
    };
    QString categoryToString(Phonon::Category c);
}; // namespace Phonon
