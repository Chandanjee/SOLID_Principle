//
//  Bookmarks+CoreDataProperties.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 15/01/23.
//
//

import Foundation
import CoreData


extension Bookmarks {
    
    @nonobjc  class func fetchRequest() -> NSFetchRequest<Bookmarks> {
        return NSFetchRequest<Bookmarks>(entityName: "Bookmarks")
    }

    @NSManaged  var idID: Int32
    @NSManaged  var genres: String?
    @NSManaged  var language: String?
    @NSManaged  var budget: String?
    @NSManaged  var reviews: String?
    @NSManaged  var overview: String?
    @NSManaged  var title: String?
    @NSManaged  var runtime: Int16
    @NSManaged  var posterUrl: String?
    @NSManaged  var releaseDate: String?
    @NSManaged  var revenue: String?
    @NSManaged  var rating: Double
    @NSManaged  var bookmark: Bool

    internal class func createOrUpdatesBookmark(item: Movie_Model, with stack: CoreDataStack) {
        let newsItemID = item.id
        var currentNewsPost: Bookmarks? // Entity name
        let newsPostFetch: NSFetchRequest<Bookmarks> = Bookmarks.fetchRequest()
        if let newsItemID = newsItemID {
            let newsItemIDPredicate = NSPredicate(format: "%K == %i", #keyPath(Bookmarks.idID), newsItemID)
            newsPostFetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [newsItemIDPredicate])
        }
        do {
            let results = try stack.managedContext.fetch(newsPostFetch)
            if results.isEmpty {
                // News post not found, create a new.
                currentNewsPost = Bookmarks(context: stack.managedContext)
                if let postID = newsItemID {
                    currentNewsPost?.idID = Int32(postID)
                }
            } else {
                // News post found, use it.
                currentNewsPost = results.first
            }
            currentNewsPost?.update(item: item)
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }

    internal func update(item: Movie_Model) {
        // Title
        self.title = item.title
        self.posterUrl = item.posterUrl
        self.releaseDate = item.releaseDate
        self.rating = item.rating ?? 0.0
        let stringValue = item.genres?.joined(separator: ",")
        self.genres = stringValue
        self.bookmark = item.bookmark ?? true
        self.language = item.language
        self.budget = item.budget?.description
        self.reviews = item.reviews?.description
        self.overview = item.overview
        self.runtime = Int16(item.runtime ?? 0)
        self.revenue = item.revenue?.description
    }
    
    internal class func deleteData(item: Movie_Model, with stack: CoreDataStack) -> Bool{
        let newsItemID = item.id

        var noteEntity: Bookmarks? // Entity name
        let fetchRequest: NSFetchRequest<Bookmarks> = Bookmarks.fetchRequest()

        if let newsItemID = newsItemID {
            let newsItemIDPredicate = NSPredicate(format: "idID = %i", newsItemID)
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [newsItemIDPredicate])
        }
        do {
            let results = try stack.managedContext.fetch(fetchRequest)
                // News post not found, create a new.
                    for item in results{
                        stack.managedContext.delete(item)
                        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()

                    }
            
        }catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }

            //Code to Fetch New Data From The DB and Reload Table.
//        let fetchRequest: NSFetchRequest<Bookmarks> = Bookmarks.fetchRequest()

            do {
                try stack.managedContext.save()
                return true
//                let  notes = try stack.managedContext.fetch(fetchRequest) as! [Movie_Model]
            } catch let error as NSError {
                print("Error While Fetching Data From DB: \(error.userInfo)")
            }
        return false
    }
}

extension Bookmarks : Identifiable {

}
