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
    
    static func fetchUsers(completition: @escaping([User]) -> Void) {
        
        var users = [User]()
        
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
          
            //the $0 represents each document in the document array
            let users = snapshot.documents.map({ User(dictionary: $0.data()) })
            completition(users)
        }
    }
}
