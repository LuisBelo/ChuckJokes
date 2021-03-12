//
//  CategoryListService.swift
//  BasicListApp
//
//  Created by Luis Belo on 08/03/21.
//

import Foundation
import Alamofire

struct CategoryAPIService {
    
    public func getAllCategories(result: @escaping (APIResult<[String]>) -> Void){
        
        AF.request(APIInfo.GET_ALL_CATEGORY).response { (response) in
            
            switch response.result {
            case .success(let data):
                if let checkedData = data {
                    let decoder = JSONDecoder()

                    do {
                        let categories = try decoder.decode([String].self, from: checkedData)
                        result(.Success(categories))
                    } catch {
                        result(.Failure(NSLocalizedString("generic_api_error", comment: "")))
                    }
                } else {
                    result(.Failure(NSLocalizedString("generic_api_error", comment: "")))
                }

            case.failure( _):
                result(.Failure(NSLocalizedString("generic_call_failed_error", comment: "")))
            }
            
        }
        
    }
    
    public func getCategoryDetail(category: String, result: @escaping (APIResult<CategoryDetail>) -> Void){
        
        let parameters: [String: String] = ["category": category]
        AF.request(APIInfo.GET_CATEGORY_DETAIL, parameters: parameters).response { (response) in
            
            switch response.result {
            case .success(let data):
                if let checkedData = data {
                    let decoder = JSONDecoder()

                    do {
                        let categoryDetail = try decoder.decode(CategoryDetail.self, from: checkedData)
                        result(.Success(categoryDetail))
                    } catch {
                        result(.Failure(NSLocalizedString("generic_api_error", comment: "")))
                    }
                } else {
                    result(.Failure(NSLocalizedString("generic_api_error", comment: "")))
                }

            case.failure( _):
                result(.Failure(NSLocalizedString("generic_call_failed_error", comment: "")))
            }
            
            
        }
        
    }
    
}
