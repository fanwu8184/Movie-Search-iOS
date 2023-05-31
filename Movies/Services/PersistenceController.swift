//
//  Persistence.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import CoreData

class PersistenceController: ObservableObject {
    static let shared = PersistenceController()
    let container = NSPersistentContainer(name: "Movies")
    let mainContext: NSManagedObjectContext
    @Published var error: Error? = nil
    
    init() {
        mainContext = container.viewContext
        mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.loadPersistentStores { [weak self] desc, err in
            if let e = err {
                print(e)
            }
            self?.error = PersistenceError.failSetup
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
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error)
            DispatchQueue.main.async { [weak self] in
                self?.error = PersistenceError.failSave
            }
        }
    }
    
    func add(_ movie: Movie, context: NSManagedObjectContext) {
        let cdMovie = CDMovie(context: context)
        cdMovie.id = Int32(movie.id)
        cdMovie.title = movie.title
        cdMovie.release_date = movie.release_date
        cdMovie.poster_path = movie.poster_path
        cdMovie.overview = movie.overview
        save(context: context)
    }
}
