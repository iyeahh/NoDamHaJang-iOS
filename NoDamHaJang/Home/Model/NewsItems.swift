//
//  NewsItems.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/26/24.
//

import Foundation

struct NewsItems: Identifiable, Equatable {
    let id = UUID()    
    let title: String
    let originallink: String
    let description: String
    let pubDate: String

    var formattedDate: String {
        DateFormatterManager.shared.newsDate(date: pubDate)
    }

    var removedString: String {
        description.removedString
    }
}

