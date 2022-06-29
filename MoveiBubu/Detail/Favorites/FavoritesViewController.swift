//
//  FavoritesViewController.swift
//  MoveiBubu
//
//  Created by obss on 27.06.2022.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
  

    var lists: [Task] = []
    
    @IBOutlet weak var favoritesTableView: UITableView!{
        didSet {
            favoritesTableView.delegate = self
            favoritesTableView.dataSource = self
            favoritesTableView.register(UINib(nibName: String(describing: ListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ListTableViewCell.self))
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lists = DataMngr.sharedData.arrayFavaorites()
        favoritesTableView.reloadData()
        
    }
   

    // MARK: - Table view data source


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: String(describing: ListTableViewCell.self), for: indexPath) as! ListTableViewCell
        cell.favConfigure(movie: lists[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
            detailVC.id = lists[indexPath.row].id
            self.navigationController?.pushViewController(detailVC, animated: true)
            
        }
        
    }
    
}
