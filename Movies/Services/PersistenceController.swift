//
//  Persistence.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    let container = NSPersistentContainer(name: "Movies")
    let mainContext: NSManagedObjectContext
    
    init() {
        mainContext = container.viewContext
        mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.loadPersistentStores { desc, error in
            if let err = error {
                print("failed to load the data: \(err.localizedDescription)")
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: NSManagedObjectContext.didSaveObjectsNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func contextDidSave(_ notification: Notification) {
            guard let context = notification.object as? NSManagedObjectContext else {
                return
            }
            
            if context != mainContext {
                mainContext.perform {
                    self.mainContext.mergeChanges(fromContextDidSave: notification)
                }
            }
        }
    
    func save(context: NSManagedObjectContext) -> Bool {
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func add(_ movie: Movie, context: NSManagedObjectContext) -> Bool {
        let cdMovie = CDMovie(context: context)
        cdMovie.id = Int32(movie.id)
        cdMovie.title = movie.title
        cdMovie.release_date = movie.release_date
        cdMovie.overview = movie.overview
        return save(context: context)
    }
}
