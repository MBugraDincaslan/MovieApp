//
//  BigCastCollectionViewCell.swift
//  MoveiBubu
//
//  Created by obss on 20.06.2022.
//

import UIKit

class BigCastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var deathdayLabel: UILabel!
    @IBOutlet weak var birthPlaceLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
   
    private let baseImageURL = "https://api.themoviedb.org/3/person/"
   
    
    func configure (bigcast: castModel) {
        
        if let posterPath = bigcast.profile_path {
            
            if let imageURL: URL = URL(string: "\(baseImageURL)\(posterPath)") {
                
                imageView.kf.setImage(with: imageURL)
                
            } else {
                
                imageView.image = nil
                
            }
            
        } else {
            
            imageView.image = nil
            
        }
        if let name = bigcast.name {
            nameLabel.text = name
        } else {
            nameLabel.text = nil
        }
        if let birthday = bigcast.birthday {
            birthdayLabel.text = birthday
        } else {
            birthdayLabel.text = nil
        }
        if let deathday = bigcast.deathday {
            deathdayLabel.text = deathday
        } else {
            deathdayLabel.text = nil
        }
        if let birthPlace = bigcast.place_of_birth {
            birthPlaceLabel.text = birthPlace
        } else {
            birthPlaceLabel.text = nil
        }
        if let biography = bigcast.biography {
            biographyLabel.text = biography
        } else {
            biographyLabel.text = nil
        }
        
        
    }
    
    
   
}
