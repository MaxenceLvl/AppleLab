//
//  AddSongViewModel.swift
//  Songs
//
//  Created by Maxence Levelu on 19/01/2022.
//

import Foundation
import SwiftUI

class AddSongViewModel: ObservableObject {
    @Published var songTitle: String = ""
    @Published var releaseDate = Date()
    @Published var rating: Int = 3
    @Published var isFavorite = false
    @Published var showAlert = false
    @Published var artist: Artist?
    var alertTitle: String = "OK"
    var alertMessage: String = ""
    
    func addSong() {
        let songResult = DBManager.shared.addSong(
            title: songTitle,
            rate: Int64(rating),
            releaseDate: releaseDate,
            isFavorite: isFavorite,
            lyrics: "bla bla bla",
            coverURL: URL(string: "https://api.lorem.space/image/album"),
            artist: artist
        )
        
        switch songResult {
        case .success(let song):
            handleAlert(
                title: "Well Done",
                message: "Successfully added \(song.title ?? "song" )"
            )
            break
        case .failure(let error):
            handleAlert(
                title: "Error",
                message: error.localizedDescription
            )
            break
        }
    }
    
    private func handleAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert.toggle()
    }
}
