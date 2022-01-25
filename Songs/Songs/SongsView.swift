//
//  SongsView.swift
//  Songs
//
//  Created by Maxence Levelu on 19/01/2022.
//

import SwiftUI

struct SongsView: View {
    @ObservedObject private var viewModel = SongsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.songs.isEmpty {
                    HStack {
                        Spacer()
                        Text("❤️ Please add a Song")
                        Spacer()
                    }
                } else {
                    ForEach(viewModel.songs) { song in
                        let songDetailViewModel = SongDetailViewModel(with: song)
                        NavigationLink(destination: SongDetailView(vm: songDetailViewModel)) {
                            HStack {
                                if let title = song.title {
                                    Text(title)
                                }
                                Spacer()
                                Text(song.artist?.firstName ?? "No Artist")
                            }
                        }
                    }.onDelete { offsets in
                        viewModel.deleteSongs(at: offsets)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .animation(.easeInOut, value: viewModel.songs)
            .navigationTitle("Songs")
            .navigationBarItems(
                trailing:
                    Button {
                        viewModel.showAddSongView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
            )
            .sheet(isPresented: $viewModel.showAddSongView, onDismiss: {
                viewModel.fetchSongs()
            }){ AddSongView() }
        }.onAppear {
            viewModel.fetchSongs()
        }
    }
}

struct SongsView_Previews: PreviewProvider {
    static var previews: some View {
        SongsView()
    }
}
