//
//  ProfileHeaderViewmodel.swift
//  InstagramFirestore
//
//  Created by Anahi Rojas on 15/07/21.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname:String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    
    init(user: User) {
        self.user = user
    }
}
