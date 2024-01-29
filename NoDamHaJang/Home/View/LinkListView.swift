//
//  LinkListView.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/26/24.
//

import SwiftUI
import LinkPresentation

struct LinkListView: View {

    @State var redrawPreview = false

    let links: [StringLink] = [
        StringLink(string: "https://www.newsis.com/view/NISX20240926_0002900734")
    ]

    var body: some View {
        List(links) { l in
            VStack {
                NavigationLink {
                    CustomWKWebView(url: "https://www.newsis.com/view/NISX20240926_0002900734")
                } label: {
                    LinkRow(previewURL: URL(string: l.string)!, redraw: self.$redrawPreview)
                }
            }
        }.environment(\.defaultMinListRowHeight, 50)
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

struct StringLink: Identifiable {
    var id = UUID()
    var string: String
}

struct LinkListView_Previews: PreviewProvider {
    static var previews: some View {
        LinkListView()
    }
}
