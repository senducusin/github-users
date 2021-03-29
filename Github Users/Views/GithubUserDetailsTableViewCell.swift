//
//  GithubUserDetailsTableViewCell.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/26/21.
//

import UIKit

class GithubUserDetailsTableViewCell: UITableViewCell {
    // MARK: - Properties
    private var propertyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let propertyValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    var detail:Detail? {
        didSet {
            self.configure()
        }
    }
    
    // MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setupUI(){
        let stack = UIStackView(arrangedSubviews: [self.propertyNameLabel,self.propertyValueLabel])
        stack.axis = .vertical
        self.addSubview(stack)
        stack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 5, paddingLeft: 17, paddingBottom: 5, paddingRight: 17)
    }
    
    private func configure(){
        guard let name = detail?.name,
              let value = detail?.valueString() else {
            return
        }
        
        self.propertyNameLabel.text = name
        self.propertyValueLabel.text = value
    }
}
