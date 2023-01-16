//
//  CommentViewService.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 13/01/23.
//

import Foundation

//https://apps.agentur-loop.com/challenge/staff_picks.json

//https://apps.agentur-loop.com/challenge/movies.json

// https://jsonplaceholder.typicode.com/comments

// https://jsonplaceholder.typicode.com/user
protocol CommentViewServiceDelegate:CommentsDelegate,UsersDelegate{
    
}
//MARK: Liskov Substitution Principle: using below two protocoll we achive this principle. becuase functionality should shuld not brake in this child class which inpment parent class.
protocol UsersDelegate{
//    func getComments(completion: @escaping (Result<[CommentModel], errors>) -> Void) 

    func fetchUsers(completion: @escaping(Result<UserModel, errors>) -> Void)
}
protocol CommentsDelegate{
    func getComments(completion: @escaping(Result<[CommentModel], errors>) -> Void)
//    func fetchUsers(completion: @escaping(Result<UserModel, errors>) -> Void)

}

class CommentViewService:CommentViewServiceDelegate{
    func getComments(completion: @escaping (Result<[CommentModel], errors>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments") else {
            return completion(.failure(.badUrl))
        }
        NetworkManager().fetchRequest(type: [CommentModel].self, url: url, completion: completion)

    }
    
    func fetchUsers(completion: @escaping (Result<UserModel, errors>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/user") else {
            return completion(.failure(.badUrl))
        }
        NetworkManager().fetchRequest(type: UserModel.self, url: url, completion: completion)

    }
    
    
}
