//
//  FeedCell.swift
//  InstagramFirestore
//
//  Created by Anahi Rojas on 30/06/21.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    //Profile picture
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    //Username
    //This is how you declare the properties of the button
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("venom", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        //Action handler
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    //Like button
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    //Comment button
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    //Share button
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    //Number of likes label
    private let likesLabel: UILabel = {
       let label = UILabel()
        label.text = "1 Like"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    //Caption label
    private let captionLabel: UILabel = {
       let label = UILabel()
        label.text = "Caption example :) "
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    //Post time  label
    private let postTimeLabel: UILabel = {
       let label = UILabel()
        label.text = "2 days ago"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - Lifecycle / properties
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        //Add profile picture to the cell
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        
        //Create a circle
        profileImageView.layer.cornerRadius = 40 / 2
        
        //Add username button and center it
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        //Image post
        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1) .isActive = true
        
        configureActionButtons()
        
        //likes Label
        addSubview(likesLabel)
        likesLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, paddingTop: -4, paddingLeft: 8)
        
        //caption Label
        addSubview(captionLabel)
        captionLabel.anchor(top: likesLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        //post time Label
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func didTapUsername(){
        print("DEBUG: Did tap username")
    }
    
    // MARK: - Helpers
    
    //Add buttons below posted photo
    func configureActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: postImageView.bottomAnchor, width: 120, height: 50)
    }
    
}