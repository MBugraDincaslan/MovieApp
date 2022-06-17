//
//  CreditsServices.swift
//  MoveiBubu
//
//  Created by obss on 16.06.2022.
//

import Foundation
protocol CreditsServicesProtocol {
    func getCredits(movieid: Int,completion: @escaping (Result<creditsModel, NetworkError>) -> Void)
}

struct CreditsServices: CreditsServicesProtocol {


    private let network = Network()
    
    func getCredits (movieid: Int,completion: @escaping (Result<creditsModel, NetworkError>) -> Void) {
        var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(movieid)/credits?api_key=810d980423fb22d55bab5658dcbc18ea&language=en-US")!)
        urlRequest.httpMethod = "GET"
        network.performRequest(request: urlRequest, completion: completion)
        
 
    }
    
}
