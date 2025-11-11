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

// WallpaperDetector - Detects the desktop wallpaper path from various desktop environments
// This is used for the fake transparency feature to show the desktop background behind the terminal

#include "wallpaperdetector.h"
#include <QProcess>
#include <QDebug>
#include <QFile>

WallpaperDetector::WallpaperDetector(QObject *parent) : QObject(parent)
{
}

QString WallpaperDetector::detectWallpaper()
{
    QString wallpaper;

    // Try different desktop environments
    wallpaper = detectGnomeWallpaper();
    if (!wallpaper.isEmpty() && QFile::exists(wallpaper))
        return wallpaper;

    wallpaper = detectKdeWallpaper();
    if (!wallpaper.isEmpty() && QFile::exists(wallpaper))
        return wallpaper;

    wallpaper = detectXfceWallpaper();
    if (!wallpaper.isEmpty() && QFile::exists(wallpaper))
        return wallpaper;

    wallpaper = detectMateWallpaper();
    if (!wallpaper.isEmpty() && QFile::exists(wallpaper))
        return wallpaper;

    return QString();
}

QString WallpaperDetector::detectGnomeWallpaper()
{
    QProcess process;
    
    // Try picture-uri first (light mode wallpaper)
    process.start("gsettings", QStringList() << "get" << "org.gnome.desktop.background" << "picture-uri");
    process.waitForFinished();
    
    QString output = process.readAllStandardOutput().trimmed();
    
    // If empty or failed, try picture-uri-dark (dark mode wallpaper, GNOME 42+)
    if (output.isEmpty() || output == "''") {
        process.start("gsettings", QStringList() << "get" << "org.gnome.desktop.background" << "picture-uri-dark");
        process.waitForFinished();
        output = process.readAllStandardOutput().trimmed();
    }
    
    // Remove quotes and 'file://' prefix
    output.replace("'", "");
    output.replace("\"", "");
    if (output.startsWith("file://"))
        output = output.mid(7);
    
    return output;
}

QString WallpaperDetector::detectKdeWallpaper()
{
    QProcess process;
    process.start("kreadconfig5", QStringList() << "--file" << "plasma-org.kde.plasma.desktop-appletsrc" 
                  << "--group" << "Containments" << "--group" << "1" << "--group" << "Wallpaper"
                  << "--group" << "org.kde.image" << "--group" << "General" << "--key" << "Image");
    process.waitForFinished();
    
    QString output = process.readAllStandardOutput().trimmed();
    
    if (output.startsWith("file://"))
        output = output.mid(7);
    
    return output;
}

QString WallpaperDetector::detectXfceWallpaper()
{
    QProcess process;
    process.start("xfconf-query", QStringList() << "-c" << "xfce4-desktop" 
                  << "-p" << "/backdrop/screen0/monitor0/workspace0/last-image");
    process.waitForFinished();
    
    QString output = process.readAllStandardOutput().trimmed();
    return output;
}

QString WallpaperDetector::detectMateWallpaper()
{
    QProcess process;
    process.start("gsettings", QStringList() << "get" << "org.mate.background" << "picture-filename");
    process.waitForFinished();
    
    QString output = process.readAllStandardOutput().trimmed();
    
    // Remove quotes
    output.replace("'", "");
    output.replace("\"", "");
    
    return output;
}
