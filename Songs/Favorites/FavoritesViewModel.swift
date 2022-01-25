//
//  FavoritesViewModel.swift
//  Songs
//
//  Created by Maxence Levelu on 22/01/2022.
//

import Foundation
import SwiftUI

class FavoritesViewModel: ObservableObject {
    
    @Published var favoritesSong = [Song]()
    @Published var isRemoved = false
    
    init() {
        fetchFavoriteSongs()
    }
    
    func fetchFavoriteSongs() {
        let songResult = DBManager.shared.getFavSongs()
        switch songResult {
            case .failure: return
            case .success(let songs): self.favoritesSong = songs
        }
    }
    
    func removeSongsFromFavorites(with song: Song) {
        let res = DBManager.shared.deleteFavSong(by: song.objectID)
        
        switch res {
            case .failure: return
            case .success(let result): self.isRemoved = result
        }
    }
    
}
