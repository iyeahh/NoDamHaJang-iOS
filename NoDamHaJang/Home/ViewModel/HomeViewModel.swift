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
        var smokingData = SmokingData(goalCount: 0, smokeCount: 0)
    }

    func transform() {
        input
            .viewOnTask
            .sink { [weak self] _ in
                guard let self else { return }
                let goalCount = SmokingTableRepository.shared.fetchGoalCount()
                let smokeCount = SmokingTableRepository.shared.fetchSmokeCount()
                output.smokingData = SmokingData(goalCount: goalCount, smokeCount: smokeCount)
            }
            .store(in: &cancellables)

        input
            .addSmokeButtonTapped
            .sink { [weak self] _ in
                guard let self else { return }
                output.smokingData.smokeCount += 1
                SmokingTableRepository.shared.editSmokeCount(smokeCount: output.smokingData.smokeCount)
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
