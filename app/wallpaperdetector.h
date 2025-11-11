/*******************************************************************************
* Copyright (c) 2013-2021 "Filippo Scognamiglio"
* https://github.com/Swordfish90/cool-retro-term
*
* This file is part of cool-retro-term.
*
* cool-retro-term is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <www.gnu.org/licenses/>.
*******************************************************************************/

#ifndef WALLPAPERDETECTOR_H
#define WALLPAPERDETECTOR_H

#include <QObject>
#include <QString>

class WallpaperDetector : public QObject
{
    Q_OBJECT
public:
    explicit WallpaperDetector(QObject *parent = nullptr);

    Q_INVOKABLE QString detectWallpaper();

private:
    QString detectGnomeWallpaper();
    QString detectKdeWallpaper();
    QString detectXfceWallpaper();
    QString detectMateWallpaper();
};

#endif // WALLPAPERDETECTOR_H
