//
//  GithubUserDetailsFooterView.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/26/21.
//

import UIKit

protocol GithubUserDetailsFooterViewProtocol {
    func textAreaDidBeginEditing()
}

class GithubUserDetailsFooterView: UIView {
    // MARK: - Properties
    private let notesTextview: UITextView = {
       let textview = UITextView()
        textview.font = UIFont.systemFont(ofSize: 14)
        textview.textColor = .gray
        return textview
    }()
    
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Notes"
        return label
    }()
    
    private let placeholderLabel: UILabel = {
        let label  = UILabel()
        label.text = "Type something"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let lineSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .quaternaryLabel
        return view
    }()
    
    var user:User? {
        didSet {
            self.configure()
        }
    }
    
    var delegate: GithubUserDetailsFooterViewProtocol?
    
    // MARK: - Lifecycle
    override init(frame:CGRect){
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(messageInputDidChange), name: UITextView.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(messageInputDidStarted), name: UITextView.textDidBeginEditingNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.setupUI()
    }
    
    // MARK: - Selectors
    @objc func messageInputDidChange() {
        self.placeholderLabel.isHidden = !self.notesTextview.text.isEmpty
        
        guard let user = self.user else {
            return
        }
        
        PersistenceService.shared.updateUserNotes(user: user, notes: self.notesTextview.text) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    @objc func messageInputDidStarted(){
        self.delegate?.textAreaDidBeginEditing()
    }
    
    // MARK: - Helpers
    private func setupUI(){
       
        self.addSubview(self.lineSeparator)
        self.lineSeparator.anchor(top:self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 16)
        self.lineSeparator.setHeight(height: 0.5)
        
        let stack = UIStackView(arrangedSubviews: [self.noteLabel, self.notesTextview])
        stack.axis = .vertical
        self.addSubview(stack)
        stack.anchor(top:self.lineSeparator.bottomAnchor, left:self.leftAnchor, bottom:self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 8, paddingRight: 16)
        self.notesTextview.setHeight(height: 155)
        
        self.addSubview(self.placeholderLabel)
        self.placeholderLabel.anchor(top:self.notesTextview.topAnchor, left:self.notesTextview.leftAnchor, paddingTop: 8, paddingLeft: 3)
    }
    
    private func configure(){
        guard let user = self.user else {
            return
        }
        
        self.notesTextview.text = user.notes
        self.messageInputDidChange()
    }
}
