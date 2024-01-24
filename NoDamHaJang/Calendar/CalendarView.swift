//
//  CalendarView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/19/24.
//

import SwiftUI
import FSCalendar

struct CalendarView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Constant.ColorType.accent)]
   }
    
    var body: some View {
        NavigationStack {
            calendarView()
            Spacer()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Constant.ColorType.secondary.opacity(0.4))
            .navigationTitle("노담러의 캘린더")
        }
    }

    func calendarView() -> some View {
        VStack {
            FSCalendarView()
                .frame(height: 500)
            descriptionView()
        }
        .padding(.top, 20)
        .background(Constant.ColorType.secondary.opacity(0.4))
    }

    func descriptionView() -> some View {
        HStack {
            Text("목표 10개  /")
                .foregroundStyle(Constant.ColorType.purple)
            Text("실행 10개")
                .foregroundStyle(Constant.ColorType.purple)
            Spacer()
            Text("성공")
                .foregroundStyle(.blue)
        }
        .padding()
    }
}
#Preview {
    CalendarView()
}
