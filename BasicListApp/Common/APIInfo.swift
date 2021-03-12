//
//  APIInfo.swift
//  BasicListApp
//
//  Created by Luis Belo on 08/03/21.
//

import Foundation
struct APIInfo {
    
    private static let BASE_URL = "https://api.chucknorris.io"
    
    static let GET_ALL_CATEGORY = "\(BASE_URL)/jokes/categories"
    static let GET_CATEGORY_DETAIL = "\(BASE_URL)/jokes/random"
}
