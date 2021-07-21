//
//  CustomButton.swift
//  InstagramFirestore
//
//  Created by Anahi Rojas on 08/07/21.
//

import UIKit

class CustomButton: UIButton {
    //Initializes and returns a newly allocated view object with the specified frame rectangle.
    init(placeholder: String) {
        super.init(frame: .zero)
        
        setTitle("\(placeholder)", for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        layer.cornerRadius = 25
        setHeight(50)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
