//
//  HomeView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/19/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Constant.ColorType.accent)]
   }

    var body: some View {
        NavigationStack {
            homeView()
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        NavigationLink("금연 기사 보기") {
                            LinkListView()
                        }
                    }
                }
            .navigationTitle("노담러의 하루")
        }
        .task {
            viewModel.action(.viewOnTask)
        }
    }

    func homeView() -> some View {
        VStack {
            smokeCountView()
            roundedRectangleView()
            Spacer()
            RoundedButton(
                action: { viewModel.action(.addSmokeButtonTapped) },
                text: "흡연했어요 🚬"
            )
        }
        .foregroundStyle(Constant.ColorType.purple)
        .background(Constant.ColorType.secondary.opacity(0.4))
    }

    func roundedRectangleView() -> some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(maxWidth: .infinity)
            .padding()
            .frame(height: UIScreen.main.bounds.width + 20)
            .foregroundStyle(Constant.ColorType.primary.opacity(0.5))
            .overlay(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                RoundProgressView(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width + 20, color1: viewModel.output.smokingData.progress > 100 ? Constant.ColorType.red : Constant.ColorType.purple, color2: viewModel.output.smokingData.progress > 100 ? Constant.ColorType.ivory : Constant.ColorType.secondary, percent: viewModel.output.smokingData.progress)
                    .padding(.top, 50)
            })
            .overlay(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                VStack(alignment: .leading) {
                    Text("목표를 지켜봐요!")
                    Text("내일의 목표는 1번 더 줄이기")
                        .foregroundStyle(.secondary)
                }
                .padding(.leading, 40)
                .padding(.top, 40)
            }
    }

    func smokeCountView() -> some View {
        VStack(spacing: 10) {
            Text("\(viewModel.output.smokingData.smokeCount)번 흡연 중")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            HStack(spacing: 20) {
                Text("목표: \(viewModel.output.smokingData.goalCount)번")
                Text(viewModel.output.smokingData.remaningCount < 0 ? "초과 횟수: \(abs(viewModel.output.smokingData.remaningCount))번" : "남은 횟수: \(viewModel.output.smokingData.remaningCount)번")
                    .foregroundStyle(viewModel.output.smokingData.remaningCount < 0 ? Constant.ColorType.red : Constant.ColorType.purple)
            }
            .font(.title3)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
        }
        .padding(.top, 20)
    }
}

#Preview {
    HomeView()
}

struct RoundProgressView : View {
    var width: CGFloat
    var height: CGFloat
    var color1: Color
    var color2: Color
    var percent: Int

    var body: some View {
        let multiplier = width / 40
        let progress = 1 - (CGFloat(percent) / 100)

        return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier / 2, lineCap: .round))
                .frame(width: width/2, height: height/2)

            Circle()
            .trim(from: progress, to: 1)
            .stroke(
                LinearGradient(
                    gradient: Gradient(colors: [color1, color2]), startPoint: .topLeading, endPoint: .bottomTrailing),
                style: StrokeStyle(lineWidth: 5 * multiplier / 2, lineCap: .round))
            .frame(width: width/2, height: height/2)
            .rotationEffect(Angle(degrees: 90))
            .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
            .shadow(color: color2, radius: 14 * multiplier, x: 0.0, y: 14 * multiplier)
            Text("\(percent)%")
                .font(.system(size : 14 * multiplier / 4))
                .fontWeight(.bold)
                .foregroundStyle(percent > 100 ? Constant.ColorType.red : Constant.ColorType.purple)
        }
    }
}
