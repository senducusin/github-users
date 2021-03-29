//
//  GithubUserListTableViewCell.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/22/21.
//

import UIKit
import Kingfisher


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
    
    private let notesImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.tintColor = .darkGray
        imageView.image = UIImage.noteText
        imageView.isHidden = true
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
    
    // MARK: - Lifecycles
    
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
        let stack = self.setupStackView()
        self.setupNotseImage(stack: stack)
        
    }
    
    private func setupNotseImage(stack:UIView){
        self.addSubview(self.notesImageView)
        self.notesImageView.centerY(inView: self, leftAnchor: stack.rightAnchor)
        self.notesImageView.setDimensions(height: 30, width: 30)
        self.notesImageView.anchor(right:self.rightAnchor, paddingRight: 34)
    }
    
    private func setupAvatar(){
        self.addSubview(self.avatarImageView)
        self.avatarImageView.centerY(inView: self, leftAnchor: self.leftAnchor, paddingLeft: 12)
        let imageDimension: CGFloat = 56
        self.avatarImageView.setDimensions(height: imageDimension, width: imageDimension)
        self.avatarImageView.layer.cornerRadius = imageDimension/2
    }
    
    private func setupStackView() -> UIStackView{
        let stack = UIStackView(arrangedSubviews: [self.loginLabel, self.typeLabel])
        stack.axis = .vertical
        stack.spacing = 2
        self.addSubview(stack)
        stack.centerY(inView: self.avatarImageView, leftAnchor: self.avatarImageView.rightAnchor, paddingLeft: 12)
        return stack
    }
    
    private func configure(){
        if let user = user,
           let notesIsEmpty = user.notes?.isEmpty {
            self.loginLabel.text = user.login
            self.typeLabel.text = user.type
            
            
            if let urlString = user.avatar_url{
                self.avatarImageView.kf.setImage(with: URL(string: urlString), placeholder:UIImage.personCircleFill )
            }else{
                self.avatarImageView.image = UIImage.personCircleFill
            }
            
            self.notesImageView.isHidden = notesIsEmpty
            
        }
    }
}
