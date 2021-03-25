//
//  GithubUserDetailHeaderView.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/25/21.
//

import UIKit

class GithubUserDetailHeaderView: UIView {
    // MARK: - Properties
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.layer.borderWidth = 4.0
        imageView.tintColor = .darkGray
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage.personCircleFill
        return imageView
    }()
    
    private let followerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.text = "Follower: 0"
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.text = "Following: 0"
        return label
    }()
    
    var user:User? {
        didSet { self.populateUserData() }
    }
    
    // MARK: - Lifecycle
    override init(frame:CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.setupUI()
    }
    
    // MARK: - Helpers
    private func populateUserData(){
        guard let user = self.user,
              let follower = user.followers.value,
              let following = user.following.value else{
            return
        }
        
        self.followerLabel.text = "Follower: \(follower)"
        self.followingLabel.text = "Following: \(following)"
        self.profileImage.kf.setImage(with: URL(string: user.avatar_url!), placeholder: UIImage.personCircleFill)
    }
    
    private func setupUI(){
        
        self.setupProfileImage()
        self.setupFollowerStack()
    }
    
    private func setupFollowerStack(){
        let stack = UIStackView(arrangedSubviews: [self.followerLabel, self.followingLabel])
        stack.axis = .horizontal
        self.addSubview(stack)
        stack.anchor(top:self.profileImage.bottomAnchor, left:self.leftAnchor, right: self.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
    }
    
    private func setupProfileImage(){
        self.profileImage.setDimensions(height: 200, width: 200)
        self.profileImage.layer.cornerRadius = 200/2
        
        self.addSubview(self.profileImage)
        self.profileImage.centerX(inView: self)
        self.profileImage.anchor(top: self.topAnchor, paddingTop: 26)
    }
}
