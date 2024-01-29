//
//  CustomWKWebView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/26/24.
//

import SwiftUI
import WebKit

struct CustomWKWebView: UIViewRepresentable {
    var url: String

    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            return WKWebView()
        }
        let webView = WKWebView()

        webView.load(URLRequest(url: url))

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<CustomWKWebView>) {
        guard let url = URL(string: url) else { return }

        webView.load(URLRequest(url: url))
    }
}

#Preview {
    CustomWKWebView(url: "https://www.newsis.com/view/NISX20240926_0002900734")
}
