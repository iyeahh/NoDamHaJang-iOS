//
//  LinkListView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/26/24.
//

import SwiftUI
import LinkPresentation

struct LinkListView: View {
    @StateObject private var viewModel = LinkListViewModel()

    var body: some View {
        VStack {
            List(viewModel.output.newsItemList) { newsItem in
                VStack {
                    NavigationLink {
                        CustomWKWebView(url: newsItem.originallink)
                    } label: {
                        URLPreviewRow(
                            viewModel: PreviewViewModel(newsItem.originallink))
                    }
                }
                .onAppear {
                    if newsItem == viewModel.output.newsItemList.last {
                        viewModel.action(.lastIndex)
                    }
                }
                .listRowSeparator(.hidden)
            }
        }
        .toastView(toast: $viewModel.output.toast)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.action(.viewOnTask)
        }
    }
}

struct URLPreviewRow: View {
    @ObservedObject var viewModel: PreviewViewModel

    var body: some View {

        HStack(spacing: 15) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 90, maxHeight: 90)
                    .clipped()
                    .cornerRadius(16)
            }

            VStack(alignment: .leading, spacing: 1, content: {
                if let title = viewModel.title {
                    Text(title)
                        .font(.body)
                        .foregroundColor(Constant.ColorType.purple)
                        .multilineTextAlignment(.leading)
                }

                if let url = viewModel.url {
                    Text(url)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
            })
            .padding(.vertical, 10)
            .padding(.trailing, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100, alignment: .leading)
    }
}

struct LinkListView_Previews: PreviewProvider {
    static var previews: some View {
        LinkListView()
    }
}
