//
//  PreviewViewModel.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/26/24.
//

import SwiftUI
import LinkPresentation
import UniformTypeIdentifiers

final class PreviewViewModel: ObservableObject {

    @Published var image: UIImage?
    @Published var title: String?
    @Published var url: String?

    let previewURL: URL?

    init(_ url: String) {
        self.previewURL = URL(string: url)
        fetchMetadata()
    }

    private func fetchMetadata() {
        guard let previewURL else {
            print("Invalid preview URL.")
            return
        }

        let provider = LPMetadataProvider()

        Task {
            do {
                let metadata = try await provider.startFetchingMetadata(for: previewURL)

                if let imageProvider = metadata.imageProvider {
                    let fetchedImage = try await convertToImage(imageProvider)
                    await MainActor.run {
                        image = fetchedImage
                    }
                } else {
                    print("No image provider available.")
                }

                await MainActor.run {
                    title = metadata.title ?? "No title"
                    url = metadata.url?.host() ?? "No URL"
                }
            } catch {
                print("Failed to fetch metadata: \(error.localizedDescription)")
                await MainActor.run {
                    image = nil
                    title = "데이터가 원활하지 않습니다."
                    url = nil
                }
            }
        }
    }

    private func convertToImage(_ imageProvider: NSItemProvider?) async throws -> UIImage? {
        guard let imageProvider = imageProvider else {
            print("No image provider available.")
            return nil
        }

        let type = String(describing: UTType.image)

        if imageProvider.hasItemConformingToTypeIdentifier(type) {
            do {
                let item = try await imageProvider.loadItem(forTypeIdentifier: type)

                if let uiImage = item as? UIImage {
                    return uiImage
                } else if let url = item as? URL {
                    if let data = try? Data(contentsOf: url) {
                        return UIImage(data: data)
                    }
                } else if let data = item as? Data {
                    return UIImage(data: data)
                } else {
                    print("Item is neither UIImage, URL, nor Data.")
                }
            } catch {
                print("Failed to convert image: \(error.localizedDescription)")
            }
        } else {
            print("Item does not conform to image type identifier.")
        }
        return nil
    }
}
