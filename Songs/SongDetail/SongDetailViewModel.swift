//
//  SongDetailViewModel.swift
//  Songs
//
//  Created by Maxence Levelu on 25/01/2022.
//

import Foundation
import SwiftUI

class SongDetailViewModel: ObservableObject {
    
    @Published var favoritesSong = Song()
    @Published var isAdded = false
    
    init(with song:Song){}
    
//    func addSongsFromFavorites(with song: Song) {
//        let res = DBManager.shared.addFavSong(by: song.objectID)
//        
//        switch res {
//            case .failure: return
//            case .success(let result): self.isAdded = result
//        }
//    }
    
}
