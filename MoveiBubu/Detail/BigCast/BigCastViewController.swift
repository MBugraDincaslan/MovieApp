//
//  BigCastViewController.swift
//  MoveiBubu
//
//  Created by obss on 23.06.2022.
//

import UIKit
import Kingfisher

class BigCastViewController: UIViewController {

    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castStackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birtdayLabel: UILabel!
    @IBOutlet weak var birthPlaceLabel: UILabel!
    @IBOutlet weak var deathDayLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    
    private let bigcastservices: BigCastServicesProtocol = BigCastServices()
    private var cast: castModel?
    var id : Int?
   // private let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
     
        getBigCast()
    
    }
    
    func configure() {
        if let character = cast {
            castImageView.getImage(path: character.profile_path)
            if let name = character.name {
                nameLabel.text = "NAME: \(String(name))"
            } else {
                nameLabel.text = nil
                
            }
            if let birtday = character.birthday {
                birtdayLabel.text = "BIRTHDAY: \(String(birtday))"
            } else {
                birtdayLabel.text = nil
            }
            if let birthplace = character.place_of_birth {
                birthPlaceLabel.text = "BIRTHPLACE: \(String(birthplace))"
            } else {
                birthPlaceLabel.text = nil
            }
            if let deathday = character.deathday {
                deathDayLabel.text = "DEATHDAY: \(String(deathday))"
            } else {
                deathDayLabel.text = nil
            }
            if let biograpy = character.biography {
                if biograpy != "" {
                    biographyLabel.text = "BIOGRAPY: \(String(biograpy))"
                } else {
                    biographyLabel.text = nil
                }
                
            } else {
                biographyLabel.text = nil
            }
            
        }
        
    }
    
    func getBigCast() {
        if let castid = id {
            BigCastServices.shared.getBigCast(personid: castid) {
                result in
                switch result {
                case .success(let response):
                    self.cast = response
                    self.configure()
                case .failure(let error):
                    print(error)
                    }
                }
            }
        }
}
