//
//  ListServices.swift
//  MoveiBubu
//
//  Created by obss on 15.06.2022.
//

import Foundation

protocol ListServicesProtocol {
    func getSearch(moon: String, completion: @escaping (Result<ListResponse, NetworkError>) -> Void)
    func getAllList(page: Int, completion: @escaping (Result<ListResponse, NetworkError>) -> Void)
    
}

struct ListServices: ListServicesProtocol {
    private let network = Network()
    
    func getAllList(page: Int, completion: @escaping (Result<ListResponse, NetworkError>) -> Void) {
        var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=810d980423fb22d55bab5658dcbc18ea&language=en-US&page=\(page)")!)
        urlRequest.httpMethod = "GET"
        network.performRequest(request: urlRequest, completion: completion)
        
    }
    
    func getSearch(moon: String, completion: @escaping (Result<ListResponse, NetworkError>) -> Void) {
        var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=810d980423fb22d55bab5658dcbc18ea&query=\(moon)")!)
        urlRequest.httpMethod = "GET"
        network.performRequest(request: urlRequest, completion: completion)
        
    }

}

