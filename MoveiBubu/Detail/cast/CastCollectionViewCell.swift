//
//  CastCollectionViewCell.swift
//  MoveiBubu
//
//  Created by obss on 16.06.2022.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {
    
    private let baseImageURL = "https://image.tmdb.org/t/p/original"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    func configure (casting: castModel){
        /*let lastUrl = baseURL + "\(String(describing:movie.id))" + "/" + "\(String(describing: movie.poster_path))"
        let url = URL(string: lastUrl)*/
        if let posterPath = casting.profile_path {

                    if let imageURL: URL = URL(string: "\(baseImageURL)\(posterPath)") {

                        imageView.kf.setImage(with: imageURL)

                    } else {

                        imageView.image = nil

                    }

                } else {

                    imageView.image = nil

                }
       
      
        movieNameLabel.text = movie.title
        releaseDateLabel.text = movie.release_date
        if let rait = movie.vote_average {
            raitingLabel.text = "IMDB: \(String(rait))"
            
        }
        
      
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
