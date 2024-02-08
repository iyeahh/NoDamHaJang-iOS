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
            RoundedButton(
                action: {viewModel.action(.setGoalButtonTapped(smokeCount: selectedNumber))
                    toast = FancyToast(title: "목표 설정".localized, message: "목표 설정이 완료되었어요!".localized)
                }, text: "목표 설정".localized
            )
        }
        .toastView(toast: $toast)
    }
}
