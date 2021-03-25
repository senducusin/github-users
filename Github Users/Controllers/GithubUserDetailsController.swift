//
//  GithubUserDetailsController.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/22/21.
//

import UIKit

class GithubUserDetailsController: UITableViewController {
    // MARK: - Properties
    var user: User?
    
    private lazy var headerView = GithubUserDetailHeaderView(frame: .init(
                                                        x: 0, y: 0, width: self.view.frame.width, height: 260)
        )
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.loadUser()
    }
    
    // MARK: - Helpers
    private func loadUser(){
        if  let login = user?.login,
            let resource = User.user(withLogin: login) {
            
            WebService().load(resource: resource) { [weak self] result in
                
                switch(result){
                case .success(let user):
                    DispatchQueue.main.async {
                        PersistenceService.shared.updateUser(user: user) { [weak self] result in
                            switch(result){
                            
                            case .success(let user):
                                self?.user = user
                                self?.headerView.user = user
                                self?.setupUser()
                                
                            case .failure(let error):
                                print(error.localizedDescription)
                                self?.setupUser()
                                return
                            }
                        }
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.setupUser()
                    return
                }
            }
        }
    }
    
    private func setupUI(){
        self.view.backgroundColor = .white
        self.title = "Loading..."
        
        self.tableView.tableHeaderView = self.headerView
//        self.setupProfileImage()
//        self.setupFollowerStack()
    }
    

    
    private func setupUser(){
        guard let user = self.user else {
            return
        }
        
        self.title = user.name ?? user.login
  
        
        
        
    }
}
