//
//  PostService.swift
//  InstagramFirestore
//
//  Created by Anahi Rojas on 27/07/21.
//  Upload post to firestore

import UIKit
import Firebase

struct PostService {
    static func uploadPost(caption: String, image: UIImage, user: User, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
    ImageUploader.uploadImage(image: image) { imageUrl in
        let data = ["caption": caption,
                    "timestamp": Timestamp(date: Date()),
                    "likes": 0,
                    "imageUrl" : imageUrl,
                    "ownerUid": uid,
                    "ownerImageUrl": user.profileImageUrl,
                    "ownerUsername": user.username] as [String : Any]
        COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            completion(posts)
        }
    }
    
    //Fetch post for profile section
    static func fetchPosts(forUser uid: String, completion: @escaping([Post]) -> Void){
        let query = COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
        
        query.getDocuments { (snaphot, error) in
            guard let documents = snaphot?.documents else { return }
            
            var posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            
            //order posts from oldest to newest
            posts.sort { (post1, post2) -> Bool in
                return post1.timestamp.seconds > post2.timestamp.seconds
            }
            
            completion(posts)
            
            
        }
    }
    
}
