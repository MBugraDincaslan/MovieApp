//
//  SearchViewController.swift
//  MoveiBubu
//
//  Created by obss on 22.06.2022.
//

import UIKit


class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate {
     
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchListTableView: UITableView! {
        didSet {
            searchListTableView.dataSource = self
            searchListTableView.delegate = self
            searchListTableView.register(UINib(nibName: String(describing: ListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ListTableViewCell.self))
            
        }
        
    }
   
    private var searchResults: [ListModel] = []
    private let listServices: ListServicesProtocol = ListServices()
    var searchController: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    
   //MARK: - tableview configure
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchListTableView.dequeueReusableCell(withIdentifier: String(describing: ListTableViewCell.self), for: indexPath) as! ListTableViewCell
        cell.configure(movie: searchResults[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
            detailVC.id = searchResults[indexPath.row].id
            self.navigationController?.pushViewController(detailVC, animated: true)
            
        }
        
    }
    


//MARK: -listeleme fonksiyonu

    func getSearch(text: String){
        listServices.getSearch(moon: text) { result in
            switch result {
            case .success(let response):
                self.searchResults = response.results ?? []
                self.searchListTableView.reloadData()
            case .failure(let error):
                print(error)
                
            }
            
        }
        
    }
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.getSearch(text: searchText)
            
            if !self.searchResults.isEmpty {
                self.searchListTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    isEditing = false //Local variable used to manipulate your cells
        self.searchListTableView.reloadData()
    }
   

/*override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    searchListTableView.reloadData()
    }*/
   

}
