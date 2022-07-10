//
//  BigCastServices.swift
//  MoveiBubu
//
//  Created by obss on 20.06.2022.
//

import Foundation
protocol BigCastServicesProtocol {
    func getBigCast(personid: Int,completion: @escaping (Result<castModel, NetworkError>) -> Void)
}

struct BigCastServices: BigCastServicesProtocol {
    
    static let shared = BigCastServices()

    private let network = Network()
    
    func getBigCast (personid: Int,completion: @escaping (Result<castModel, NetworkError>) -> Void) {
        /*var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/person/\(personid)?api_key=810d980423fb22d55bab5658dcbc18ea&language=en-US")!)
        urlRequest.httpMethod = "GET"
        network.performRequest(request: urlRequest, completion: completion)*/
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/person/\(personid)"
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
