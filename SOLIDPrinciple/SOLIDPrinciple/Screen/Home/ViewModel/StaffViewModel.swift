//
//  StaffViewModel.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 14/01/23.
//

import Foundation
import CoreData

class StaffViewModel{
    
    var staff_Picked : [Staff_PickedModel] = []
    var staff_Model_one = Staff_PickedModel()

    var movie_Model : [Movie_Model] = []
    var movie_Model_one = Movie_Model()

    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    var dataHandler: ((_ data: [Staff_PickedModel]) -> Void)?
    func fetchStaffAPI(){
        getAll()
        if staff_Picked.count > 0{
            print("Total Movie",movie_Model.count)
        }else{
            CommonViewService().getStaffList {
                result in
                switch result{
                case.success(let cokmment):
                    self.staff_Picked = cokmment
                    self.dataHandler?(self.staff_Picked)
                    self.eventHandler?(.dataLoaded)
                    self.processFectchedMovies(datas: self.staff_Picked)
                case .failure(let error):
                    print(error)
                    self.eventHandler?(.error(error))
                }
            }
        }
    }
    
    func getAll() {
        let noteFetch: NSFetchRequest<Agenturs> = Agenturs.fetchRequest()
        let sortByDate = NSSortDescriptor(key: #keyPath(Agenturs.idID), ascending: false)
        noteFetch.sortDescriptors = [sortByDate]
        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try managedContext.fetch(noteFetch)
            for items in results{
                staff_Model_one.id = Int(items.idID)
                staff_Model_one.rating = items.rating
                staff_Model_one.revenue = Int(items.revenue ?? "")
                staff_Model_one.releaseDate = items.releaseDate
                staff_Model_one.posterUrl = items.posterUrl
                staff_Model_one.runtime = Int(items.runtime)
                staff_Model_one.title = items.title
                staff_Model_one.overview = items.overview
                staff_Model_one.reviews = Int(items.reviews ?? "")
                staff_Model_one.budget = Int(items.budget ?? "")
                staff_Model_one.language = items.language
                staff_Model_one.bookmark = items.bookmark
                let arraItem =  items.genres?.components(separatedBy: ",")
                staff_Model_one.genres = arraItem
                staff_Picked.append(staff_Model_one)
            }
            print("staff Movie",staff_Picked.count)
            if staff_Picked.count > 0{
                self.dataHandler?(staff_Picked)
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    func processFectchedMovies(datas: [Staff_PickedModel]) {
        for item in datas {
            Agenturs.createOrUpdate(item: item, with: AppDelegate.sharedAppDelegate.coreDataStack)
        }
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
       
    }
    
    func processAddBookMarkMovies(datas: Staff_PickedModel) {
            Agenturs.createOrUpdate(item: datas, with: AppDelegate.sharedAppDelegate.coreDataStack)
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
       
    }
    
    func convertModel(currentModel:Staff_PickedModel) -> Movie_Model{
        var bookMarkData = Movie_Model()
        bookMarkData.id = currentModel.id
        bookMarkData.rating = currentModel.rating
        bookMarkData.revenue = currentModel.revenue
        bookMarkData.releaseDate = currentModel.releaseDate
        bookMarkData.posterUrl = currentModel.posterUrl
        bookMarkData.runtime = currentModel.runtime
        bookMarkData.title = currentModel.title
        bookMarkData.overview = currentModel.overview
        bookMarkData.reviews = currentModel.reviews
        bookMarkData.budget = currentModel.budget
        bookMarkData.language = currentModel.language
        bookMarkData.bookmark = currentModel.bookmark
        bookMarkData.genres = currentModel.genres
        bookMarkData.bookmark = currentModel.bookmark
        
        return bookMarkData
    }
}
extension StaffViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
