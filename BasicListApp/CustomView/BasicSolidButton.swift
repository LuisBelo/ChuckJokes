//
//  BasicSolidButton.swift
//  BasicListApp
//
//  Created by Luis Belo on 09/03/21.
//

import Foundation
import UIKit

class BasicSolidButton: UIButton {
    
    init(title: String, titleColor: UIColor = ColorInfo.mainLightTitleColor){
        super.init(frame: CGRect.zero)
        self.setTitle(title.uppercased(), for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.titleLabel?.font = .systemFont(ofSize: 15)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = ColorInfo.mainColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
