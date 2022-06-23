//
//  SearchViewController.swift
//  MoveiBubu
//
//  Created by obss on 22.06.2022.
//

import UIKit


class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar! 
    @IBOutlet weak var searchListTableView: UITableView! {
        didSet {
            searchListTableView.dataSource = self
            searchListTableView.delegate = self
            searchListTableView.register(UINib(nibName: String(describing: ListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ListTableViewCell.self))
        }
    }
    private var lists: [ListModel] = []
    private var searchResults: [ListModel] = []
    var searchController: UISearchController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Add a Search Bar Programmtically
                searchController = UISearchController(searchResultsController: nil)
                searchListTableView.tableHeaderView = searchController.searchBar
                
                searchController.obscuresBackgroundDuringPresentation = false

                // Search Bar options
                searchController.searchBar.placeholder = ""
                
                // Search Bar Disappears when tapped, hence the code line below is a MUST
                searchController.hidesNavigationBarDuringPresentation = false
                // Add a colour border for the search bar
                searchController.searchBar.tintColor = UIColor.purple
        
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

                if searchController.isActive {
                    return searchResults.count
                } else {
                    return lists.count
                    
                }
            }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchListTableView.dequeueReusableCell(withIdentifier: String(describing: ListTableViewCell.self), for: indexPath) as! ListTableViewCell
        cell.configure(movie: lists[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
            detailVC.id = lists[indexPath.row].id
            self.navigationController?.pushViewController(detailVC, animated: true)
            
        }
    
    }
}


