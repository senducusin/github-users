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
    var viewModel: GithubUserDetailsViewModel?
    
    private lazy var headerView = GithubUserDetailHeaderView(frame: .init(
                                                                x: 0, y: 0, width: self.view.frame.width, height: 280))
    
    private lazy var footerView = GithubUserDetailsFooterView(frame: .init(
                                                                x: 0, y: 0, width: self.view.frame.width, height: 200))
    
    // MARK: - Lifecycle
    init(user: User){
        self.user = user
        super.init(nibName: nil, bundle: nil)
        
        DispatchQueue.main.async {
            self.setupUser()
        }
        
        self.loadUser()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.setupUI()
       
    }
    
    // MARK: - Helpers
    private func setupTableView(){
        self.tableView.register(GithubUserDetailsTableViewCell.self, forCellReuseIdentifier: "GithubUserDetailsTableViewCell")
        self.tableView.rowHeight = 55
        self.tableView.tableHeaderView = self.headerView
        self.tableView.tableFooterView = self.footerView
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    private func loadUser(){
        if  let login = user?.login,
            let resource = User.user(withLogin: login) {
            
            WebService().load(resource: resource) { [weak self] result in
                DispatchQueue.main.async {
                    switch(result){
                    case .success(let user):
                        
                        PersistenceService.shared.updateUser(user: user) { [weak self] result in
                            switch(result){
                            
                            case .success(let user):
                                self?.user = user
                                self?.viewModel?.user = user
                                self?.tableView.reloadData()
                            case .failure(let error):
                                print(error.localizedDescription)
                                return
                            }
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        return
                    }
                }
            }
        }
    }
    
    private func setupUI(){
        self.view.backgroundColor = .white
        
        if let user = user {
            self.title = user.name ?? user.login
        }
        self.setupTableView()
    }
    
    private func setupUser(){
        guard let user = self.user else {
            return
        }
        
        self.viewModel = GithubUserDetailsViewModel(user: user)
        self.title = user.name ?? user.login
        self.headerView.user = user
        self.footerView.user = user
        self.footerView.delegate = self
        
        self.tableView.reloadData()
    }
}

extension GithubUserDetailsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfDetails ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GithubUserDetailsTableViewCell", for: indexPath) as! GithubUserDetailsTableViewCell
        
        if let detail = self.viewModel?.detailAtIndex(index: indexPath.row){
            cell.detail = detail
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let detail = self.viewModel?.detailAtIndex(index: indexPath.row){
            let value = detail.valueString()
            UIPasteboard.general.string = value
            self.showAlert()
            
        }
    }
    
    private func showAlert(){
        let alert = UIAlertController(title: "Copied to clipboard", message: "", preferredStyle: .alert)
        
        present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.45) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

extension GithubUserDetailsController: GithubUserDetailsFooterViewProtocol {
    func textAreaDidBeginEditing() {
        let bottomOffset = CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.bounds.height + (footerView.bounds.height*2))
        self.tableView.setContentOffset(bottomOffset, animated: true)
    }
    
    
}
