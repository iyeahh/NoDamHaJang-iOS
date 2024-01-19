//
//  TabBarView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/19/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            GraphView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis.ascending")
                    Text("Graph")
                }
            GoalView()
                .tabItem {
                    Image(systemName: "person.fill.checkmark")
                    Text("Goal")
                }
        }
    }
}

#Preview {
    TabBarView()
}
