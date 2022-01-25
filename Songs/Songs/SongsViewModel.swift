//
//  SongsViewModel.swift
//  Songs
//
//  Created by Maxence Levelu on 19/01/2022.
//

import Foundation
import SwiftUI

class SongsViewModel: ObservableObject {
    
    @Published var showAddSongView: Bool = false
    @Published var songs = [Song]()
    
    init() {
        fetchSongs()
    }
    
    func fetchSongs() {
        let songResult = DBManager.shared.getAllSongs()
        switch songResult {
        case .failure: return
        case .success(let songs): self.songs = songs
            
        }
    }
    
    func deleteSongs(at offsets: IndexSet) {
        offsets.forEach { index in
            DBManager.shared.deleteSong(by: songs[index].objectID)
        }
        songs.remove(atOffsets: offsets)
    }
    
}
