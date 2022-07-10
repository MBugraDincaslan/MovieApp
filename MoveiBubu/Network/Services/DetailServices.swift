//
//  DetailServices.swift
//  MoveiBubu
//
//  Created by obss on 15.06.2022.
//

import Foundation



protocol DetailServicesProtocol {
    func getDetail(movieid: Int,completion: @escaping (Result<DetailModel, NetworkError>) -> Void)
    
}

struct DetailServices: DetailServicesProtocol {
    
    private let network = Network()
    
    func getDetail (movieid: Int,completion: @escaping (Result<DetailModel, NetworkError>) -> Void) {
        /*var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(movieid)?api_key=810d980423fb22d55bab5658dcbc18ea&language=en-US")!)
        urlRequest.httpMethod = "GET"
        network.performRequest(request: urlRequest, completion: completion)*/
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/\(movieid)"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "810d980423fb22d55bab5658dcbc18ea"),
            URLQueryItem(name: "language", value: "en-US")]
        if let url = components.url {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            network.performRequest(request: urlRequest, completion: completion)
        
        
    }
    
}
 

}
