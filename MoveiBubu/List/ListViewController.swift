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
    private var updateLists: [ListModel] = []
    var page: Int = 1
    
    
    func getMovie(pageNumber: Int) {
        listServices.getAllList(page: pageNumber) { result in
            switch result {
            case .success(let response):
                self.lists = response.results ?? []
                self.ListTableView.reloadData()
                print(self.lists)
            case .failure(let error):
                print(error)
                
            }
            
        }
        
    }
    func updateList(pageNumber: Int) {
        listServices.getAllList(page: pageNumber) { result in
            switch result {
            case .success(let response):
                self.updateLists = response.results ?? []
                print(self.updateLists)
            case .failure(let error):
                print(error)
                
            }
            
        }
        
    }
        
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovie(pageNumber: page)
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ListTableView.reloadData()
        
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == lists.count - 1 {
            loadMore(status: true)
        } else {
            loadMore(status: false)
        }
    }
    func loadMore(status: Bool){
        if status {
            //activity indicator start
            updateList(pageNumber: page + 1)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.lists.append(contentsOf: self.updateLists)
                self.page += 1
                self.ListTableView.reloadData()
                
            }
            
        } else {
            //activity indicator stopped
            
        }
        
    }
    
}
