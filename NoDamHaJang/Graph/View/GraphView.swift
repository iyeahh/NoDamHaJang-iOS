//
//  GraphView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/19/24.
//

import SwiftUI
import Charts

struct GraphView: View {
    @StateObject private var viewModel = GraphViewModel()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Constant.ColorType.accent)]
    }

    var body: some View {
        NavigationStack {
            GraphView()
                .navigationTitle("흡연 횟수 추이")
                .background(Constant.ColorType.secondary.opacity(0.4))
        }
        .task {
            viewModel.action(.viewOnTask)
        }
    }

    func GraphView() -> some View {
        VStack {
            chartView()
            descriptionView()
            Spacer()
        }
        .padding()
    }

    func descriptionView() -> some View {
        VStack(spacing: 20) {
            roundedRectangleView(text: "하루 평균 \(viewModel.output.averageSmokeCount)회 흡연".localized)
            roundedRectangleView(text: "평균 성공률 \(viewModel.output.averageSuccess)% 달성".localized)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 20)
    }

    func roundedRectangleView(text: String) -> some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(width: UIScreen.main.bounds.width - 60)
            .frame(height: 50)
            .foregroundStyle(Constant.ColorType.purple)
            .overlay(alignment: Alignment(horizontal: .center, vertical: .center)) {
                Text(text)
            }
    }

    func chartView() -> some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(width: UIScreen.main.bounds.width - 60)
            .padding()
            .frame(height: UIScreen.main.bounds.width - 60)
            .foregroundStyle(Constant.ColorType.primary.opacity(0.5))
            .overlay {
                Chart(viewModel.output.smokingDataList, id: \.date) { element in
                    BarMark(x: .value("날짜", element.chartDate), y: .value("흡연횟수", element.smokeCount))
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
