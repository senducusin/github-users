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
//        
//        if let user = self.user,
//           let resource = ResponseGithubUser.user(withUser: user){
//            WebService().load(resource: resource) { result in
//                switch(result){
//                
//                case .success(let user):
//                    self.user = user
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
        
        super.init(nibName: nil, bundle: nil)
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
