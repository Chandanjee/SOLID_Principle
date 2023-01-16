//
//  Agenturs+CoreDataProperties.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 14/01/23.
//
//

import Foundation
import CoreData
import UIKit

public extension Agenturs {

    @nonobjc  class func fetchRequest() -> NSFetchRequest<Agenturs> {
        return NSFetchRequest<Agenturs>(entityName: "Agenturs")
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
    @NSManaged var bookmark: Bool
    
    internal class func createOrUpdate(item: Staff_PickedModel, with stack: CoreDataStack) {
        let newsItemID = item.id
        var currentNewsPost: Agenturs? // Entity name
        let newsPostFetch: NSFetchRequest<Agenturs> = Agenturs.fetchRequest()
        if let newsItemID = newsItemID {
            let newsItemIDPredicate = NSPredicate(format: "%K == %i", #keyPath(Agenturs.idID), newsItemID)
            newsPostFetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [newsItemIDPredicate])
        }
        do {
            let results = try stack.managedContext.fetch(newsPostFetch)
            if results.isEmpty {
                // News post not found, create a new.
                currentNewsPost = Agenturs(context: stack.managedContext)
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

    internal func update(item: Staff_PickedModel) {
        // Title
        self.title = item.title
        self.posterUrl = item.posterUrl
        self.releaseDate = item.releaseDate
        self.rating = item.rating ?? 0.0
        let stringValue = item.genres?.joined(separator: ",")
        self.genres = stringValue
        self.bookmark = item.bookmark ?? false
        self.language = item.language
        self.budget = item.budget?.description
        self.reviews = item.reviews?.description
        self.overview = item.overview
        self.runtime = Int16(item.runtime ?? 0)
        self.revenue = item.revenue?.description
    }
}

extension Agenturs : Identifiable {

}
