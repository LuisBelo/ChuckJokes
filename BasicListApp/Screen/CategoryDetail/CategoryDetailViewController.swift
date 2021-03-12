//
//  CategoryDetail.swift
//  BasicListApp
//
//  Created by Luis Belo on 09/03/21.
//

import Foundation
import UIKit
import RxSwift

class CategoryDetailViewController: UIViewController {
    
    let iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(named: "placeholder_icon")
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.accessibilityIdentifier = "categoryDetailIcon"
        return icon
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.accessibilityIdentifier = "categoryDetailDescription"
        return label
    }()
    
    let visitButton: BasicSolidButton = {
        let button = BasicSolidButton(title: NSLocalizedString("visit_detail", comment: ""))
        button.accessibilityIdentifier = "categoryDetailLinkButton"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var category: String?
    let disposeBag = DisposeBag()
    let categoryDetailViewModel = CategoryDetailViewModel()
    var categoryDetail: CategoryDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupInitialLayoutState()
        self.setupObservers()
        self.categoryDetailViewModel.fetchCategoryDetail(category: category ?? "")
    }
    
    private func setupObservers(){
        self.categoryDetailViewModel
            .categoryDetailObservable
            .observe(on: MainScheduler.instance)
            .subscribe { (event) in
                switch event {
                case.next(let detail):
                    self.categoryDetail = detail
                    self.setupLayout(categoryDetail: detail)
                    self.fadeIn()
                case .completed: break;
                case.error( _):
                    self.showSimpleAlert(title: NSLocalizedString("alert_error_title", comment: ""), description: NSLocalizedString("default_observer_flow_error", comment: "")) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }.disposed(by: self.disposeBag)
        
        self.categoryDetailViewModel
            .categoryDetailFetchErrorObservable
            .observe(on: MainScheduler.instance)
            .subscribe { (event) in
                switch event {
                case.next(let stringError):
                    self.showSimpleAlert(title: NSLocalizedString("alert_error_title", comment: ""), description: stringError) {
                        self.navigationController?.popViewController(animated: true)
                    }
                case .completed: break;
                case .error( _):
                    self.showSimpleAlert(title: NSLocalizedString("alert_error_title", comment: ""), description: NSLocalizedString("default_observer_flow_error", comment: "")) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }.disposed(by: self.disposeBag)
        
        self.categoryDetailViewModel
            .loading
            .observe(on: MainScheduler.instance)
            .subscribe { (event) in
                
                switch event {
                case.next(let show):
                    if show {
                        self.showIndicator()
                    } else {
                        self.dismissIndicator()
                    }
                
                case .completed: break;
                    
                case.error( _):
                    self.showSimpleAlert(title: NSLocalizedString("alert_error_title", comment: ""), description: NSLocalizedString("default_observer_flow_error", comment: "")) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                
            }.disposed(by: self.disposeBag)
    }
    
    private func fadeIn(){
        UIView.animate(withDuration: 0.5) {
            self.iconImageView.alpha = 1
            self.descriptionLabel.alpha = 1
            self.visitButton.alpha = 1
        }
    }
    
    private func setupLayout(categoryDetail: CategoryDetail){
        
        ImageDownloader.downloadImage(url: categoryDetail.iconUrl, toImageView: self.iconImageView)
        self.descriptionLabel.text = categoryDetail.value
    }
    
    private func setupInitialLayoutState(){
        self.iconImageView.alpha = 0
        self.descriptionLabel.alpha = 0
        self.visitButton.alpha = 0
        
        self.visitButton.addTarget(self, action: #selector(self.openDetailURL), for: .touchUpInside)
    }
    
    @objc func openDetailURL(){
        if let checkedDetail = self.categoryDetail {
            
            guard let url = URL(string: checkedDetail.url) else {
              return
            }

            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            
        }
    }
    
    private func setupView(){
        self.view.backgroundColor = ColorInfo.mainLightBackgroundColor
        self.title = NSLocalizedString("category_detail_screen_title", comment: "")
        
        let mainScroll = UIScrollView()
        mainScroll.translatesAutoresizingMaskIntoConstraints = false
        
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 20
        mainStack.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.isLayoutMarginsRelativeArrangement = true
        
        let buttonContainer = UIView()
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.backgroundColor = ColorInfo.mainLightBackgroundColor
        
        mainStack.addArrangedSubview(self.iconImageView)
        mainStack.addArrangedSubview(self.descriptionLabel)
        
        buttonContainer.addSubview(self.visitButton)
        
        self.view.addSubview(mainScroll)
        self.view.addSubview(buttonContainer)
        
        mainScroll.addSubview(mainStack)
        
        mainStack.leadingAnchor.constraint(equalTo: mainScroll.leadingAnchor).isActive = true
        mainStack.topAnchor.constraint(equalTo: mainScroll.topAnchor).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: mainScroll.trailingAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: mainScroll.bottomAnchor).isActive = true
        mainStack.widthAnchor.constraint(equalTo: mainScroll.widthAnchor, multiplier: 1).isActive = true
        
        mainScroll.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainScroll.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mainScroll.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mainScroll.bottomAnchor.constraint(equalTo: buttonContainer.topAnchor).isActive = true
        mainScroll.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        
        buttonContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        buttonContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        buttonContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.iconImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        
        self.visitButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor, constant: 40).isActive = true
        self.visitButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 15).isActive = true
        self.visitButton.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: -40).isActive = true
        if #available(iOS 11.0, *) {
            self.visitButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        } else {
            self.visitButton.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant: -20).isActive = true
        }
    }
    
}
