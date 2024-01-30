//
//  News.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/26/24.
//

import Foundation

struct News: Decodable {
    let total: Int?
    let start: Int?
    let items: [NewsItem]
}

struct NewsItem: Decodable {
    let title: String?
    let originallink: String?
    let description: String?
    let pubDate: String?
}
