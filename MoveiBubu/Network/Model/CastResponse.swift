//
//  CastResponse.swift
//  MoveiBubu
//
//  Created by obss on 17.06.2022.
//

import Foundation

struct CastResponse: Codable {
    let id: Int?
    let cast: [castModel]?
}
