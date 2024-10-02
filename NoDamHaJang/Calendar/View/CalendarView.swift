//
//  CalendarView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/19/24.
//

import SwiftUI
import FSCalendar

struct CalendarView: View {
    @StateObject private var viewModel = CalendarViewModel()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Constant.ColorType.accent)]
    }

    var body: some View {
        NavigationStack {
            calendarView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Constant.ColorType.secondary.opacity(0.4))
                .navigationTitle("노담러의 캘린더")
        }
    }

    func calendarView() -> some View {
        VStack {
            FSCalendarView(viewModel: viewModel)
                .frame(height: UIScreen.main.bounds.height - 300)
            descriptionView()
        }
        .padding(.top, 20)
    }

    func descriptionView() -> some View {
        HStack {
            Text("목표 \(viewModel.output.smokingData.goalCount)개  /")
                .foregroundStyle(Constant.ColorType.purple)
            Text("실행 \(viewModel.output.smokingData.smokeCount)개")
                .foregroundStyle(Constant.ColorType.purple)
            Spacer()
            Text("\(viewModel.output.smokingData.isSuccess)")
                .foregroundStyle(viewModel.output.smokingData.stringColor)
        }
        .padding()
    }
}
#Preview {
    CalendarView()
}
