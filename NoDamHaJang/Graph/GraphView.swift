//
//  GraphView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/19/24.
//

import SwiftUI
import Charts

struct SmokeData {
    let date: Int
    let goal: Int
    let smokeCount: Int
}

let smokeData = [
    SmokeData(date: 0, goal: 10, smokeCount: 9),
    SmokeData(date: 1, goal: 10, smokeCount: 8),
    SmokeData(date: 2, goal: 10, smokeCount: 7),
    SmokeData(date: 3, goal: 10, smokeCount: 6),
    SmokeData(date: 4, goal: 10, smokeCount: 5),
    SmokeData(date: 5, goal: 10, smokeCount: 4),
    SmokeData(date: 6, goal: 10, smokeCount: 3),
    SmokeData(date: 7, goal: 10, smokeCount: 2)
]

struct GraphView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Constant.ColorType.accent)]
    }

    var body: some View {
        NavigationStack {
            VStack {
                chartView()
                descriptionView()
                Spacer()
            }
                .background(Constant.ColorType.secondary.opacity(0.4))
                .navigationTitle("흡연 횟수 추이")
        }
    }

    func descriptionView() -> some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 30)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .foregroundStyle(Constant.ColorType.purple)
                .overlay(alignment: Alignment(horizontal: .center, vertical: .center)) {
                    Text("하루 평균 5회 흡연")
                }
            RoundedRectangle(cornerRadius: 30)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .foregroundStyle(Constant.ColorType.purple)
                .overlay(alignment: Alignment(horizontal: .center, vertical: .center)) {
                    Text("평균 성공률 50% 달성")
                }
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 20)
    }

    func chartView() -> some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(maxWidth: .infinity)
            .padding()
            .frame(height: UIScreen.main.bounds.width + 20)
            .foregroundStyle(Constant.ColorType.primary.opacity(0.5))
            .overlay {
                Chart(smokeData, id: \.date) { element in
                    BarMark(x: .value("날짜", element.date), y: .value("흡연횟수", element.smokeCount))
                }
                .foregroundStyle(Constant.ColorType.purple)
                .frame(height: 200)
                .padding(.horizontal, 40)
            }
    }
}

#Preview {
    GraphView()
}
