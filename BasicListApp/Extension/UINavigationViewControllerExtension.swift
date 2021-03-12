//
//  UINavigationViewControllerExtension.swift
//  BasicListApp
//
//  Created by Luis Belo on 08/03/21.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func setupDefaultsConfiguration(){
        
        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = true
            navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ColorInfo.mainLightTitleColor]
        }
                
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: ColorInfo.mainLightTitleColor]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: ColorInfo.mainLightTitleColor]
            navBarAppearance.backgroundColor = ColorInfo.mainColor
            navigationBar.tintColor = ColorInfo.mainLightTitleColor
            navigationBar.barTintColor = ColorInfo.mainColor
            navigationBar.backgroundColor = ColorInfo.mainColor
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : ColorInfo.mainLightTitleColor]
            navigationBar.tintColor = ColorInfo.mainLightTitleColor
            navigationBar.barTintColor = ColorInfo.mainColor
            navigationBar.backgroundColor = ColorInfo.mainColor
        }
        
    }
    
}
