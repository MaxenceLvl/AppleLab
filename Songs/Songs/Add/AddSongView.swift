//
//  AddSongView.swift
//  Songs
//
//  Created by Maxence Levelu on 19/01/2022.
//

import SwiftUI

struct AddSongView: View {
    
    @ObservedObject private var viewModel = AddSongViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Song Title", text: $viewModel.songTitle)
                    DatePicker("Release Date", selection: $viewModel.releaseDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    RatingView(title: "Rate", rating: $viewModel.rating)
                } header: {
                    Text("Song")
                }
                
                Section {
                    if viewModel.artist == nil {
                        NavigationLink {
                            ArtistsView(addArtist: $viewModel.artist)
                        } label: {
                            Label("Add Artist", systemImage: "person.fill")
                        }
                    } else {
                        NavigationLink {
                            ArtistsView(addArtist: $viewModel.artist)
                        } label: {
                            Label {
                                Text("Artist")
                                Spacer()
                                if let firstName = viewModel.artist?.firstName, let lastName = viewModel.artist?.lastName {
                                    Text("\(firstName) \(lastName)")
                                        .foregroundColor(.gray)
                                }
                            } icon : {
                                Image(systemName: "person.fill")
                            }
                        }
                    }
                } header: {
                    Text("Artist")
                }
                
                Section {
                    Toggle("Favorite song", isOn: $viewModel.isFavorite)
                        .toggleStyle(.automatic)
                        .tint(.accentColor)
                }
                
                Button {
                    viewModel.addSong()
                } label: {
                    HStack {
                        Spacer()
                        Text("Add song")
                            .font(.headline)
                        Spacer()
                    }
                }
                
            }
            .navigationTitle("Add Song")
            .navigationBarTitleDisplayMode(.inline)
            .alert(viewModel.alertTitle,
                   isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) {
                    presentationMode.wrappedValue.dismiss() }
            } message: {
                Text(viewModel.alertMessage)
            }
            .onAppear { if viewModel.artist != nil {
                print(viewModel.artist!)
            }
            }
        }
    }
}

struct AddSongView_Previews: PreviewProvider {
    static var previews: some View {
        AddSongView()
    }
}
