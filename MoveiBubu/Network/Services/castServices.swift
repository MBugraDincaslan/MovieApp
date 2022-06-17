//
//  castServices.swift
//  MoveiBubu
//
//  Created by obss on 16.06.2022.
//

import Foundation
protocol CastServicesProtocol {
    func getCast(movieid: Int,completion: @escaping (Result<creditsResponse, NetworkError>) -> Void)
}

struct CastServices: CastServicesProtocol {


    private let network = Network()
    
    func getCast (movieid: Int,completion: @escaping (Result<creditsResponse, NetworkError>) -> Void) {
        var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(movieid)credits?api_key=810d980423fb22d55bab5658dcbc18ea&language=en-US")!)
        urlRequest.httpMethod = "GET"
        network.performRequest(request: urlRequest, completion: completion)
        
 
    }
    
}
