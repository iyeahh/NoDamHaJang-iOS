//
//  RoundedButton.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/28/24.
//

import Foundation
import SwiftUI

struct RoundedButton: View {
    let action: () -> Void
    let text: String

    var body: some View {
        Button(action: action,
               label: {
            RoundedRectangle(cornerRadius: 30)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                .overlay(alignment: Alignment(horizontal: .center, vertical: .center)) {
                    Text(text)
                        .foregroundStyle(.white)
                }
                .frame(height: 50)
        }
        )
    }
}
