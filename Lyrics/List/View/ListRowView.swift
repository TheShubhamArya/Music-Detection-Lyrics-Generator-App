//
//  ListRowView.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/12/21.
//

import SwiftUI

struct ListRowView: View {
    
    var song : Song
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                AsyncImage(url: song.albumArtURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70)
                        .cornerRadius(5)
                        .padding(.trailing)
                        .padding(.vertical, 5)
                } placeholder: {
                    Image(systemName: "music.quarternote.3")
                        .font(.system(size: 60))
                        .frame(width: 70)
                        .padding(.trailing)
                        .redacted(reason: .placeholder)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(song.title ?? "No title")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    Text(song.artistName ?? "No artist")
                        .font(.system(size: 15))
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
            }
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(song: Song())
    }
}
