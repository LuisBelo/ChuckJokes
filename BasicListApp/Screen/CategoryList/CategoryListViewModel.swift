//
//  CategoryListViewModel.swift
//  BasicListApp
//
//  Created by Luis Belo on 10/03/21.
//

import Foundation
import UIKit
import RxSwift

class CategoryListViewModel {
    
    
    let categoryListObservable = PublishSubject<[String]>()
    let categoryFetchErrorObservable = PublishSubject<String>()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    private let categoryAPIService = CategoryAPIService()
    
    func fetchCategoryList(){
        
        self.loading.onNext(true)
        categoryAPIService.getAllCategories { (result) in
            
            self.loading.onNext(false)
            switch result {
            
            case.Success(let list):
                self.categoryListObservable.onNext(list)
            case .Failure(let errorString):
                self.categoryFetchErrorObservable.onNext(errorString)
            }
            
        }
        
    }
}
