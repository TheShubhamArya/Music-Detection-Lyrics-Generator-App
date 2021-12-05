//
//  Enums.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/14/21.
//

import Foundation

enum CellType {
    case basic, toggle, titleLeftSubtitleRight
}

enum ErrorStatus : Error {
    case noDataAvailable
    case cannotProcessdata
}

enum ButtonType {
    case settings, save, list
}

enum ToggleType: String {
    case saveAllSongs = "autoSaveAllSongs"
    case addToAppleMusic = "autoAddToAppleMusic"
    case addToShazam = "autoaddToShazam"
    case partyMode = "partyModeForBackgroundMusicDetection"
}
