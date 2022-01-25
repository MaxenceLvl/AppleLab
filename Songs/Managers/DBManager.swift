//
//  Persistence.swift
//  Songs
//
//  Created by Maxence Levelu on 19/01/2022.
//

import CoreData

struct DBManager {
    static let shared = DBManager()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Songs")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // MARK: - Songs
    
    func getAllSongs() -> Result<[Song], Error> {
        let fetchRequest = Song.fetchRequest()
        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
        fetchRequest.sortDescriptors = [descriptor]
        
        let context = container.viewContext
        
        do {
            let songs = try context.fetch(fetchRequest)
            return .success(songs)
        } catch {
            return .failure(error)
        }
        
    }
    
    func getSong(by id: NSManagedObjectID) -> Result<Song, Error> {
        let context = container.viewContext
        
        do {
            let song = try context.existingObject(with: id) as! Song
            return .success(song)
        } catch {
            return .failure(error)
        }
    }
    
    func deleteFavSong(by id: NSManagedObjectID) -> Result<Bool, Error> {
        let context = container.viewContext
        
        do {
            let song = try context.existingObject(with: id)
            song.setValue(false, forKey: "isFavorite")
            try context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
        
    }
    
    func getFavSongs() -> Result<[Song], Error> {
        let fetchRequest = Song.fetchRequest()
        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
        let predicate: NSPredicate = NSPredicate(format: "isFavorite = %d", true)
        fetchRequest.sortDescriptors = [descriptor]
        fetchRequest.predicate = predicate
        
        let context = container.viewContext
        
        do {
            let favoritesSongs = try context.fetch(fetchRequest)
            return .success(favoritesSongs)
        } catch {
            return .failure(error)
        }
    }
    
    @discardableResult
    func addSong(
        title: String,
        rate: Int64,
        releaseDate: Date,
        isFavorite: Bool = false,
        lyrics: String?,
        coverURL: URL?,
        artist: Artist?
    ) -> Result<Song, Error> {
        let context = container.viewContext
        let song = Song(entity: Song.entity(),
                        insertInto: DBManager.shared.container.viewContext)
        
        var defaultArtist: Artist?
        if artist == nil {
            let artistRes = getAllArtists()
            
            switch artistRes {
                case .failure: defaultArtist = nil
                case .success(let artists): defaultArtist = artists.first
            }
        }
        
        song.title = title
        song.releaseDate = releaseDate
        song.rate = rate
        song.isFavorite = isFavorite
        song.coverURL = (coverURL != nil) ? coverURL : URL(string: "https://api.lorem.space/image/album")
        song.lyrics = "bla bla bla bla"
        song.artist = (artist == nil) ? defaultArtist : artist
        
        do {
            try context.save()
            return .success(song)
        } catch {
            return .failure(error)
        }
        
    }
    
    @discardableResult
    func deleteSong(by id: NSManagedObjectID) -> Result<Void, Error> {
        let context = container.viewContext
        
        do {
            let song = try context.existingObject(with: id)
            context.delete(song)
            try context.save()
            
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    
    
    
    // MARK: Artist
    
//    func addDefaultArtist() {
//        let artistsResult = getAllArtists()
//        let context = container.viewContext
//
//        switch artistsResult {
//        case .failure: return
//        case .success(let artists):
//            if artists.isEmpty {
//                let artist = Artist(
//                    entity: Artist.entity(),
//                    insertInto: DBManager.shared.container.viewContext)
//
//                artist.firstName = "Sacha"
//                artist.lastName = "Durand"
//                artist.coverURL = URL(string: "https://api.lorem.space/image/face")
//                artist.songs = []
//
//                do {
//                    try context.save()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        
//    }
        
    @discardableResult
    func addArtist(
        firstName: String,
        lastName: String,
        coverURL: URL?
    ) -> Result<Artist, Error> {
        let context = container.viewContext

        let artist = Artist(entity: Artist.entity(), insertInto: DBManager.shared.container.viewContext)

        artist.firstName = firstName
        artist.lastName = lastName
        artist.coverURL = (coverURL != nil) ? coverURL : URL(string: "https://api.lorem.space/image/face")
        artist.songs = []
        
        do {
            try context.save()
            return .success(artist)
        } catch {
            print(error.localizedDescription)
            return .failure(error)
        }

    }
    
    func getAllArtists() -> Result<[Artist], Error> {
        let fetchRequest = Artist.fetchRequest()
        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
        fetchRequest.sortDescriptors = [descriptor]
        
        let context = container.viewContext
        
        do {
            let artists = try context.fetch(fetchRequest)
            return .success(artists)
        } catch {
            return .failure(error)
        }
        
    }
    
}
