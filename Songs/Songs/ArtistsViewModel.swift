//
//  ArtistViewModel.swift
//  Songs
//
//  Created by Maxence Levelu on 22/01/2022.
//

import Foundation
import SwiftUI

class ArtistsViewModel: ObservableObject {
    
    @Published var showAddArtistView: Bool = false
    @Published var artists = [Artist]()
    
    init() {
        fetchArtists()
    }
    
    func fetchArtists() {
        let artistResult = DBManager.shared.getAllArtists()
        switch artistResult {
        case .failure: return
        case .success(let artists): self.artists = artists
        }
    }
    
    func deleteArtist(at offsets: IndexSet) {
        offsets.forEach { index in
            DBManager.shared.deleteArtist(by: artists[index].objectID)
        }
        artists.remove(atOffsets: offsets)
    }
}
