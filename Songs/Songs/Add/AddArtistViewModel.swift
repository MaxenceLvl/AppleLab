//
//  AddArtistViewModel.swift
//  Songs
//
//  Created by Maxence Levelu on 22/01/2022.
//

import Foundation

class AddArtistViewModel: ObservableObject {
    
    @Published var firstname: String = ""
    @Published var lastName: String = ""
    @Published var coverURL: URL? = nil
    @Published var showAlert = false
    var alertTitle: String = "OK"
    var alertMessage: String = ""
    
    func addArtist() {
        let artistResult = DBManager.shared.addArtist(
            firstName: firstname,
            lastName: lastName,
            coverURL: coverURL
        )
        
        switch artistResult {
        case .success(let artist):
            handleAlert(
                title: "Well Done",
                message: "Successfully added \(artist.firstName ?? "Artist firstname" )  \(artist.lastName ?? "Artist lastname")"
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
