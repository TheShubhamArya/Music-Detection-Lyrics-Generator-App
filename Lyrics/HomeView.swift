//
//  HomeView.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/10/21.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        let music = viewModel.shazamMedia
        NavigationView{
            GeometryReader { geo1 in
                ZStack {
                    AsyncImage(url: music.albumArtURL) { image in
                        GeometryReader { geo2 in
                            image
                                .resizable()
                                .scaledToFill()
                                .blur(radius: 10, opaque: true)
                                .opacity(0.5)
                                .edgesIgnoringSafeArea(.all)
                                .frame(width: geo1.size.width, height: geo2.size.height, alignment: .center)
                        }
                        
                    } placeholder: {
                        EmptyView()
                    }
                    
                    VStack {
                        
                        AsyncImage(url: music.albumArtURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 10)
                            
                                .foregroundColor(.clear)
                        }
                        .cornerRadius(10)
                        .frame(height: geo1.size.height / 3)
                        
                        VStack {
                            Text(music.title ?? "Title")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                            Text(music.artistName ?? "Artist Name")
                                .font(.title3)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                            ScrollView(.vertical) {
                                Text(music.lyrics ?? "No lyrics found...")
                                    .multilineTextAlignment(.center)
                                    .font(.body)
                            }
                        }.padding()
                        
                        Spacer()
                        
                        Button(action: {
                            listenTapped()
                        }) {
                            Text(viewModel.isRecording ? "Listening..." : "Listen")
                                .frame(width: 300)
                                .font(.title2)
                                .foregroundColor(.white)
                        }.buttonStyle(.bordered)
                            .controlSize(.large)
                            .shadow(radius: 10)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {settingsButton}
                ToolbarItem(placement: .navigationBarTrailing) {saveButton}
                ToolbarItem(placement: .navigationBarTrailing) {listButton}
            }
        }
    }
    
    func listenTapped() {
        viewModel.isRecording = !viewModel.isRecording
        if !viewModel.isRecording {
            viewModel.stopListening()
        } else {
            viewModel.startOrEndListening()
        }
    }
    
    var settingsButton : some View {
        Button(action: {
            print("Settings button clicked")
        }) {
            HStack {
                Image(systemName: "gear")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
            }
            .padding()
            .mask(Circle())
        }.frame(width: 36, height: 36)
    }
    
    var saveButton : some View {
        Button(action: {
            print("Save button clicked")
        }) {
            HStack {
                Image(systemName: "square.and.arrow.down")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
            }
            .padding()
            .mask(Circle())
        }.frame(width: 36, height: 36)
    }
    
    var listButton : some View {
        Button(action: {
            print("List button clicked")
        }) {
            HStack {
                Image(systemName: "line.horizontal.3")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
            }
            .padding()
            .mask(Circle())
        }.frame(width: 36, height: 36)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
