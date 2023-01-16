//
//  StaffViewService.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 14/01/23.
//

import Foundation

protocol CommonViewServiceDelegate:CommonStaffDelegate,CommonMovieDelegate{
    
}

protocol CommonMovieDelegate{
    func fetchMovie(completion: @escaping(Result<[Movie_Model], errors>) -> Void)
}
protocol CommonStaffDelegate{
    func getStaffList(completion: @escaping(Result<[Staff_PickedModel], errors>) -> Void)
}

class CommonViewService:CommonViewServiceDelegate{
    func getStaffList(completion: @escaping (Result<[Staff_PickedModel], errors>) -> Void) {
        let urlString = Constant.API.baseURL + "movies.json"
        guard let url = URL(string: urlString) else {
            return completion(.failure(.badUrl))
        }
        NetworkManager().fetchRequest(type: [Staff_PickedModel].self, url: url, completion: completion)
    }
    
    func fetchMovie(completion: @escaping (Result<[Movie_Model], errors>) -> Void) {
        let urlString = Constant.API.baseURL + "staff_picks.json"

        guard let url = URL(string: urlString) else {
            return completion(.failure(.badUrl))
        }
        NetworkManager().fetchRequest(type: [Movie_Model].self, url: url, completion: completion)

    }
    
    
}
