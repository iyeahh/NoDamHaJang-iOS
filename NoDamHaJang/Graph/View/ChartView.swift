//
//  ChartView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 10/6/24.
//

import SwiftUI
import Charts

struct ChartView: View {
  var smokingDataList: [SmokingData]

  private var areaBackground: Gradient {
      return Gradient(colors: [Constant.ColorType.accent, Constant.ColorType.accent.opacity(0.1)])
  }

  var body: some View {
      RoundedRectangle(cornerRadius: 30)
          .frame(width: UIScreen.main.bounds.width - 60)
          .padding()
          .frame(height: UIScreen.main.bounds.width - 60)
          .foregroundStyle(Constant.ColorType.primary.opacity(0.5))
          .overlay {
              Chart(smokingDataList) {
                  LineMark(
                    x: .value("날짜", $0.chartDate),
                    y: .value("흡연 횟수", $0.smokeCount)
                  )
                  .symbol(.circle)
                  .interpolationMethod(.catmullRom)

                  AreaMark(
                    x: .value("날짜", $0.chartDate),
                    y: .value("흡연 횟수", $0.smokeCount)
                  )
                  .interpolationMethod(.catmullRom)
                  .foregroundStyle(areaBackground)
              }
              .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
              .padding()
          }
  }
}
