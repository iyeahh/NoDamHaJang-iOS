//
//  SmokeData.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/23/24.
//

import SwiftUI

struct SmokingData {
    let date: String
    let goalCount: Int
    var smokeCount: Int

    var progress: Int {
        if smokeCount == 0 || goalCount == 0 {
            return 0
        } else {
            let value = Int((Double(smokeCount) / Double(goalCount)) * 100)
            return value
        }
    }

    var chartDate: String {
        DateFormatterManager.shared.chartDate(date: date)
    }

    var remaningCount: Int {
        goalCount - smokeCount
    }

    var isSuccess: String {
        goalCount >= smokeCount ? "성공" : "실패"
    }

    var color: Color {
        goalCount >= smokeCount ? .blue : .red
    }
}
