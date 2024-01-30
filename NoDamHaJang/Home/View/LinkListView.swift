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
    @State var redrawPreview = false

    var body: some View {
        List(viewModel.output.newItemList) { l in
            VStack {
                NavigationLink {
                    CustomWKWebView(url: l.link)
                } label: {
                    LinkRow(previewURL: URL(string: l.link)!, redraw: self.$redrawPreview)
                }
            }
        }.environment(\.defaultMinListRowHeight, 50)
            .task {
                viewModel.action(.viewOnTask)
            }
    }
}

struct LinkRow: UIViewRepresentable {
    var previewURL: URL
    @Binding var redraw: Bool

    func makeUIView(context: Context) -> LPLinkView {
        let view = LPLinkView(url: previewURL)

        let provider = LPMetadataProvider()
        provider.startFetchingMetadata(for: previewURL) { metadata, error in
            if let md = metadata {
                DispatchQueue.main.async {
                    view.metadata = md
                    view.sizeToFit()
                    self.redraw.toggle()
                }
            } else if error != nil {
                let md = LPLinkMetadata()
                md.title = "Custom title"
                view.metadata = md
                view.sizeToFit()
                self.redraw.toggle()
            }
        }
        return view
    }

    func updateUIView(_ uiView: LPLinkView, context: Context) {

    }
}

struct LinkListView_Previews: PreviewProvider {
    static var previews: some View {
        LinkListView()
    }
}
