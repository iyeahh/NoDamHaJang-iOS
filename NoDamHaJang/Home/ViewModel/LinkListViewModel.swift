//
//  LinkListViewModel.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/26/24.
//

import SwiftUI
import Combine

final class LinkListViewModel: ViewModelType {
    var cancellables = Set<AnyCancellable>()

    var input = Input()
    @Published var output = Output()

    init() {
        transform()
    }
}

extension LinkListViewModel {
    struct Input {
        let viewOnTask = PassthroughSubject<Void, Never>()
    }

    struct Output {
        var newItemList: [NewsItems] = []
    }

    func transform() {
        input
            .viewOnTask
            .sink { [weak self] _ in
                guard let self else { return }
                NetworkManager.shared.callRequest(router: .fetchNews(index: 1)) { [weak self] (response: Result<News, NetworkError>) in
                    guard let self else { return }
                    switch response {
                    case .success(let success):
                        output.newItemList = success.items.map({ newsItem in
                            NewsItems(title: newsItem.title ?? "타이틀 없음", originallink: newsItem.originallink ?? "링크 없음", description: newsItem.description ?? "설명 없음", pubDate: newsItem.pubDate ?? "날짜 없음")
                        })
                    case .failure(let failure):
                        print("네크워킹 에러")
                    }
                }
            }
            .store(in: &cancellables)
    }
}

extension LinkListViewModel {
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
