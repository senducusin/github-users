//
//  GithubUserDetailsController.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/22/21.
//

import UIKit

class GithubUserDetailsController: UIViewController {
    // MARK: - Properties
    var user: User?
    
    // MARK: - Lifecycle
    init(user: User){
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
        if  let login = user.login,
            let resource = ResponseGithubUser.user(withLogin: login) {
            
            WebService().load(resource: resource) { [weak self] result in
                
                switch(result){
                
                case .success(let user):
                    self?.user?.avatar_url = user.avatar_url
                    self?.user?.bio = user.bio
                    self?.user?.blog = user.blog
                    self?.user?.company = user.company
                    
                    
//                    PersistenceService.shared.save { error in
//                        if let error = error {
//                            print(error.localizedDescription)
//                        }
//                        
//                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Helpers
    private func setupUI(){
        guard let user = self.user else {
            return
        }
        
        self.view.backgroundColor = .white
        self.title = user.login
    }
}
