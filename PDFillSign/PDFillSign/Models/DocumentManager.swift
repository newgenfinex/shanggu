import SwiftUI
import PDFKit
import UniformTypeIdentifiers

class DocumentManager: ObservableObject {
    @Published var currentDocument: PDFDocument?
    @Published var documentURL: URL?
    @Published var recentDocuments: [URL] = []

    func loadDocument(from url: URL) {
        guard url.startAccessingSecurityScopedResource() else {
            print("Failed to access security scoped resource")
            return
        }

        defer { url.stopAccessingSecurityScopedResource() }

        if let document = PDFDocument(url: url) {
            DispatchQueue.main.async {
                self.currentDocument = document
                self.documentURL = url
                self.addToRecentDocuments(url)
            }
        }
    }

    func saveDocument(to url: URL) {
        guard let document = currentDocument else { return }

        guard url.startAccessingSecurityScopedResource() else {
            print("Failed to access security scoped resource")
            return
        }

        defer { url.stopAccessingSecurityScopedResource() }

        document.write(to: url)
    }

    func createNewDocument() {
        let document = PDFDocument()
        DispatchQueue.main.async {
            self.currentDocument = document
            self.documentURL = nil
        }
    }

    private func addToRecentDocuments(_ url: URL) {
        if !recentDocuments.contains(url) {
            recentDocuments.insert(url, at: 0)
            if recentDocuments.count > 10 {
                recentDocuments.removeLast()
            }
        }
    }

    func closeDocument() {
        currentDocument = nil
        documentURL = nil
    }
}
