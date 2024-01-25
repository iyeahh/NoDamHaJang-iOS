//
//  SmokingTable.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/22/24.
//

import Foundation
import RealmSwift

final class SmokingTable: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var goalCount: Int
    @Persisted var smokeCount: Int = 0

    convenience init(goalCount: Int) {
        self.init()
        self.id = DateFormatterManager.shared.dateFormat()
        self.goalCount = goalCount
    }
}
