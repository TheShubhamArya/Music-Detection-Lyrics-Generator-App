//
//  ListView.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/11/21.
//

import SwiftUI
import ShazamKit

struct ListView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Song.entity(), sortDescriptors: []) var songs : FetchedResults<Song>
    
    var body: some View {
        VStack {
            List {
                ForEach(songs, id: \.uuid) { song in
                    {
                        NavigationLink(destination: ListDetailView(music: song)){
                            ListRowView(song: song)
                        }
                    }()
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                }
                .onDelete(perform: delete(at:))
            }
            .listStyle(.plain)
        }
        .navigationTitle("Saved")
        .navigationViewStyle(.stack)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let song = songs[offset]
            moc.delete(song)
        }
        try? self.moc.save()
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
