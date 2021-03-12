//
//  CategoryListViewController.swift
//  BasicListApp
//
//  Created by Luis Belo on 08/03/21.
//

import UIKit
import RxSwift

let SIMPLE_ITEM_IDENFITIER = "simpleListItem"

class CategoryListViewController: UIViewController {
    
    lazy var categoryTableView: UITableView = {
        let table = UITableView()
        table.register(SimpleListItemCell.self, forCellReuseIdentifier: SIMPLE_ITEM_IDENFITIER)
        table.separatorStyle = .singleLineEtched
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = ColorInfo.mainLightBackgroundColor
        table.estimatedRowHeight = 100
        table.accessibilityIdentifier = "categoryListTableView"
        return table
    }()
    
    let disposeBag = DisposeBag()
    lazy var categories = [String]()
    let categoryListViewModel = CategoryListViewModel()
    lazy var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryTableView.delegate = self
        self.categoryTableView.dataSource = self
        
        self.setupView()
        self.setupObservers()
        self.categoryListViewModel.fetchCategoryList()
    }
    
    private func setupView(){
        self.view.pinView(viewToPin: self.categoryTableView)
        
        if #available(iOS 10.0, *) {
            self.categoryTableView.refreshControl = self.refreshControl
        } else {
            self.categoryTableView.addSubview(self.refreshControl)
        }
        
        self.refreshControl.addTarget(self, action: #selector(self.refreshCategoryValues), for: .valueChanged)
        self.refreshControl.alpha = 0
        
        self.title = NSLocalizedString("category_screen_title", comment: "")
        self.view.backgroundColor = ColorInfo.mainLightBackgroundColor
    }
    
    private func setupObservers(){
        self.categoryListViewModel
            .categoryListObservable
            .subscribe { (event) in
            switch event {
            case .next(let categoryList):
                self.categories = categoryList
                self.categoryTableView.reloadData()
                
            case.completed: break
                
            case.error( _):
                self.categories = [String]()
                self.categoryTableView.reloadData()
                
            }
            
        }.disposed(by: self.disposeBag)
        
        self.categoryListViewModel
            .categoryFetchErrorObservable
            .observe(on: MainScheduler.instance)
            .subscribe { (event) in
                switch event {
                case.next(let stringError):
                    self.showSimpleAlert(title: NSLocalizedString("alert_error_title", comment: ""), description: stringError, dismissCompletion: nil)
                default:
                    self.categories = [String]()
                    self.categoryTableView.reloadData()
                }
            }.disposed(by: self.disposeBag)

        self.categoryListViewModel
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
                    self.showSimpleAlert(title: NSLocalizedString("alert_error_title", comment: ""), description: NSLocalizedString("default_observer_flow_error", comment: ""))
                }
                
            }.disposed(by: self.disposeBag)
    }
    
    @objc func refreshCategoryValues(){
        self.refreshControl.endRefreshing()
        self.categoryListViewModel.fetchCategoryList()
    }
}

extension CategoryListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = CategoryDetailViewController()
        detailVC.category = categories[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension CategoryListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reusableCell = tableView.dequeueReusableCell(withIdentifier: SIMPLE_ITEM_IDENFITIER) as? SimpleListItemCell
        
        if reusableCell == nil {
            reusableCell = SimpleListItemCell()
        }
        let currentCategory = self.categories[indexPath.row]
        reusableCell!.title.text = currentCategory
        return reusableCell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
}

