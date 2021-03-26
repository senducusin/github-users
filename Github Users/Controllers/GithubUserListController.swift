//
//  GithubUserListController.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/22/21.
//

import UIKit

class GithubUserListController: UITableViewController {
// MARK: - Properties
    var isFetching = false
    var viewModel = GitUserListViewModel()
    
// MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.setupUI()
        self.loadUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Will execute only when navigated back to view
        // To reload changes from detail view
        if self.viewModel.appStarted {
            self.tableView.reloadData()
        }

        self.viewModel.appStarted = true
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var inSearchMode: Bool {
            return searchController.isActive && !searchController.searchBar.text!.isEmpty
        }
    
// MARK: - Helpers
    private func setupUI(){
        self.title = "Github Users"
        self.setupSearchController()
    }
    
    private func setupTableView(){
        self.tableView.register(GithubUserListTableViewCell.self, forCellReuseIdentifier: "GithubUserListTableViewCell")
        self.tableView.rowHeight = 80
    }
    
    private func setupSearchController() {
            searchController.searchResultsUpdater = self
            self.searchController.searchBar.showsCancelButton = false
            self.navigationItem.searchController = searchController
            self.searchController.obscuresBackgroundDuringPresentation = false
            self.searchController.hidesNavigationBarDuringPresentation = false
            self.searchController.searchBar.placeholder = "Type a username"
            self.definesPresentationContext = false
        }
    
    private func loadUsers(){
        self.viewModel.users = PersistenceService.shared.getUsers()
        
        
        if self.viewModel.users.isEmpty{
            print("still calling?")
            self.pullUsers()
            
        }
    }
    
    private func pullUsers(withPagination pagination: Int = 0){
        guard self.isFetching == false,
              let resource = ResponseUser.all(pagination: pagination) else {
            return
        }
        
        self.isFetching.toggle()
        print(resource.url)
        WebService().load(resource: resource) { result in
            switch(result){
            
            case .success(let users):
                DispatchQueue.main.async {
                    
                    PersistenceService.shared.persistUsers(users: users) { error in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        self.isFetching.toggle()
                        self.tableView.reloadData()
                    }
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension GithubUserListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfrows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "GithubUserListTableViewCell", for: indexPath) as! GithubUserListTableViewCell
        
        cell.user = self.viewModel.userAtIndex(indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.viewModel.userAtIndex(indexPath.row)
        
        let controller = GithubUserDetailsController(user: user)
        navigationController?.pushViewController(controller, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard viewModel.appStarted,
              !inSearchMode else {
            return
        }
        
        let position = scrollView.contentOffset.y

        if position > (self.tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            self.pullUsers(withPagination: self.viewModel.pagination)
        }
    }
}

extension GithubUserListController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        
        self.viewModel.searchText = searchText
        
        self.tableView.reloadData()
        
    }
}
