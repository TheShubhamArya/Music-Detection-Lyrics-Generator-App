//
//  ListRowView.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/12/21.
//

import SwiftUI

struct ListRowView: View {
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.pink, lineWidth: 0.5)
            HStack {
                Image(systemName: "music.quarternote.3")
                    .font(.system(size: 30))
                    .padding()
                VStack(alignment: .leading, spacing: 5) {
                    Text("Song name")
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text("Artist name")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                Image(systemName: "chevron.forward")
                    .font(Font.system(.caption).weight(.bold))
                    .foregroundColor(Color(UIColor.tertiaryLabel))
                    .padding()
                
            }
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView()
    }
}
