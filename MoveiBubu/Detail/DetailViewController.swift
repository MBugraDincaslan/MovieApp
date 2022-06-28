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

    @IBAction func homepageLink(_ sender: Any) {
       if let webpageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: WebViewController.self)) as? WebViewController{

           webpageVC.link = URL(string: (details?.homepage)!)//homepage string datası gönderilecek

                    self.navigationController?.pushViewController(webpageVC, animated: true)

                }
    }
    @IBAction func favoritesButton(_ sender: Any) {
        if let movie = details {
            if let Id = id {
                DataMngr.sharedData.UpdateFavorites(id: Id, title: movie.title ?? "", release_date: movie.release_date ?? "", poster_path: movie.poster_path ?? "", vote_average: movie.vote_average ?? 0)
            }
        
        
        }
        
    }
    
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdView: UIView!
    
    @IBOutlet weak var genresStackView: UIStackView!
    @IBOutlet weak var genresCollectionView: UICollectionView! {
        didSet {
            genresCollectionView.dataSource = self
            genresCollectionView.delegate = self
            genresCollectionView.register(UINib(nibName: String(describing: GenresCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: GenresCollectionViewCell.self))
            let design: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            design.itemSize = CGSize(width: 120, height: 50)
            design.scrollDirection = .horizontal
              design.minimumInteritemSpacing = 5

                    genresCollectionView.collectionViewLayout = design
            
        }
    }
    
    @IBOutlet weak var raitingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orginalTitleLabel: UILabel!
    @IBOutlet weak var orginalLanguageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    
    @IBOutlet weak var companiesStackView: UIStackView!
    @IBOutlet weak var productionCompaniesLabel: UILabel!
    
    @IBOutlet weak var budgetStackView: UIStackView!
    
    @IBOutlet weak var castStackView: UIStackView!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!{
    didSet {
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        castCollectionView.register(UINib(nibName: String(describing: CastCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CastCollectionViewCell.self))
        let design: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        design.itemSize = CGSize(width: 100, height: 250)
        design.scrollDirection = .horizontal
          design.minimumInteritemSpacing = 5

                castCollectionView.collectionViewLayout = design
        castCollectionView.reloadData()
        
        }
    }

    
    @IBOutlet weak var recommStackView: UIStackView!
    @IBOutlet weak var recommLabel: UILabel!
    @IBOutlet weak var recommCollectionView: UICollectionView!{
        didSet {
            recommCollectionView.dataSource = self
            recommCollectionView.delegate = self
            recommCollectionView.register(UINib(nibName: String(describing: CastCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CastCollectionViewCell.self))
            let design: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            design.itemSize = CGSize(width: 100, height: 250)
            design.scrollDirection = .horizontal
              design.minimumInteritemSpacing = 5

                    recommCollectionView.collectionViewLayout = design
            
            
            }
        }
        
    

    
    
    
    private let bigcastservices: BigCastServices = BigCastServices()
    private let castServices: CastServicesProtocol = CastServices()
    private let detailServices: DetailServicesProtocol = DetailServices()
    private var details: DetailModel?
    private var cast: [creditsModel] = []
    private var recomm: [ListModel] = []
    private var genres: [Genres] = []
    private var bigCast: [castModel] = []
    private var big: castModel?
    private let baseImageURL = "https://image.tmdb.org/t/p/original"
    var id : Int?
    
    
    
    override func viewDidLoad() {
        getDetails()
        getCast()
        getRecomm()
        
    
    }
    
    
    func configure (){
       
        if let movie = details {
            if let name = movie.title{
                nameLabel.text = "TITLE: \(String(name))"
                
            }
            
            if let posterPath = movie.poster_path {

                        if let imageURL: URL = URL(string: "\(baseImageURL)\(posterPath)") {

                                imageView.kf.setImage(with: imageURL)

                            } else {

                                imageView.image = nil

                            }

                        } else {

                            imageView.image = nil

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
                overViewLabel.text = "\n OVERVIEW:\n \(String(overview))"
            }
            if let runtime = movie.runtime {
                runTimeLabel.text = "RUNTIME: \(String(runtime))".localized()
            }
            if let productioncompany = movie.production_companies {
                productionCompaniesLabel.text = ""
                for company in productioncompany {
                    productionCompaniesLabel.text?.append(" \(company.name ?? "")\n")
                }
                
            }else {
                productionCompaniesLabel.text = ""
            }
            if let raiting = movie.vote_average {
                raitingLabel.text = "VOTE AVERAGE: \(String(raiting))"
            }
            if let genres = movie.genres {
                self.genres = genres
                genresCollectionView.reloadData()
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
    func getRecomm () {
        if let movieID = id {
            RecommendationServices.shared.getRecommendation(movieid: movieID) { result in
                switch result {

                        case .success(let response):
                    if let recomm = response.results {
                        
                    self.recomm = recomm
                        self.recommCollectionView.reloadData()
                    }
                            

                        case .failure(let error):

                            print(error)

                        }
            }
        }
    }
    func getCast () {
        if let movieID = id {
            CreditsServices.shared.getCredits(movieid: movieID) {
                result in
                switch result {

                        case .success(let response):
                    if let cast = response.cast {
                        
                    self.cast = cast
                        self.castCollectionView.reloadData()
                    }
                            

                        case .failure(let error):

                            print(error)

                        }

                    }
            
                }
                
            }
    /*func getBig() {
        if let castid = id {
            BigCastServices.shared.getBigCast(personid: castid) {
                result in
                switch result {

                        case .success(let response):
                    if let bigcast = response.cast {
                        
                    self.bigCast = bigcast
                        self.castCollectionView.reloadData()
                    }
                            

                        case .failure(let error):

                            print(error)

                        }

                    }
        }
    }*/
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case castCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastCollectionViewCell.self), for: indexPath) as! CastCollectionViewCell
            cell.configure(casting: cast[indexPath.row])
            return cell
        case recommCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastCollectionViewCell.self), for: indexPath) as! CastCollectionViewCell
            cell.configureRecomm(movie: recomm[indexPath.row])
            return cell
        case genresCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GenresCollectionViewCell.self), for: indexPath) as! GenresCollectionViewCell
            cell.genreLabel.text = genres[indexPath.row].name
            return cell

        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastCollectionViewCell.self), for: indexPath)
            return cell
        }
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {

               case genresCollectionView:

            return genres.count

               case castCollectionView:

                   return cast.count

               case recommCollectionView:

            return recomm.count

               default:

                   return 0

               }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case recommCollectionView:
            if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
                detailVC.id = recomm[indexPath.row].id
                self.navigationController?.pushViewController(detailVC, animated: true)
                
            }
        case castCollectionView:
            if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: BigCastViewController.self)) as? BigCastViewController {
                detailVC.id = cast[indexPath.row].id
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        default:
            if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
                detailVC.id = recomm[indexPath.row].id
                self.navigationController?.pushViewController(detailVC, animated: true)
                
        }
            
    }
/*func configureCell() {
    if let castdetail = cast {
        if let name = castdetail.name{
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
    }
    

}*/

/*extension String {
func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
  let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
  let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
  let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
  let range = (self as NSString).range(of: text)
  fullString.addAttributes(boldFontAttribute, range: range)
  return fullString
}}*/


    }
}
extension String { // string tipler,ni lokalize etmek için dahil edilmiş olan eklenti.

    func localized() -> String {

        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)

    }

}
