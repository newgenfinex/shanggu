import SwiftUI
import UniformTypeIdentifiers

struct SaveDocumentView: View {
    @ObservedObject var documentManager: DocumentManager
    @Environment(\.presentationMode) var presentationMode
    @State private var showingShareSheet = false
    @State private var showingFilePicker = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "doc.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                    .padding()

                Text("Save Document")
                    .font(.title2)
                    .fontWeight(.bold)

                VStack(spacing: 15) {
                    Button(action: {
                        showingShareSheet = true
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title3)
                            Text("Share PDF")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    }

                    Button(action: {
                        showingFilePicker = true
                    }) {
                        HStack {
                            Image(systemName: "folder")
                                .font(.title3)
                            Text("Save to Files")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .navigationBarItems(
                trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .sheet(isPresented: $showingShareSheet) {
            if let url = createTemporaryPDF() {
                ShareSheet(items: [url])
            }
        }
        .sheet(isPresented: $showingFilePicker) {
            SaveFilePicker(documentManager: documentManager)
        }
    }

    private func createTemporaryPDF() -> URL? {
        guard let document = documentManager.currentDocument else { return nil }

        let tempDir = FileManager.default.temporaryDirectory
        let fileName = "document-\(Date().timeIntervalSince1970).pdf"
        let fileURL = tempDir.appendingPathComponent(fileName)

        document.write(to: fileURL)
        return fileURL
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}

struct SaveFilePicker: UIViewControllerRepresentable {
    @ObservedObject var documentManager: DocumentManager
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let tempURL = createTemporaryPDF()
        let picker = UIDocumentPickerViewController(forExporting: [tempURL])
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    private func createTemporaryPDF() -> URL {
        let tempDir = FileManager.default.temporaryDirectory
        let fileName = "document-\(Date().timeIntervalSince1970).pdf"
        let fileURL = tempDir.appendingPathComponent(fileName)

        documentManager.currentDocument?.write(to: fileURL)
        return fileURL
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: SaveFilePicker

        init(_ parent: SaveFilePicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.presentationMode.wrappedValue.dismiss()
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
