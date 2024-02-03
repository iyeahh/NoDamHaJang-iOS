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
    @StateObject var viewModel: CalendarViewModel

    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var parent: FSCalendarView

        init(parent: FSCalendarView) {
            self.parent = parent
        }

        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            let dateString = formatter.string(from: date)

            parent.viewModel.action(.seletedDate(date: dateString))
        }

        // 커스텀 셀 사용 설정
        func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
            let cell = calendar.dequeueReusableCell(withIdentifier: "CustomCalendarCell", for: date, at: position) as! CustomCalendarCell

            cell.smokeCountLabel.text = ""

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            let dateString = formatter.string(from: date)

            let array = SmokingTableRepository.shared.readSmokingTable()

            array.forEach { smokingTable in
                if dateString == smokingTable.id {
                    cell.smokeCountLabel.text = "\(smokingTable.smokeCount)번"
                }
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
            smokeCountLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            smokeCountLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

        smokeCountLabel.font = UIFont.systemFont(ofSize: 10)
        smokeCountLabel.textColor = UIColor(Constant.ColorType.purple)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
