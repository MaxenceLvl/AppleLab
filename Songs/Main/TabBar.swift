//
//  ContentView.swift
//  Songs
//
//  Created by Maxence Levelu on 19/01/2022.
//

import SwiftUI

struct TabBar: View {
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            SongsView()
                .tabItem { Label("Songs", systemImage: "music.note.list")}
                .tag(0)
            FavoritesView()
                .tabItem { Label("Favorites", systemImage: "star")}
                .tag(1)
        }
        .onAppear {
            DispatchQueue.main.async {
//                DBManager.shared.addDefaultArtist()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
