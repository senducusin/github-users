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
        
        defer {
            self.viewModel.appStarted = true
        }
        
        self.setupTableView()
        self.setupUI()
        self.loadUsers()
    }
    
// MARK: - Helpers
    private func setupUI(){
        self.title = "Github Users"
    }
    
    private func setupTableView(){
        self.tableView.register(GithubUserListTableViewCell.self, forCellReuseIdentifier: "GithubUserListTableViewCell")
        self.tableView.rowHeight = 80
    }
    
    private func loadUsers(){
        PersistenceService.shared.retrieveUsers(withPagination: self.viewModel.pagination) { [weak self] result in
            switch(result){
            
            case .success(let users): //break
                self?.viewModel.users = users
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            if let users = self?.viewModel.users,
               users.isEmpty{
                print("still calling?")
                self?.pullUsers()
            }
        }
    }
    
    private func pullUsers(){
        guard self.isFetching == false,
              let resource = User.all(pagination: self.viewModel.pagination) else {
            return
        }
        
        self.isFetching.toggle()
        
        WebService().loadToCoreData(resource: resource) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.isFetching.toggle()
            self.loadUsers()
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
        
        let controller = GithubUserDetailsController(user:user)
        navigationController?.pushViewController(controller, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard viewModel.appStarted else {
            return
        }
        
        let position = scrollView.contentOffset.y

        if position > (self.tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            self.pullUsers()
        }
    }
}
