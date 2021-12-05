//
//  SettingDetail.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/16/21.
//

import UIKit

struct SettingDetail: Identifiable, Hashable {
    let id = UUID()
    let section : Int
    var title : String
    var imageName : String
    var color : UIColor
    var cellType : CellType = .basic
    var subtitle = ""
    var isSF = true
    var toggleType : ToggleType?
}
