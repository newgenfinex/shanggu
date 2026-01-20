import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @StateObject private var documentManager = DocumentManager()
    @State private var showingDocumentPicker = false
    @State private var showingWelcome = true

    var body: some View {
        NavigationView {
            if showingWelcome && documentManager.currentDocument == nil {
                WelcomeView(onImportTapped: {
                    showingDocumentPicker = true
                    showingWelcome = false
                })
            } else if let document = documentManager.currentDocument {
                PDFEditorView(document: document, documentManager: documentManager)
            } else {
                VStack(spacing: 20) {
                    Image(systemName: "doc.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)

                    Text("No Document Open")
                        .font(.title2)
                        .fontWeight(.medium)

                    Button(action: {
                        showingDocumentPicker = true
                    }) {
                        Label("Import PDF", systemImage: "square.and.arrow.down")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .sheet(isPresented: $showingDocumentPicker) {
            DocumentPicker(documentManager: documentManager)
        }
    }
}

struct WelcomeView: View {
    let onImportTapped: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Image(systemName: "doc.text.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)

            Text("PDF Fill & Sign")
                .font(.system(size: 36, weight: .bold))

            Text("Fill forms, add text, and sign PDFs")
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            VStack(spacing: 15) {
                FeatureRow(icon: "pencil", title: "Fill Forms", description: "Complete PDF forms quickly")
                FeatureRow(icon: "signature", title: "Add Signature", description: "Sign documents with your finger")
                FeatureRow(icon: "textformat", title: "Add Text", description: "Type anywhere on the page")
                FeatureRow(icon: "checkmark.circle", title: "Checkmarks", description: "Add checkmarks and symbols")
            }
            .padding()

            Spacer()

            Button(action: onImportTapped) {
                Label("Import PDF to Get Started", systemImage: "square.and.arrow.down")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
    }
}
