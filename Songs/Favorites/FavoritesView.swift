//
//  FavoritesView.swift
//  Songs
//
//  Created by Maxence Levelu on 19/01/2022.
//

import SwiftUI

struct FavoritesView: View {
    
    @ObservedObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.favoritesSong.isEmpty {
                    HStack {
                        Spacer()
                        Text("You have no Favorite Songs 😕")
                        Spacer()
                    }
                } else {
                    ForEach(viewModel.favoritesSong) { song in
                        HStack {
                            if let title = song.title {
                                Text(title)
                            }
                            Spacer()
                            Text(song.artist?.firstName ?? "No Artist")
                            Spacer()
                            Image(systemName: "star.fill")
                                .foregroundColor(.accentColor)
                                .onTapGesture {
                                    viewModel.removeSongsFromFavorites(with: song)
                                    viewModel.fetchFavoriteSongs()
                                }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .animation(.easeInOut, value: viewModel.favoritesSong)
            .navigationTitle("Favorite Songs")
        }.onAppear {
            viewModel.fetchFavoriteSongs()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
