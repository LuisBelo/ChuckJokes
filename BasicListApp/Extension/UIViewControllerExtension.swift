//
//  ViewControllerExtension.swift
//  BasicListApp
//
//  Created by Luis Belo on 08/03/21.
//

import Foundation
import UIKit

let LOADING_VIEW_TAG = 99

extension UIViewController {
    
    func showSimpleAlert(title: String, description: String, dismissCompletion: (() -> Void)? = nil){
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { ( _) in
            dismissCompletion?()
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func createIndicatorContainer(description: String) -> UIView {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
        let strLabel = UILabel()
        strLabel.text = description
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = ColorInfo.mainDarkTextColor
        strLabel.translatesAutoresizingMaskIntoConstraints = false
        
        effectView.layer.cornerRadius = 10
        effectView.layer.masksToBounds = true
        
        effectView.contentView.addSubview(indicator)
        
        if !description.isEmpty {
            effectView.contentView.addSubview(strLabel)
            indicator.leadingAnchor.constraint(equalTo: effectView.leadingAnchor, constant: 10).isActive = true
            indicator.topAnchor.constraint(equalTo: effectView.topAnchor, constant: 10).isActive = true
            indicator.bottomAnchor.constraint(equalTo: effectView.bottomAnchor, constant: -10).isActive = true
            indicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
            indicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            strLabel.leadingAnchor.constraint(equalTo: indicator.trailingAnchor, constant: 5).isActive = true
            strLabel.topAnchor.constraint(equalTo: indicator.topAnchor).isActive = true
            strLabel.trailingAnchor.constraint(equalTo: effectView.trailingAnchor, constant: -10).isActive = true
            strLabel.bottomAnchor.constraint(equalTo: indicator.bottomAnchor).isActive = true
        } else {
            indicator.leadingAnchor.constraint(equalTo: effectView.leadingAnchor, constant: 10).isActive = true
            indicator.topAnchor.constraint(equalTo: effectView.topAnchor, constant: 10).isActive = true
            indicator.bottomAnchor.constraint(equalTo: effectView.bottomAnchor, constant: -10).isActive = true
            indicator.trailingAnchor.constraint(equalTo: effectView.trailingAnchor, constant: -10).isActive = true
            indicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
            indicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
        return effectView
    }
    
    func showIndicator(title: String = "") {
        view.endEditing(true)
        
        if let view = view.viewWithTag(LOADING_VIEW_TAG) {
            view.isHidden = false
            return
        }
        
        let indicator = createIndicatorContainer(description: title)
        let indicatorContainer = UIView()
        indicatorContainer.tag = LOADING_VIEW_TAG
        indicatorContainer.translatesAutoresizingMaskIntoConstraints = true
        
        indicatorContainer.backgroundColor = ColorInfo.defaultIndicatorContainerBgColor
        indicatorContainer.addSubview(indicator)
        
        view.pinView(viewToPin: indicatorContainer)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerYAnchor.constraint(equalTo: indicatorContainer.centerYAnchor).isActive = true
        indicator.centerXAnchor.constraint(equalTo: indicatorContainer.centerXAnchor).isActive = true
    }
    
    func dismissIndicator() {
        view.viewWithTag(LOADING_VIEW_TAG)?.isHidden = true
    }
}
