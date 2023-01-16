//
//  CommentViewModel.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 13/01/23.
//

import Foundation

//class CommentViewModel: ObservableObject{
//    let serviceHandler: CommentViewServiceDelegate
//    let databaseHandler: CommentsDelegate
//    init(serviceHandler: CommentViewServiceDelegate, databaseHandler: CommentsDelegate) {
//        self.serviceHandler = serviceHandler
//        self.databaseHandler = databaseHandler
//    }
//
//    @Published var comments = [CommentModel]()

class CommentViewModel {
    var comments : [CommentModel] = []
    func fetchComment(){
        CommentViewService().getComments {
            result in
            switch result{
            case.success(let cokmment):
                self.comments = cokmment
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getusers(){
        CommentViewService().fetchUsers{
//        serviceHandler.fetchUsers{
            result in
            switch result{
            case .success(let model):
                print("New user")
            case.failure(let error):
                print(error)
            }
        }
    }
}
