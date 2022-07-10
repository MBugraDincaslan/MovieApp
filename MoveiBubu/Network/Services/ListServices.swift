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
        /*var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=810d980423fb22d55bab5658dcbc18ea&language=en-US&page=\(page)")!)*/
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/popular"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "810d980423fb22d55bab5658dcbc18ea"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page)")]
        if let url = components.url {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            network.performRequest(request: urlRequest, completion: completion)
        }
        
        
        
    }
    
    func getSearch(moon: String, completion: @escaping (Result<ListResponse, NetworkError>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/search/movie"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "810d980423fb22d55bab5658dcbc18ea"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "query", value: moon)]
        
        if let url = components.url {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            network.performRequest(request: urlRequest, completion: completion)
        }
        

}

}
