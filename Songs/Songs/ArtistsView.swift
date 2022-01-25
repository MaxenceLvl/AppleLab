//
//  ArtistsView.swift
//  Songs
//
//  Created by Maxence Levelu on 22/01/2022.
//

import SwiftUI

struct ArtistsView: View {
    
    @Binding var addArtist: Artist?
    @ObservedObject private var viewModel = ArtistsViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var selection: Artist?
    
    var body: some View {
        NavigationView {
            HStack {
                if viewModel.artists.isEmpty {
                    Spacer()
                    Text("❤️ Please add an Artist")
                    Spacer()
                } else {
                    VStack {
                        List {
                            ForEach(viewModel.artists, id: \.self) { artist in
                                HStack {
                                    if let firstName = artist.firstName, let lastName = artist.lastName {
                                        Text("\(firstName)  \(lastName)").tag(artist as Artist?)
                                    }
                                    Spacer()
                                    Image(systemName: self.selection == artist ? "checkmark" : "")
                                }
                                .padding(.horizontal, 5)
                                .onTapGesture {
                                    self.selection = artist
                                }
                            }.onDelete { offsets in
                                viewModel.deleteArtist(at: offsets)
                            }
                        }
                        .listStyle(.insetGrouped)
                        Spacer()
                        Button {
                            addArtist = selection
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Select this artist")
                                    .font(.headline)
                                    .padding()
                                    .background(Color.accentColor)
                                    .cornerRadius(40)
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke()
                                    )
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Artists")
        .navigationBarItems(
            trailing:
                Button {
                    viewModel.showAddArtistView.toggle()
                } label: {
                    Image(systemName: "plus")
                }
        )
        .sheet(isPresented: $viewModel.showAddArtistView, onDismiss: {
            viewModel.fetchArtists()
        }){ AddArtistView() }
        .onAppear {
            viewModel.fetchArtists()
        }
    }
}
