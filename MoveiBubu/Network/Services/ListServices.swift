//
//  ListServices.swift
//  MoveiBubu
//
//  Created by obss on 15.06.2022.
//

import Foundation

protocol ListServicesProtocol {
    func getAllList(completion: @escaping (Result<ListResponse, NetworkError>) -> Void)
    func getListModel(id: Int,completion: @escaping (Result<ListModel, NetworkError>) -> Void)
}

struct ListServices: ListServicesProtocol {


    private let network = Network()
    
    func getAllList(completion: @escaping (Result<ListResponse, NetworkError>) -> Void) {
        var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=810d980423fb22d55bab5658dcbc18ea&language=en-US&page=1")!)
        urlRequest.httpMethod = "GET"
        network.performRequest(request: urlRequest, completion: completion)
        
 
    }
    
  func getListModel(id: Int,completion: @escaping (Result<ListModel, NetworkError>) -> Void) {
        var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=810d980423fb22d55bab5658dcbc18ea&language=en-US&page=1")!)
        urlRequest.httpMethod = "GET"
      network.performRequest(request: urlRequest, completion: completion)
    
    
   }
    
}

