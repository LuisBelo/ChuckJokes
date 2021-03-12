//
//  UIViewExtension.swift
//  BasicListApp
//
//  Created by Luis Belo on 08/03/21.
//

import Foundation
import UIKit


extension UIView {
    
    func pinView(top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, viewToPin: UIView){
        viewToPin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewToPin)
        viewToPin.topAnchor.constraint(equalTo: self.topAnchor, constant: top).isActive = true
        viewToPin.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailing).isActive = true
        viewToPin.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom).isActive = true
        viewToPin.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leading).isActive = true
    }
    
}
