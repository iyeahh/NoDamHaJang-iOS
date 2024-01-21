//
//  FSCalendarView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/20/24.
//

import FSCalendar
import SwiftUI
import UIKit

struct FSCalendarView: UIViewRepresentable {
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var parent: FSCalendarView

        init(parent: FSCalendarView) {
            self.parent = parent
        }

        // 커스텀 셀 사용 설정
        func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
            let cell = calendar.dequeueReusableCell(withIdentifier: "CustomCalendarCell", for: date, at: position) as! CustomCalendarCell

            // 특정 날짜에 텍스트 추가
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: date)

            if dateString == "2024-09-20" {
                cell.smokeCountLabel.text = "Event"
            } else {
                cell.smokeCountLabel.text = ""
            }

            return cell
        }
    }

    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "CustomCalendarCell")

        let appearance = calendar.appearance
        appearance.headerTitleColor = UIColor(Constant.ColorType.purple)
        appearance.weekdayTextColor = UIColor(Constant.ColorType.purple)
        appearance.selectionColor = UIColor(Constant.ColorType.accent.opacity(0.5))
        appearance.todayColor = UIColor(Constant.ColorType.accent)
        appearance.titleWeekendColor = .red
        calendar.backgroundColor = UIColor(Constant.ColorType.primary.opacity(0.5))

        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}

class CustomCalendarCell: FSCalendarCell {
    let smokeCountLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(smokeCountLabel)

        smokeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            smokeCountLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2), // 날짜 밑에 배치
            smokeCountLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

        smokeCountLabel.font = UIFont.systemFont(ofSize: 10)
        smokeCountLabel.textColor = .gray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
