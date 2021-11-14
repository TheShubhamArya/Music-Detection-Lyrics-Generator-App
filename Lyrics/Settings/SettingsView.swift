//
//  SettingsView.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/11/21.
//

import SwiftUI

struct SettingDetail: Identifiable, Hashable {
    let id = UUID()
    let section : Int
    var title : String
    var imageName : String
    var color : UIColor
}

struct SettingsView: View {
    
    let headers = ["Preferences","Support Developer","Help","Information"]

    let settingDetails = [
        [
            SettingDetail(section: 0, title: "App icons", imageName: "square.grid.2x2", color: .systemBlue),
            SettingDetail(section: 0, title: "Authenticate to open", imageName: "lock", color: .systemTeal),
            SettingDetail(section: 0, title: "Default currency", imageName: "banknote", color: .systemGreen),
            SettingDetail(section: 0, title: "Transaction modes", imageName: "network", color: .systemYellow),
            SettingDetail(section: 0, title: "Bar chart colors", imageName: "paintpalette", color: .orange),
            SettingDetail(section: 0, title: "Chart animations", imageName: "chart.pie", color: .systemRed),
            SettingDetail(section: 0, title: "Automatically set current location for transaction", imageName: "mappin", color: .red)
        ],
        [
            SettingDetail(section: 1, title: "Write a review", imageName: "pencil.and.outline", color: .systemPink),
            SettingDetail(section: 1, title: "Invite your friends", imageName: "person.3.fill", color: .magenta)
        ],
        [
            SettingDetail(section: 2, title: "Contact me", imageName: "envelope", color: .systemPurple),
            SettingDetail(section: 2, title: "Report a bug", imageName: "ant", color: .systemIndigo)
        ],
        [
            SettingDetail(section: 3, title: "Privacy policy", imageName: "lock.icloud", color: .link),
            SettingDetail(section: 3, title: "About developer", imageName: "hammer", color: .darkGray)
        ]
    ]
    
    var body: some View {
        Form {
            ForEach(settingDetails, id: \.self) { settingDetailsSection in
                Section(content: {
                    ForEach(settingDetailsSection, id: \.id) { settingDetail in
                        SettingsCellView(settingDetail: settingDetail)
                    }
                }, header: {
                    Text(headers[settingDetailsSection[0].section])
                })
            }
            
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Settings")
        .navigationViewStyle(.stack)
    }
}

struct SettingsCellView: View {
    
    var settingDetail: SettingDetail
    
    var body: some View {
        HStack {
            Image(systemName: settingDetail.imageName)
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .background(Color(uiColor: settingDetail.color))
                .cornerRadius(5)
                .padding(.vertical, 4)
            
            VStack {
                Text(settingDetail.title)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 15))
                .foregroundColor(Color(uiColor: .tertiaryLabel))
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
