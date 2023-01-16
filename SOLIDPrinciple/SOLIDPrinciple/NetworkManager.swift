//
//  NetworkManager.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 13/01/23.
//

import Foundation
import UIKit

enum errors:Error{
    case badUrl
    case noNadat
    case decodingError
}

//MARK: Single Resposibility principle
class NetworkManager{
    var aPIHandler:APIHandler
    var responseHandler:ResponseHandler
    init(aPIHandler:APIHandler = APIHandler(), responseHandler:ResponseHandler = ResponseHandler()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
    func fetchRequest<T: Codable>(type: T.Type, url: URL, completion: @escaping(Result<T, errors>) -> Void){
//    func getComment(completeion: @escaping(Result<[CommentModel],errors>) -> Void){ // This was restrict the open close principle so i have created concept of generic. if i will not create generic then voileting open close principle.
        aPIHandler.fetchData(url: url){ result in
            switch result{
            case .success(let data):
                self.responseHandler.fetchModel(type: type, data: data){
                    decodeResult in
                    switch decodeResult{
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
            
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

class APIHandler:APIHandleDelegate{
    func fetchData(url:URL, completion:@escaping(Result<Data,errors>) -> Void){
        URLSession.shared.dataTask(with: url){
            data,response,error in
            guard let data = data, error == nil else{
                return completion(.failure(.noNadat))
            }
            completion(.success(data))
        }.resume()
    }
}
class ResponseHandler:ResponseHandlerDelegate{
//    func fetchRequest(data:Data,completion: @escaping(Result<[CommentModel],errors>) -> Void){
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, errors>) -> Void)
    {
        let common = try? JSONDecoder().decode(type.self, from: data)
        if let commonRes = common{
            return completion(.success(commonRes))
        }else{
            return completion(.failure(.decodingError))
        }
    }
}

//MARK: Dependency Inversion principle

protocol APIHandleDelegate{
//    func fetchRequest(url:URL, completion:@escaping(Result<Data,errors>) -> Void)
    func fetchData(url: URL, completion: @escaping(Result<Data, errors>) -> Void)

}

protocol ResponseHandlerDelegate{
//    func fetchRequest(data:Data,completion: @escaping(Result<[CommentModel],errors>) -> Void)
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, errors>) -> Void)

}
