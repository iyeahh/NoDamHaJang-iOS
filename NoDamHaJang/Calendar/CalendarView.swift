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
            VStack {
                FSCalendarView()
                    .frame(height: 500)
            }
            .padding(.top, 20)
            .background(Constant.ColorType.secondary.opacity(0.4))
            Spacer()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Constant.ColorType.secondary.opacity(0.4))
            .navigationTitle("노담러의 캘린더")
        }
    }
}
#Preview {
    CalendarView()
}
