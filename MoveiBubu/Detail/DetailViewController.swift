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
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var genresStackView: UIStackView!
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
    @IBOutlet weak var productionCompaniesLabel: UILabel!{
        didSet {
            productionCompaniesLabel.text = "Production Companies".localize
        }
    }
    @IBOutlet weak var budgetStackView: UIStackView!
    @IBOutlet weak var castStackView: UIStackView!
    @IBOutlet weak var castLabel: UILabel!{
        didSet {
            castLabel.text = "Cast".localize
        }
    }
    @IBOutlet weak var recommStackView: UIStackView!
    @IBOutlet weak var recommLabel: UILabel! {
        didSet {
            recommLabel.text = "Recomendation".localize
        }
    }
    @IBOutlet weak var recommCollectionView: UICollectionView! {
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
    @IBOutlet weak var castCollectionView: UICollectionView! {
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
    @IBAction func homepageLink(_ sender: Any) {
        if let webpageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: WebViewController.self)) as? WebViewController {
            
            webpageVC.link = URL(string: (details?.homepage)!)//homepage string datas?? g??nderilecek
            
            self.navigationController?.pushViewController(webpageVC, animated: true)
            }
    }
    func checkStatus (Status: Bool) {
        if Status {
            favoritesButton.setImage(UIImage(systemName: "star.fill"), for: UIControl.State.normal)
            favoritesButton.tintColor = UIColor.systemYellow
        } else {
            favoritesButton.setImage(UIImage(systemName: "star"), for: UIControl.State.normal)
            favoritesButton.tintColor = UIColor.systemYellow
            }
    }
    @IBAction func favoritesButton(_ sender: Any) {
        if let movie = details {
            if let Id = id {
                let isFavorites = DataMngr.sharedData.UpdateFavorites(id: Id, title: movie.title ?? "", release_date: movie.release_date ?? "", poster_path: movie.poster_path ?? "", vote_average: movie.vote_average ?? 0)
                      checkStatus(Status: isFavorites)
                checkStatus(Status: isFavorites)
                } else if let favorite = favorite {
                DataMngr.sharedData.DeleteFavorites(movie: favorite)
                checkStatus(Status: false)
                }
            }
    }
    
    private let bigcastservices: BigCastServices = BigCastServices()
    private let castServices: CastServicesProtocol = CastServices()
    private let detailServices: DetailServicesProtocol = DetailServices()
    private var details: DetailModel?
    //isimlendirme
    private var cast: [creditsModel] = []
    private var recomm: [ListModel] = []
    private var genres: [Genres] = []
    private var bigCast: [castModel] = []
    private var big: castModel?
  //  private let baseImageURL = "https://image.tmdb.org/t/p/w500"
    //let getImage: imageServicesProtocol = getImageServices
    var id : Int?
    var favorite: Task?
    
    override func viewDidLoad() {
        getDetails()
        getCast()
        getRecomm()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
       let answer = DataMngr.sharedData.checkFavorites(check: id)
        checkStatus(Status: answer )
        
    }
    
    func configure() {
        if let movie = details {
            
            imageView.getImage(path: movie.poster_path)
            
            if let name = movie.title {
                let title = "TITLE".localize
                nameLabel.text = "\(title): \(String(name))"
            } else {
                nameLabel.text = nil
            }
           if let otitle = movie.original_title {
               let ortitle = "ORGINAL TITLE".localize
               orginalTitleLabel.text = "\(ortitle): \(String(otitle))"
           } else {
               orginalTitleLabel.text = nil
           }
            if let olanguage = movie.original_language {
                let orlanguage = "Original Language".localize
                orginalLanguageLabel.text = "\(orlanguage): \(String(olanguage))"
            } else {
                orginalLanguageLabel.text = nil
            }
            
            if let release = movie.release_date {
                let releases = "Release Date".localize
                releaseDateLabel.text = "\(releases): \(String(release))"
            } else {
                releaseDateLabel.text = nil
            }
            if let budget = movie.budget{
            
                
                budgetLabel.text = "BUDGET: $\(budget.formattedWithSeparator)"
            } else {
                budgetLabel.text = nil
            }
            if let revenue = movie.revenue {
                
                revenueLabel.text = "REVENUE: \(revenue.formattedWithSeparator)"
            } else {
                revenueLabel.text = nil
            }
           
            if let overview = movie.overview {
                let overviews = "Overview".localize
                overViewLabel.text = "\n\(overviews):\n \(String(overview))"
            } else {
                overViewLabel.text = nil
            }
            if let runtime = movie.runtime {
                let runtimes = "Runtime".localize
                _ = "min".localize
                runTimeLabel.text = "\(runtimes): \(String(runtime))"
            } else {
                runTimeLabel.text = nil
            }
            if let productioncompany = movie.production_companies {
                _ = "Production Company".localize
                productionCompaniesLabel.text = ""
                for company in productioncompany {
                    productionCompaniesLabel.text?.append(" \(company.name ?? "").\n")
                    }
                } else {
                productionCompaniesLabel.text = nil
            }
            if let raiting = movie.vote_average {
                let voteAverage = "Vote Average".localize
                raitingLabel.text = "\(voteAverage) \(String(raiting))"
            } else {
                raitingLabel.text = nil
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
            //return
        default:
            return
            /*if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
                detailVC.id = recomm[indexPath.row].id
                self.navigationController?.pushViewController(detailVC, animated: true)
                
            }*/
    }

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

/*extension String { // string tipler,ni lokalize etmek i??in dahil edilmi?? olan eklenti.

    func localized() -> String {

        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
        
    }
    
}*/
extension String {

    func localize(comment: String = "") -> String {

        return NSLocalizedString(self, comment: comment)

    }

    var localize: String {

        return localize()

    }

}

/*func cleanDollars(_ value: String?) -> String {
    guard value != nil else { return "$0.00" }
    let doubleValue = Double(value!) ?? 0.0
    let formatter = NumberFormatter()
    formatter.currencyCode = "USD"
    formatter.currencySymbol = "$"
    formatter.minimumFractionDigits = (value!.contains(".00")) ? 0 : 2
    formatter.maximumFractionDigits = 2
    formatter.numberStyle = .currencyAccounting
    return formatter.string(from: NSNumber(value: doubleValue)) ?? "$\(doubleValue)"
}*/
