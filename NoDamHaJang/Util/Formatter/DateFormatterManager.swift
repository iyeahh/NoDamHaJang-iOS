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

    func dateFormat(date: Date) -> String {
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: date)
    }

    func chartDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"

        let convertDate = dateFormatter.date(from: date)

        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "MM/dd"
        return myDateFormatter.string(from: convertDate!)
    }
}
