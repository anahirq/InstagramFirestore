//
//  CommentInputAccesoryView.swift
//  InstagramFirestore
//
//  Created by Anahi Rojas on 03/08/21.
//

import UIKit

class CommentInputAccesoryView: UIView {
    
    //MARK: - Properties
    
    //Using Reusable inputTextView file
    private let commentTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "Enter Comment..."
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.isScrollEnabled = false
        tv.placeHolderShouldCenter = true
        
        return tv
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handlePostTapped), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        //Automatically adjust keyboard height depending on the device
        autoresizingMask = .flexibleHeight
        
        addSubview(postButton)
        postButton.anchor(top: topAnchor, right: rightAnchor, paddingRight: 8)
        postButton.setDimensions(height: 50, width: 50)
        
        addSubview(commentTextView)
        commentTextView.anchor(top: topAnchor, left: leftAnchor,
                               bottom: safeAreaLayoutGuide.bottomAnchor, right: postButton.leftAnchor,
                               paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        addSubview(divider)
        divider.anchor(top: topAnchor, left: leftAnchor, right:  rightAnchor, height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //It will figure out the size based on the dimensions of the view controller
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    //MARK: - Properties
    
    @objc func handlePostTapped() {
        
    }
}
