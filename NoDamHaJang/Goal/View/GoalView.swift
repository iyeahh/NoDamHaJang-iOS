//
//  GoalView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/19/24.
//

import SwiftUI
import RealmSwift

struct GoalView: View {
    @State var selectedNumber = 0
    @StateObject private var viewModel = GoalViewModel()

    var body: some View {
        VStack {
            setGoalView()
            pickerView()
            Spacer()
            ToastBasicView(viewModel: viewModel, selectedNumber: selectedNumber)
        }
        .foregroundStyle(Constant.ColorType.purple)
        .background(Constant.ColorType.secondary.opacity(0.4))
    }

    func pickerView() -> some View {
        VStack {
            Picker("횟수를 정해주세요", selection: $selectedNumber) {
                ForEach(0..<60, id: \.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(.wheel)
            .background(Constant.ColorType.primary.opacity(0.5))
            .cornerRadius(15)
            .padding()

            Text("한달이면 \((selectedNumber * 250 * 30).formatted())원을 절약할 수 있어요!")
        }
    }

    func setGoalView() -> some View {
        VStack(spacing: 10) {
            Text("목표 정하기")
                .bold()
                .font(.largeTitle)
            Text("하루 동안의 흡연 횟수를 정해보아요!")
        }
        .padding(.top, 50)
    }
}

#Preview {
    GoalView()
}
