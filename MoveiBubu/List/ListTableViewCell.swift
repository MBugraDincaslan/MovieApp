//
//  ListTableViewCell.swift
//  MoveiBubu
//
//  Created by obss on 15.06.2022.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {
    


    private let baseImageURL = "https://image.tmdb.org/t/p/original"
   
    
   
    @IBOutlet weak var backRoundImage: UIImageView!
    

    @IBOutlet weak var movieImageView: UIImageView!{
        didSet {
            movieImageView.layer.cornerRadius = 60
        }
    }
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var raitingLabel: UILabel!
    
    func configure (movie: ListModel){
        /*let lastUrl = baseURL + "\(String(describing:movie.id))" + "/" + "\(String(describing: movie.poster_path))"
        let url = URL(string: lastUrl)*/
        if let backPath = movie.backdrop_path {

                    if let imageURL: URL = URL(string: "\(baseImageURL)\(backPath)") {

                        backRoundImage.kf.setImage(with: imageURL)

                    } else {

                        backRoundImage.image = nil

                    }

                } else {

                    backRoundImage.image = nil

                }
        if let posterPath = movie.poster_path {

                    if let imageURL: URL = URL(string: "\(baseImageURL)\(posterPath)") {

                        movieImageView.kf.setImage(with: imageURL)

                    } else {

                        movieImageView.image = nil

                    }

                } else {

                    movieImageView.image = nil

                }
      
        movieNameLabel.text = movie.title
        releaseDateLabel.text = movie.release_date
        if let rait = movie.vote_average {
            raitingLabel.text = "IMDB: \(String(rait))"
            
        }
        
      
    }
    
    
    

    @IBAction func FavoriteButton(_ sender: Any) {
        
        

    }
  /*  func backrounds (movie: ListModel) {
        if let cellBackgroundView = movie.backdrop_path {
            if let imageURL: URL = URL(string: "\(baseImageURL)\(cellBackgroundView)") {

                cellBackgroundView.kf.(with: imageURL)
            } else {

                movieImageView.image = nil

            }

        } else {

            movieImageView.image = nil

        }
            
         */
    
    
}

