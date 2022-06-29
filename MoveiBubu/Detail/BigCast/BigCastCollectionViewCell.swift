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
        
      
        nameLabel.text = bigcast.name
        birthdayLabel.text = bigcast.birthday
        deathdayLabel.text = bigcast.deathday
        birthPlaceLabel.text = bigcast.place_of_birth
        biographyLabel.text = bigcast.biography
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
