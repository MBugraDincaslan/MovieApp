//
//  DetailViewController.swift
//  MoveiBubu
//
//  Created by obss on 15.06.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var firstView: UIView!
    @IBOutlet weak var firstScrollView: UIScrollView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var homepageLink: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var secondStackView: UILabel!
    @IBOutlet weak var thirdView: UIView!
    
   
    
    @IBOutlet weak var raitingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orginalTitleLabel: UILabel!
    @IBOutlet weak var orginalLanguageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var productionCompaniesLabel: UILabel!
    
    @IBOutlet weak var castStackView: UIStackView!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!{
    didSet {
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        castCollectionView.register(UINib(nibName: String(describing: CastCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CastCollectionViewCell.self))
        
        
        }
    }
    @IBOutlet weak var castCollectionViewCell: UICollectionViewCell!
    
    @IBOutlet weak var companiesStackLabel: UIStackView!
    
    @IBOutlet weak var recommStackView: UIStackView!
    @IBOutlet weak var recommLabel: UILabel!
    @IBOutlet weak var recommCollectionView: UICollectionView!
    @IBOutlet weak var recommCollectionViewCell: UICollectionViewCell!
    
    
    
    
    
    private let detailServices: DetailServicesProtocol = DetailServices()
    private var details: DetailModel?
    private let baseImageURL = "https://image.tmdb.org/t/p/original"
    var id : Int?
    
    override func viewDidLoad() {
        getDetails()
        
        
    
    }
    
    
    func configure (){
       
        if let movie = details {
            if let name = movie.title{
                nameLabel.text = "TITLE: \(String(name))"
                
            }
            if let image = movie.poster_path {
                if let posterPath = movie.poster_path {

                            if let imageURL: URL = URL(string: "\(baseImageURL)\(posterPath)") {

                                imageView.kf.setImage(with: imageURL)

                            } else {

                                imageView.image = nil

                            }

                        } else {

                            imageView.image = nil

                        }
            }
            
            if let otitle = movie.original_title {
                orginalTitleLabel.text = "ORGINAL TITLE: \(String(otitle))"
            }
            if let olanguage = movie.original_language {
                orginalLanguageLabel.text = "ORIGINAL LANGUAGE: \(String(olanguage))"
            }
            
            if let release = movie.release_date {
                releaseDateLabel.text = "RELEASE DATE: \(String(release))"
            }
            if let budget = movie.budget{
                budgetLabel.text = "BUDGET: \(String(budget))"
            }
            if let revenue = movie.revenue {
                revenueLabel.text = "REVENUE: \(String(revenue))"
            }
            /*if let genres = movie.genres![0].name {
                genresLabel.text = "GENRES: \(String(genres))"
            }*/
            if let overview = movie.overview {
                overViewLabel.text = "OVERVIEW: \(String(overview))"
            }
            if let runtime = movie.runtime {
                runTimeLabel.text = "RUNTIME: \(String(runtime))"
            }
            if let productioncompany = movie.production_companies![0].name {
                productionCompaniesLabel.text = "PRODUCTON COMPANIES: \(String(productioncompany))"
            }
        }
    }
           
   
    
    func getDetails() {
            if let movieID = id {

                detailServices.getDetail(movieid: movieID) { result in

                switch result {

                        case .success(let response):

                            self.details = response

                            self.configure()

                        case .failure(let error):

                            print(error)

                        }

                    }

                }
        
    }



}

extension String {
func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
  let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
  let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
  let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
  let range = (self as NSString).range(of: text)
  fullString.addAttributes(boldFontAttribute, range: range)
  return fullString
}}


