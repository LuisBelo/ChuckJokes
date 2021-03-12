//
//  CategoryDetailViewModel.swift
//  BasicListApp
//
//  Created by Luis Belo on 10/03/21.
//

import Foundation
import RxSwift

class CategoryDetailViewModel {
    
    let categoryDetailObservable = PublishSubject<CategoryDetail>()
    let categoryDetailFetchErrorObservable = PublishSubject<String>()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    private let categoryAPIService = CategoryAPIService()
    
    func fetchCategoryDetail(category: String){
        self.loading.onNext(true)
        self.categoryAPIService.getCategoryDetail(category: category) { (result) in
            self.loading.onNext(false)
            switch result {
            case.Success(let detail):
                self.categoryDetailObservable.onNext(detail)
            case.Failure(let errorString):
                self.categoryDetailFetchErrorObservable.onNext(errorString)
            }
        }
        
    }
}
