//
//  DataMngr.swift
//  MoveiBubu
//
//  Created by obss on 26.06.2022.
//

import Foundation
import RealmSwift


struct DataMngr {
    
    static let sharedData = DataMngr()
    
    private var realm: Realm {
        do {
            let realm = try Realm()
            return realm
            
        } catch {
            print("Error initalising new realm, \(error)")
            
        }
        return self.realm
        
    }
    func UpdateFavorites(id: Int, title: String = "", release_date: String = "", poster_path: String = "", vote_average: Double = 0) -> Bool {
        if let movie = realm.object(ofType: Task.self, forPrimaryKey: id) {
            DeleteFavorites(movie: movie)
            return false
        } else {
            AddFavorites(id: id, title: title, release_date: release_date, poster_path: poster_path, vote_average: vote_average)
            return true
        }
            
    }
    func DeleteFavorites(movie: Task) {
        do {
            try realm.write {
                realm.delete(movie)
            }
        } catch {
            print("Deleted ERROR!\(error)")
            
        }
        
    }

    func AddFavorites(id: Int, title: String, release_date: String, poster_path: String, vote_average: Double) {
        
        let data = Task()
        data.id = id
        data.title = title
        data.releaseDate = release_date
        data.vote_average = vote_average
        data.poster_path = poster_path
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("ERROR!\(error)")
            
        }
        
    }
    func arrayFavaorites() -> [Task] {
        let favorites = realm.objects(Task.self)
        /*print("data mgr print\(Array(favorites))")*/
            return Array(favorites)
        
    }
    func checkFavorites(check: Int?) -> Bool {
        if let _ = realm.object(ofType: Task.self, forPrimaryKey: check) {
            return true
        } else {
            return false
            
        }
        
    }
    
}
    




