//
//  CalendarViewModel.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/23/24.
//

import SwiftUI
import Combine
import RealmSwift

final class CalendarViewModel: ViewModelType {
    var cancellables = Set<AnyCancellable>()

    var input = Input()
    @Published var output = Output()

    init() {
        transform()
    }
}

extension CalendarViewModel {
    struct Input {
        let seletedDate = PassthroughSubject<String, Never>()
    }

    struct Output { 
        var smokingData: SmokingData = SmokingData(date: DateFormatterManager.shared.dateFormat(), goalCount: SmokingTableRepository.shared.fetchGoalCount(), smokeCount: SmokingTableRepository.shared.fetchSmokeCount())
    }

    func transform() {
        input
            .seletedDate
            .sink { [weak self] selectedDate in
                guard let self else { return }
                output.smokingData = SmokingTableRepository.shared.getSmokingData(date: selectedDate)
            }
            .store(in: &cancellables)
    }
}

extension CalendarViewModel {
    enum Action {
        case seletedDate(date: String)
    }

    func action(_ action: Action) {
        switch action {
        case .seletedDate(let date):
            input.seletedDate.send(date)
        }
    }
}
