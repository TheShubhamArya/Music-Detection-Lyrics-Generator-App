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
    var cellType : CellType = .basic
    var subtitle = ""
}

struct SettingsView: View {
    
    var body: some View {
        Form {
            ForEach(K.settingDetails, id: \.self) { settingDetailsSection in
                Section(content: {
                    ForEach(settingDetailsSection, id: \.id) { settingDetail in
                        SettingsCellView(settingDetail: settingDetail)
                    }
                }, header: {
                    Text(K.headers[settingDetailsSection[0].section])
                })
                    .padding(.vertical, -10)
            }
            
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Settings")
        .navigationViewStyle(.stack)
    }
}

struct SettingsCellView: View {
    
    var settingDetail: SettingDetail
    @State private var isToggle : Bool = false
    var body: some View {
        if settingDetail.cellType == .basic {
            HStack {
                Image(systemName: settingDetail.imageName)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .background(Color(uiColor: settingDetail.color))
                    .cornerRadius(5)
                    .padding(.vertical, 4)
                    .padding(.trailing, 5)
                
                VStack {
                    Text(settingDetail.title)
                }
                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 15))
                    .foregroundColor(Color(uiColor: .tertiaryLabel))
            }
        } else if settingDetail.cellType == .toggle {
            Toggle(isOn: $isToggle){
                Image(systemName: settingDetail.imageName)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .background(Color(uiColor: settingDetail.color))
                    .cornerRadius(5)
                    .padding(.vertical, 4)
                    .padding(.trailing, 5)
                Text(settingDetail.title)
            }
        } else {
            HStack {
                Text(settingDetail.title)
                    .font(.system(size: 13))
                    .fontWeight(.regular)
                Spacer()
                Text(settingDetail.subtitle)
                    .font(.system(size: 13))
                    .fontWeight(.light)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
            .listRowBackground(Color.clear)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
