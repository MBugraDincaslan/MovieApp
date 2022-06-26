//
//  Data.swift
//  MoveiBubu
//
//  Created by obss on 22.06.2022.
//

import Foundation
import RealmSwift

class Task: Object {
    
    dynamic var id: Int?
    dynamic var title: String? = ""
    dynamic var releaseDate: String? = ""
    dynamic var poster_path: String? = ""
    dynamic var vote_average: Double? = 0



}
