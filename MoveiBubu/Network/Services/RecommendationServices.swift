//
//  RecommendationServices.swift
//  MoveiBubu
//
//  Created by obss on 17.06.2022.
//

import Foundation

protocol RecommendationServicesProtocol {
    func getRecommendation(movieid: Int,completion: @escaping (Result<ListResponse, NetworkError>) -> Void)
}

struct RecommendationServices: RecommendationServicesProtocol {
    
    static let shared = RecommendationServices()

    private let network = Network()
    
    func getRecommendation (movieid: Int,completion: @escaping (Result<ListResponse, NetworkError>) -> Void) {
        var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3//movie/\(movieid)/recommendations?api_key=810d980423fb22d55bab5658dcbc18ea&language=en-US")!)
        urlRequest.httpMethod = "GET"
        network.performRequest(request: urlRequest, completion: completion)
        
    }
    
}
