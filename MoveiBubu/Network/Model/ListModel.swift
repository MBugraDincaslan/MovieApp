//
//  ListModel.swift
//  MoveiBubu
//
//  Created by obss on 15.06.2022.
//


import Foundation


struct ListModel: Codable {
    
    let id: Int?
    let poster_path: String?
    let title: String?
    let release_date: String?
    var vote_average: Double?
    let backdrop_path: String?
    
}
