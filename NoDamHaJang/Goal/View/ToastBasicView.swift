//
//  ToastBasicView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/28/24.
//

import SwiftUI

struct ToastBasicView: View {
    @State private var toast: FancyToast? = nil
    let viewModel: GoalViewModel
    let selectedNumber: Int

    var body: some View {
        VStack {
            Button {
                viewModel.action(.setGoalButtonTapped(smokeCount: selectedNumber))
                toast = FancyToast(title: "목표 설정", message: "목표 설정이 완료되었어요!")
            } label: {
                RoundedRectangle(cornerRadius: 30)
                    .padding()
                    .frame(height: 80)
                    .overlay(alignment: Alignment(horizontal: .center, vertical: .center)) {
                        Text("목표 설정")
                            .foregroundStyle(.white)
                    }
            }
        }
        .toastView(toast: $toast)
    }
}
