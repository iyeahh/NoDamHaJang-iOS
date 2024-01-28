//
//  GraphViewModel.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/25/24.
//

import SwiftUI
import Combine
import RealmSwift

final class GraphViewModel: ViewModelType {
    var cancellables = Set<AnyCancellable>()

    var input = Input()
    @Published var output = Output()

    init() {
        transform()
    }
}

extension GraphViewModel {
    struct Input {
        let viewOnTask = PassthroughSubject<Void, Never>()
    }

    struct Output { 
        var smokingDataList: [SmokingData] = []
        var averageSmokeCount: Int = 0
        var averageSuccess: Int = 0
    }

    func transform() {
        input
            .viewOnTask
            .sink { [weak self] smokeCount in
                guard let self else { return }
                output.smokingDataList = SmokingTableRepository.shared.readOneWeekSmokingTable()
                let value = averageSmokeCount()
                output.averageSmokeCount = value.0
                output.averageSuccess = value.1
            }
            .store(in: &cancellables)
    }

    func averageSmokeCount() -> (Int, Int) {
        var smokeCountList: [Int] = []
        var isSuccessList: [Bool] = []
        output.smokingDataList.forEach { smokingData in
            smokeCountList.append(smokingData.smokeCount)
            let isSuccess = smokingData.progress <= 100 ? true : false
            isSuccessList.append(isSuccess)
        }
        let allSmokeCount = smokeCountList.reduce(0) { $0 + $1 }
        let successList = isSuccessList.filter { $0 == true }

        let averageSmokeCount = Int(Double(allSmokeCount) / 7.0)
        let successPercentage = Int((Double(successList.count) / 7.0) * 100)

        return (averageSmokeCount, successPercentage)
    }
}

extension GraphViewModel {
    enum Action {
        case viewOnTask
    }

    func action(_ action: Action) {
        switch action {
        case .viewOnTask:
            input.viewOnTask.send(())
        }
    }
}
