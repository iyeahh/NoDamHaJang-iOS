//
//  HomeViewModel.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/22/24.
//

import SwiftUI
import Combine
import RealmSwift

final class HomeViewModel: ViewModelType {
    var cancellables = Set<AnyCancellable>()

    var input = Input()
    @Published var output = Output()

    init() {
        transform()
    }
}

extension HomeViewModel {
    struct Input {
        let viewOnTask = PassthroughSubject<Void, Never>()
        let addSmokeButtonTapped = PassthroughSubject<Void, Never>()
    }

    struct Output {
        var smokeCount = 0
        var goalCount = 0
        var progress = 0
    }

    func transform() {
        input
            .viewOnTask
            .sink { [weak self] _ in
                guard let self else { return }
                output.goalCount = SmokingTableRepository.shared.fetchGoalCount()
                output.smokeCount = SmokingTableRepository.shared.fetchSmokeCount()
                if output.smokeCount == 0 || output.goalCount == 0 {
                    output.progress = 0
                } else {
                    let value = Int((Double(output.smokeCount) / Double(output.goalCount)) * 100)
                    output.progress = value
                }
            }
            .store(in: &cancellables)

        input
            .addSmokeButtonTapped
            .sink { [weak self] _ in
                guard let self else { return }
                output.smokeCount += 1
                SmokingTableRepository.shared.editSmokeCount(smokeCount: output.smokeCount)
                if output.smokeCount == 0 || output.goalCount == 0 {
                    output.progress = 0
                } else {
                    let value = Int((Double(output.smokeCount) / Double(output.goalCount)) * 100)
                    output.progress = value
                }
            }
            .store(in: &cancellables)
    }
}

extension HomeViewModel {
    enum Action {
        case addSmokeButtonTapped
        case viewOnTask
    }

    func action(_ action: Action) {
        switch action {
        case .viewOnTask:
            input.viewOnTask.send(())
        case .addSmokeButtonTapped:
            input.addSmokeButtonTapped.send(())
        }
    }
}
