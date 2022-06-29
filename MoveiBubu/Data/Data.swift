//
//  Data.swift
//  MoveiBubu
//
//  Created by obss on 22.06.2022.
//

import Foundation
import RealmSwift

class Task: Object {
    
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var title: String = ""
    @Persisted var releaseDate: String = ""
    @Persisted var poster_path: String = ""
    @Persisted var vote_average: Double = 0

}
