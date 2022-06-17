//
//  DetailModel.swift
//  MoveiBubu
//
//  Created by obss on 15.06.2022.
//

import Foundation

struct DetailModel: Codable {
    
    let poster_path: String?
    let title: String?
    let original_language: String?
    let original_title: String?
    let release_date: String?
    let budget: Int?
    let revenue: Int?
    let genres: [Genres]?
    let overview: String?
    let runtime: Int?
    let production_companies: [Production_Companies]?
    let homepage: String?
    var vote_average: Double?
    
}

struct Genres: Codable {
    let id: Int?
    let name: String?
}

struct Production_Companies: Codable {
    let name: String?
    let id: Int?
    let logo_path: String?
    let origin_country: String
}

 

