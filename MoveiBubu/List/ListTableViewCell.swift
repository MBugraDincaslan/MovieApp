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
    var id: Int?
    var movie: ListModel?
    var favorite: Task?
   
    
   
    @IBOutlet weak var backRoundImage: UIImageView!
    

    @IBOutlet weak var movieImageView: UIImageView!{
        didSet {
            movieImageView.layer.cornerRadius = 60
        }
    }
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var raitingLabel: UILabel!
    
    func favConfigure (movie: Task) {
        let str = movie.poster_path
        let imageURL: URL = URL(string: "\(baseImageURL)\(str)")! 
     
        movieImageView.kf.setImage(with: imageURL)
        
        movieNameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        raitingLabel.text = "IMDB: \(String(movie.vote_average))"
        
        //read fonksiyonu çağıracak
        //indexpathrow.id
        //array search
        
        favorite = movie
        
        id = movie.id
        
        checkStatus(Status: true)
        
    }
    
    func configure (movie: ListModel) {
        
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
        id = movie.id
        self.movie = movie
        checkStatus(Status: DataMngr.sharedData.checkFavorites(check: id))
        
    }
    
    
    
    @IBOutlet weak var FavoriteState: UIButton!
    
    func checkStatus (Status: Bool) {
        if Status {
            FavoriteState.setImage(UIImage(systemName: "star.fill"), for: UIControl.State.normal)
            FavoriteState.tintColor = UIColor.systemYellow
        } else {
            FavoriteState.setImage(UIImage(systemName: "star"), for: UIControl.State.normal)
            FavoriteState.tintColor = UIColor.systemYellow
        }
    }
    
        @IBAction func FavoriteButton(_ sender: Any) {
       if let movie = movie {
           if let Id = id {
        let isFavorites = DataMngr.sharedData.UpdateFavorites(id: Id, title: movie.title ?? "", release_date: movie.release_date ?? "", poster_path: movie.poster_path ?? "", vote_average: movie.vote_average ?? 0)
              checkStatus(Status: isFavorites)
               
           }
           
       } else if let favorite = favorite {
           DataMngr.sharedData.DeleteFavorites(movie: favorite)
           checkStatus(Status: false)
           
       }
            
        }
    
}

