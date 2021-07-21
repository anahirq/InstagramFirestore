//
//  UserService.swift
//  InstagramFirestore
//
//  Created by Anahi Rojas on 15/07/21.
//

import Firebase

//Retrive data from the database
struct UserService {
    static func fetchuser(completion: @escaping(User) -> Void){
        //Get current user
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            
            let user = User(dictionary: dictionary)
            completion(user)
            
        }
    }
}
