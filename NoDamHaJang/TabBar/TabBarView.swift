//
//  TabBarView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/19/24.
//

import SwiftUI

private enum TabBar: CaseIterable {
    case home
    case calendar
    case graph
    case goal

    var image: Image {
        switch self {
        case .home:
            Image(systemName: "house.fill")
        case .calendar:
            Image(systemName: "calendar")
        case .graph:
            Image(systemName: "chart.bar.xaxis.ascending")
        case .goal:
            Image(systemName: "person.fill.checkmark")
        }
    }

    var title: String {
        switch self {
        case .home:
            "Home"
        case .calendar:
            "Calendar"
        case .graph:
            "Graph"
        case .goal:
            "Goal"
        }
    }
}

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    TabBar.home.image
                    Text(TabBar.home.title)
                }
            CalendarView()
                .tabItem {
                    TabBar.calendar.image
                    Text(TabBar.calendar.title)
                }
            GraphView()
                .tabItem {
                    TabBar.graph.image
                    Text(TabBar.graph.title)
                }
            GoalView()
                .tabItem {
                    TabBar.goal.image
                    Text(TabBar.goal.title)
                }
        }
        .accentColor(Constant.ColorType.purple)
    }
}

#Preview {
    TabBarView()
}
