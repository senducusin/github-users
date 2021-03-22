//
//  GithubUserListTableViewCell.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/22/21.
//

import UIKit


class GithubUserListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private let avatarImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    private var loginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    var user: User? {
        didSet {
            self.configure()
        }
    }
    
    // MARK: - Lifecyckles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setupUI(){
        self.setupAvatar()
        self.setupStackView()
    }
    
    private func setupAvatar(){
        self.addSubview(self.avatarImageView)
        self.avatarImageView.centerY(inView: self, leftAnchor: self.leftAnchor, paddingLeft: 12)
        let imageDimension: CGFloat = 56
        self.avatarImageView.setDimensions(height: imageDimension, width: imageDimension)
        self.avatarImageView.layer.cornerRadius = imageDimension/2
    }
    
    private func setupStackView(){
        let stack = UIStackView(arrangedSubviews: [self.loginLabel, self.typeLabel])
        stack.axis = .vertical
        stack.spacing = 2
        self.addSubview(stack)
        stack.centerY(inView: self.avatarImageView, leftAnchor: self.avatarImageView.rightAnchor, paddingLeft: 12)
    }
    
    private func configure(){
        let user = self.user!
        
//        if let user = user {
            self.loginLabel.text = user.login
            self.typeLabel.text = user.type
//
//
//            self.avatarImageView.sd_setImage(with: URL(string:user.avatar_url), placeholderImage:UIImage(systemName: "person.circle.fill"))
//        }
    }
}
