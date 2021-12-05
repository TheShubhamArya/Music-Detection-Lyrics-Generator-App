//
//  ListDetailView.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/15/21.
//

import SwiftUI

struct ListDetailView: View {
    var music : Song
    var body: some View {
        GeometryReader { fullView in
            ZStack {
                AsyncImage(url: music.albumArtURL) { image in
                    image
                        .resizable()
//                        .scaledToFill()
                        .blur(radius: 10, opaque: true)
                        .opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: fullView.size.width, height: fullView.size.height, alignment: .center)
                        .background(Color.clear)
                    
                } placeholder: {
                    Color.clear
                }
                
                VStack {
                    AsyncImage(url: music.albumArtURL) { image in
                        Button(action: {
                            guard let webURL = music.webURL,
                                  UIApplication.shared.canOpenURL(webURL) else {
                                      return
                                  }
                            UIApplication.shared.open(webURL,
                                                      options: [:],
                                                      completionHandler: nil)
                        }) {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.clear)
                    }
                    .cornerRadius(10)
                    .frame(height: ((music.lyrics!.isEmpty) && (music.webURL != nil)) ? fullView.size.height / 2 :  fullView.size.height / 3)
                    
                    VStack {
                        Text(music.title ?? "Title")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        Text(music.artistName ?? "Artist Name")
                            .font(.title3)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                        if music.lyrics!.isEmpty {
                            if let webURL = music.webURL {
                                Spacer()
                                Link(destination: webURL){
                                    HStack {
                                        Spacer()
                                        Image("shazam")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 35, height: 35)
                                            .cornerRadius(5)
                                            .padding([.leading, .top, .bottom])
                                        Text("Shazam for more details")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding([.trailing, .top, .bottom])
                                        Spacer()
                                    }
                                }
                                .background(Color.blue)
                                .cornerRadius(10)
                                .frame(height: 60)
                            }
                            
                        } else {
                            ScrollView(.vertical) {
                                Text(music.lyrics ?? "No lyrics found...")
                                    .multilineTextAlignment(.center)
                                    .font(.body)
                            }
                            .padding(-5)
                        }
                        
                    }.padding()
                    Text(music.dateSaved!.fullDateString)
                        .font(.system(size: 11))
                        .foregroundColor(Color.secondary)
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: shareTapped) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 18))
                }
            }
        }
    }
    
    func shareTapped() {
        guard let urlShare = music.webURL else { return }
        let message = "\n" + (music.title ?? "") + " - " + (music.artistName ?? "")
        
        let activityVC = UIActivityViewController(activityItems: [urlShare, message], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}

struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailView(music: Song())
    }
}
