//
//  ListView.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/11/21.
//

import SwiftUI
import ShazamKit

struct ListView: View {
    
    var array = [1,2,3,4,5]
    
    @StateObject private var viewModel = HomeViewModel()
    //    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack {
            List {
                ForEach(array, id: \.self) { item in
                    {
                        ListRowView()
                    }()
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Saved")
        .navigationViewStyle(.stack)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
