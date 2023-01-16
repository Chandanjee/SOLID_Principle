//
//  BookmarkViewModel.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 15/01/23.
//

import Foundation
import CoreData
class BookmarkViewModel{
    
    var movie_Model : [Movie_Model] = []
    var movie_Model_one = Movie_Model()
    var dataHandlerBookmark: ((_ data: [Movie_Model]) -> Void)?
    func getDataBookmark(){
        getAllBookmark()

        if movie_Model.count == 0{
            CommonViewService().fetchMovie {
                result in
                switch result{
                case.success(let cokmment):
                    self.movie_Model = cokmment
                    self.dataHandlerBookmark?(self.movie_Model)
                    self.processFectchedBookmark(datas: self.movie_Model)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    
    func getAllBookmark() {
        let noteFetch: NSFetchRequest<Bookmarks> = Bookmarks.fetchRequest()
        let sortByDate = NSSortDescriptor(key: #keyPath(Bookmarks.idID), ascending: false)
        noteFetch.sortDescriptors = [sortByDate]
        movie_Model = []

        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try managedContext.fetch(noteFetch)
            for items in results{
                movie_Model_one.id = Int(items.idID)
                movie_Model_one.rating = items.rating
                movie_Model_one.revenue = Int(items.revenue ?? "")
                movie_Model_one.releaseDate = items.releaseDate
                movie_Model_one.posterUrl = items.posterUrl
                movie_Model_one.runtime = Int(items.runtime)
                movie_Model_one.title = items.title
                movie_Model_one.overview = items.overview
                movie_Model_one.reviews = Int(items.reviews ?? "")
                movie_Model_one.budget = Int(items.budget ?? "")
                movie_Model_one.language = items.language
                movie_Model_one.bookmark = items.bookmark
                let arraItem =  items.genres?.components(separatedBy: ",")
                movie_Model_one.genres = arraItem
                if !movie_Model.contains(where: {$0.id == Int(items.idID) }) {
                    movie_Model.append(movie_Model_one)
                       }
            }
            print("Book Movie",movie_Model.count)
            if movie_Model.count > 0{
                self.dataHandlerBookmark?(movie_Model)
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    func processFectchedBookmark(datas: [Movie_Model]) {
        for item in datas {
            Bookmarks.createOrUpdatesBookmark(item: item, with: AppDelegate.sharedAppDelegate.coreDataStack)
        }
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
       
    }
    func processFectchedBookmark_One(datas: Movie_Model,isBoomark:Bool = false) -> Bool{
            Bookmarks.createOrUpdatesBookmark(item: datas, with: AppDelegate.sharedAppDelegate.coreDataStack)
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
        if isBoomark{
            getAllBookmark()
            return true
        }else
        {
            return false
        }
       
    }
    func processDeleteBookmark_One(datas: Movie_Model,isBoomark:Bool = false) -> Bool{
          let status =  Bookmarks.deleteData(item: datas, with: AppDelegate.sharedAppDelegate.coreDataStack)
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
        if status {
            getAllBookmark()
            return true
        }else{
            return false
        }
    }
}


