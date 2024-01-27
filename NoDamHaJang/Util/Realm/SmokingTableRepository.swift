//
//  SmokingTableRepository.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/22/24.
//

import Foundation
import RealmSwift

final class SmokingTableRepository {
    static let shared = SmokingTableRepository()
    private let realm = try! Realm()

    private init() { }

    func readSmokingTable() -> [SmokingTable] {
        let list = realm.objects(SmokingTable.self)
        return list.sorted {
            $0.id > $1.id
        }
    }

    func fetchSmokeCount() -> Int {
        let data = readSmokingTable().filter {
            $0.id == DateFormatterManager.shared.dateFormat()
        }
        return data.first?.smokeCount ?? 0
    }

    func fetchGoalCount() -> Int {
        let data = readSmokingTable().filter {
            $0.id == DateFormatterManager.shared.dateFormat()
        }
        return data.first?.goalCount ?? 0
    }

    func createSmokingTable(goalCount: Int) {
        do {
            try realm.write {
                realm.add(SmokingTable(goalCount: goalCount))
            }
        } catch {
            print("목표 설정이 저장되지 않았어요")
        }
    }

    func editGoalCount(id: String, goalCount: Int) {
        do {
            try realm.write {
                realm.create(
                    SmokingTable.self,
                    value: ["id": id,
                            "goalCount": goalCount],
                    update: .modified
                )
            }
        } catch {
            print("목표 설정이 변경되지 않았어요")
        }
    }

    func checkSmokingTable(goalCount: Int) {
        let data = readSmokingTable().filter {
            $0.id == DateFormatterManager.shared.dateFormat()
        }

        if data.count == 0 {
            createSmokingTable(goalCount: goalCount)
        } else {
            editGoalCount(id: DateFormatterManager.shared.dateFormat(), goalCount: goalCount)
        }
    }

    func getSmokingData(date: String) -> SmokingData {
        let data = readSmokingTable().filter {
            $0.id == date
        }
        return SmokingData(goalCount: data.first?.goalCount ?? 0, smokeCount: data.first?.smokeCount ?? 0)
    }

    func editSmokeCount(smokeCount: Int) {
        do {
            try realm.write {
                realm.create(
                    SmokingTable.self,
                    value: ["id": DateFormatterManager.shared.dateFormat(),
                            "smokeCount": smokeCount],
                    update: .modified
                )
            }
        } catch {
            print("흡연 횟수가 변경되지 않았어요")
        }
    }

}
