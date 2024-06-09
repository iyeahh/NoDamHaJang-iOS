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

    private let myDateFormatter = {
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
        dateFormatter.dateFormat = "yyyyMMdd"

        let convertDate = dateFormatter.date(from: date)

        myDateFormatter.dateFormat = "MM/dd"
        return myDateFormatter.string(from: convertDate!)
    }

    func newsDate(date: String) -> String {
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let convertDate = dateFormatter.date(from: date)

        myDateFormatter.dateFormat = "yyyy년 M월 d일 (E) HH:mm"
        myDateFormatter.locale = Locale(identifier: "ko_KR")
        return myDateFormatter.string(from: convertDate!)
    }
}
