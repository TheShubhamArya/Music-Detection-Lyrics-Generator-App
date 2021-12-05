//
//  SettingsView.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/11/21.
//

import SwiftUI

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
    
            }
            
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Settings")
        .navigationViewStyle(.stack)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
