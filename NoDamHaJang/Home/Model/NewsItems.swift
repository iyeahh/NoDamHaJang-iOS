//
//  NewsItems.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/26/24.
//

import Foundation

struct NewsItems: Identifiable {
    let id = UUID()    
    let title: String
    let originallink: String
    let description: String
    let pubDate: String

    var link: String {
        originallink.removeSlash()
    }
}

