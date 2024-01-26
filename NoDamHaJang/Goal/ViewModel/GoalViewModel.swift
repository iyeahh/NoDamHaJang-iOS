//
//  GoalViewModel.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/22/24.
//

import SwiftUI
import Combine
import RealmSwift

final class GoalViewModel: ViewModelType {
    var cancellables = Set<AnyCancellable>()

    var input = Input()
    @Published var output = Output()

    init() {
        transform()
    }
}

extension GoalViewModel {
    struct Input {
        let setGoalButtonTapped = PassthroughSubject<Int, Never>()
    }

    struct Output { }

    func transform() {
        input
            .setGoalButtonTapped
            .sink { smokeCount in
                SmokingTableRepository.shared.checkSmokingTable(goalCount: smokeCount)
            }
            .store(in: &cancellables)
    }
}

extension GoalViewModel {
    enum Action {
        case setGoalButtonTapped(smokeCount: Int)
    }

    func action(_ action: Action) {
        switch action {
        case .setGoalButtonTapped(let smokeCount):
            input.setGoalButtonTapped.send(smokeCount)
        }
    }
}
