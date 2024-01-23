//
//  HomeView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/19/24.
//

import SwiftUI

struct HomeView: View {
    @State private var smokeCount = 0
    @State private var progress = 80

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Constant.ColorType.accent)]
   }

    var body: some View {
        NavigationStack {
            VStack {
                smokeCountView()
                roundedRectangleView()
                Spacer()
                smokeButtonView()
            }
            .foregroundStyle(Constant.ColorType.purple)
            .background(Constant.ColorType.secondary.opacity(0.4))
            .navigationTitle("노담러의 하루")
        }
    }

    func smokeButtonView() -> some View {
        Button {
            smokeCount += 1
        } label: {
            RoundedRectangle(cornerRadius: 30)
                .padding()
                .frame(height: 80)
                .overlay(alignment: Alignment(horizontal: .center, vertical: .center)) {
                    Text("흡연했어요 🚬")
                        .foregroundStyle(.white)
                }
        }
    }

    func roundedRectangleView() -> some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(maxWidth: .infinity)
            .padding()
            .frame(height: UIScreen.main.bounds.width + 20)
            .foregroundStyle(Constant.ColorType.primary.opacity(0.5))
            .overlay(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                RoundProgressView(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width + 20, color1: Constant.ColorType.purple, color2: Constant.ColorType.secondary, percent: $progress)
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
            Text("\(smokeCount)번 흡연 중")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            HStack(spacing: 20) {
                Text("목표: 10번")
                Text("남은 횟수: 10번")
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
    @Binding var percent: Int
    
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
            Text("\(Int(percent))%")
                .font(.system(size : 14 * multiplier / 4))
                .fontWeight(.bold)
        }
    }
}