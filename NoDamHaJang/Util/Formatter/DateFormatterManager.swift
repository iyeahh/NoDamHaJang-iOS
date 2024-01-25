//
//  DateFormatterManager.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/22/24.
//

import Foundation

final class DateFormatterManager {
    static let shared = DateFormatterManager()

    private init() {}

    private let dateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()

    func dateFormat() -> String {
        let nowDate = Date()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: nowDate)
    }
}
