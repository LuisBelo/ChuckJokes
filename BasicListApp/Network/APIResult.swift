//
//  APIResult.swift
//  BasicListApp
//
//  Created by Luis Belo on 08/03/21.
//

import Foundation
enum APIResult<T> {
    case Success(T)
    case Failure(String)
}
