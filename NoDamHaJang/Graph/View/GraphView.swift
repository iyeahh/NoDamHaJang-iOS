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
            VStack {
                chartView()
                descriptionView()
                Spacer()
            }
                .background(Constant.ColorType.secondary.opacity(0.4))
                .navigationTitle("흡연 횟수 추이")
        }
        .task {
            viewModel.action(.viewOnTask)
        }
    }

    func descriptionView() -> some View {
        VStack(spacing: 20) {
            roundedRectangleView(text: "하루 평균 \(viewModel.output.averageSmokeCount)회 흡연")
            roundedRectangleView(text: "평균 성공률 \(viewModel.output.averageSuccess)% 달성")
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 20)
    }

    func roundedRectangleView(text: String) -> some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .foregroundStyle(Constant.ColorType.purple)
            .overlay(alignment: Alignment(horizontal: .center, vertical: .center)) {
                Text(text)
            }
    }

    func chartView() -> some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(maxWidth: .infinity)
            .padding()
            .frame(height: UIScreen.main.bounds.width + 20)
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
