//
//  ListViewController.swift
//  MoveiBubu
//
//  Created by obss on 15.06.2022.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var ListTableView: UITableView! {
        
        didSet {
            ListTableView.dataSource = self
            ListTableView.delegate = self
            ListTableView.register(UINib(nibName: String(describing: ListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ListTableViewCell.self))
        }
    }
    
    private let listServices: ListServicesProtocol = ListServices()
    private var lists: [ListModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        listServices.getAllList { result in
            switch result {
            case .success(let response):
                self.lists = response.results ?? []
                self.ListTableView.reloadData()
                print(self.lists)
            case .failure(let error):
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }
    

  

}
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListTableView.dequeueReusableCell(withIdentifier: String(describing: ListTableViewCell.self), for: indexPath) as! ListTableViewCell
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
