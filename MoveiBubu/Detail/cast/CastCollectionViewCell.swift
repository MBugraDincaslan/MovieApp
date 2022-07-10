//
//  CastCollectionViewCell.swift
//  MoveiBubu
//
//  Created by obss on 16.06.2022.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {
    
    private let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    func configureRecomm (movie: ListModel) {
        
        characterLabel.isHidden = true
        
        if let posterPath = movie.poster_path {
            
            if let imageURL: URL = URL(string: "\(baseImageURL)\(posterPath)") {
                
                imageView.kf.setImage(with: imageURL)
                
            } else {
                
                imageView.image = nil
                
            }
            
        } else {
            
            imageView.image = nil
            
        }
        
        nameLabel.text = movie.title
        
    }
    
    func configure (casting: creditsModel) {
        
        if let posterPath = casting.profile_path{
            
            if let imageURL: URL = URL(string: "\(baseImageURL)\(posterPath)") {
                
                imageView.kf.setImage(with: imageURL)
                
            } else {
                
                imageView.image = nil
                
            }
            
        } else {
            
            imageView.image = nil
            
        }
        
        nameLabel.text = casting.name
        
        characterLabel.text = casting.character
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
