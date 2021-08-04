//
//  CommentViewModel.swift
//  InstagramFirestore
//
//  Created by Anahi Rojas on 03/08/21.
//

import UIKit

struct CommentViewModel {
    
    private let comment: Comment
    
    var profileImageUrl: URL? { return URL(string: comment.profileImageUrl) }
    var username: String { return comment.username }
    var commentText: String { return comment.commentText }
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    func commentLabelText() -> NSAttributedString {
        
        let attributeString = NSMutableAttributedString(string: "\(comment.username)  ", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        
        attributeString.append(NSAttributedString(string: comment.commentText, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        
        return attributeString
    }
 
    
    func size(forWidth width: CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = comment.commentText
        label.lineBreakMode = .byWordWrapping
        label.setWidth(width)
        
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
