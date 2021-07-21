//
//  CustomTextField.swift
//  InstagramFirestore
//
//  Created by Anahi Rojas on 06/07/21.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String){
        super.init(frame: .zero)
        
        //Give placeholder some space
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 17)
        leftView = spacer
        leftViewMode = .always
        
        //Creating custom textfield
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        layer.cornerRadius = 25
        setHeight(50)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
