//
//  HomeView.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/10/21.
//

import SwiftUI
import AVKit
import LinkPresentation

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Song.entity(), sortDescriptors: []) var songs : FetchedResults<Song>
    
    var body: some View {
        let music = viewModel.shazamMedia
        NavigationView{
            GeometryReader { fullView in
                ZStack {
                    AsyncImage(url: music.albumArtURL) { image in
                        GeometryReader { geo2 in
                            image
                                .resizable()
                                .scaledToFill()
                                .blur(radius: 10, opaque: true)
                                .opacity(0.5)
                                .edgesIgnoringSafeArea(.all)
                                .frame(width: geo2.size.width, height: geo2.size.height, alignment: .center)
                        }
                        
                    } placeholder: {
                        EmptyView()
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
                        
                        Spacer()
                        
                        Button(action: {
                            simpleSuccess()
                            viewModel.listenTapped()
                        }) {
                            Text(viewModel.isRecording ? "Listening..." : "Listen")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .buttonStyle(GradientButtonStyle())
                        .padding([.trailing, .leading])
                        .animation(songRecognitionAnimation(), value: viewModel.isRecording)
                        .frame(height: 100)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationBarButtonView(imageName: "gear", buttonType: .settings)
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if !viewModel.foundNothing {
                    Button(action: shareTapped) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 18))
                            .foregroundColor(.pink)
                    }
                    Button(action: saveTapped) {
                        Image(systemName: "square.and.arrow.down")
                            .font(.system(size: 18))
                            .foregroundColor(.pink)
                    }
                    }
                    NavigationBarButtonListView(imageName: "line.horizontal.3", buttonType: .list)
                }
            }
        }
    }
    
    func shareTapped() {
        guard let urlShare = viewModel.shazamMedia.webURL else { return }
        let message = "\n" + (viewModel.shazamMedia.title ?? "") + " - " + (viewModel.shazamMedia.artistName ?? "")
        
        let activityVC = UIActivityViewController(activityItems: [urlShare, message], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
    func saveTapped() {
        let song = Song(context: self.moc)
        let music = viewModel.shazamMedia
        song.id = music.shazamID
        song.title = music.title
        song.subtitle = music.subtitle
        song.artistName = music.artistName
        if let webURL = music.webURL {
            song.webURL = webURL
        }
        if let albumArtURL = music.albumArtURL {
            song.albumArtURL = albumArtURL
        }
        song.dateSaved = Date()
        song.lyrics = music.lyrics
        do {
            try self.moc.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private func songRecognitionAnimation() -> Animation {
        viewModel.isRecording ? .easeInOut(duration: 1.4).repeatForever() : .default
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color(hex: 0xFF1493)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10.0)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
                                                                   
