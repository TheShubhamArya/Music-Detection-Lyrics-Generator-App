//
//  NavigationBarButtonView.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/11/21.
//

import SwiftUI

enum ButtonType {
    case settings, save, list
}

struct NavigationBarButtonView: View {
    var imageName : String
    var buttonType : ButtonType
    
    var body : some View {
        NavigationLink(destination: destinationView(type: buttonType)){
            Image(systemName: imageName)
                .font(.system(size: 18))
                .foregroundColor(.pink)
                .padding()
                .mask(Circle())
        }.frame(width: 36, height: 36)
    }
    
    @ViewBuilder
    func destinationView(type: ButtonType) -> some View {
        switch type {
        case .settings:
            SettingsView()
        case .list:
            ListView()
        case .save:
            ListView()
        }
    }
}

struct NavigationBarButtonListView: View {
    var imageName : String
    var buttonType : ButtonType
    
    var body : some View {
        NavigationLink(destination: ListView()){
            Image(systemName: imageName)
                .font(.system(size: 18))
                .foregroundColor(.pink)
                .padding()
                .mask(Circle())
        }.frame(width: 36, height: 36)
    }
}

struct NavigationBarButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarButtonView(imageName: "gear", buttonType: .save)
    }
}
