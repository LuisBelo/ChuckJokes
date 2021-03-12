//
//  CategoryDetail.swift
//  BasicListApp
//
//  Created by Luis Belo on 08/03/21.
//

import Foundation

struct CategoryDetail : Codable {
    var categories: [String]
    var iconUrl: String
    var id: String
    var url: String
    var value: String
    
    enum CodingKeys: String, CodingKey {
        case categories, iconUrl = "icon_url", id, url, value
    }
}
