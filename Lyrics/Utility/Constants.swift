//
//  Constants.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/14/21.
//

import Foundation

struct K {
    static let headers = ["Preferences","Support Developer","Help","Information",""]

    static let settingDetails = [
        [
            SettingDetail(section: 0, title: "Change color theme", imageName: "paintpalette", color: .systemBlue),
            SettingDetail(section: 0, title: "Auto save all songs found", imageName: "square.and.arrow.down", color: .systemOrange, cellType: .toggle),
            SettingDetail(section: 0, title: "Auto add to Apple Music", imageName: "applelogo", color: .systemPink, cellType: .toggle),
            SettingDetail(section: 0, title: "Auto add to Shazam", imageName: "music.note.list", color: .systemTeal, cellType: .toggle)
        ],
        [
            SettingDetail(section: 1, title: "Write a review", imageName: "pencil.and.outline", color: .systemGreen),
            SettingDetail(section: 1, title: "Invite your friends", imageName: "person.3.fill", color: .magenta)
        ],
        [
            SettingDetail(section: 2, title: "Contact me", imageName: "envelope", color: .systemPurple),
            SettingDetail(section: 2, title: "Report a bug", imageName: "ant", color: .systemIndigo)
        ],
        [
            SettingDetail(section: 3, title: "Privacy policy", imageName: "lock.icloud", color: .link),
            SettingDetail(section: 3, title: "About developer", imageName: "hammer", color: .darkGray)
        ],
        [
            SettingDetail(section: 4, title: "Lyrics by Shubham Arya", imageName: "", color: .clear, cellType: .titleLeftSubtitleRight, subtitle: "v1.0(1)")
        ]
    ]
}
