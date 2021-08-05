//
//  Post.swift
//  InstagramFirestore
//
//  Created by Anahi Rojas on 27/07/21.
//

import Firebase

struct Post {
    var caption: String
    var likes: Int
    let imageUrl: String
    let ownerUid: String
    let timestamp: Timestamp
    let postId: String
    let ownerImageurl: String
    let ownerUsername: String
    var didLike = false
    
    init(postId: String, dictionary: [String: Any]){
        self.postId = postId
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.ownerImageurl = dictionary["ownerImageUrl"] as? String ?? ""
        self.ownerUsername = dictionary["ownerUsername"] as? String ?? ""
        
    }
}
