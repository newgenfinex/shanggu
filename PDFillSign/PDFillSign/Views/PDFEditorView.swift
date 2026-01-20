import SwiftUI
import PDFKit

struct PDFEditorView: View {
    let document: PDFDocument
    @ObservedObject var documentManager: DocumentManager
    @StateObject private var annotationModel = AnnotationModel()
    @State private var showingToolbar = true
    @State private var showingSignatureView = false
    @State private var showingTextInput = false
    @State private var textToAdd = ""
    @State private var selectedPoint: CGPoint?
    @State private var selectedPage: PDFPage?
    @State private var showingSaveDialog = false

    var body: some View {
        VStack(spacing: 0) {
            if showingToolbar {
                ToolbarView(
                    annotationModel: annotationModel,
                    onSignatureTapped: { showingSignatureView = true },
                    onSaveTapped: { showingSaveDialog = true },
                    onCloseTapped: { documentManager.closeDocument() }
                )
            }

            PDFViewWrapper(
                document: document,
                annotationModel: annotationModel,
                onTap: handleTap
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .sheet(isPresented: $showingSignatureView) {
            SignatureView(annotationModel: annotationModel)
        }
        .sheet(isPresented: $showingTextInput) {
            TextInputView(text: $textToAdd, onAdd: addTextAnnotation)
        }
        .sheet(isPresented: $showingSaveDialog) {
            SaveDocumentView(documentManager: documentManager)
        }
    }

    private func handleTap(at point: CGPoint, on page: PDFPage) {
        switch annotationModel.currentTool {
        case .text:
            selectedPoint = point
            selectedPage = page
            showingTextInput = true

        case .checkmark:
            let annotation = annotationModel.createCheckmarkAnnotation(at: point, in: page)
            page.addAnnotation(annotation)

        case .circle:
            let annotation = annotationModel.createCircleAnnotation(at: point, in: page)
            page.addAnnotation(annotation)

        case .signature:
            if let signature = annotationModel.savedSignature,
               let annotation = annotationModel.createSignatureAnnotation(at: point, in: page, signature: signature) {
                page.addAnnotation(annotation)
            } else {
                showingSignatureView = true
            }

        case .none, .highlight:
            break
        }
    }

    private func addTextAnnotation() {
        guard let point = selectedPoint,
              let page = selectedPage,
              !textToAdd.isEmpty else { return }

        let annotation = annotationModel.createTextAnnotation(at: point, in: page, text: textToAdd)
        page.addAnnotation(annotation)

        textToAdd = ""
        selectedPoint = nil
        selectedPage = nil
    }
}

struct PDFViewWrapper: UIViewRepresentable {
    let document: PDFDocument
    @ObservedObject var annotationModel: AnnotationModel
    let onTap: (CGPoint, PDFPage) -> Void

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical

        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        pdfView.addGestureRecognizer(tapGesture)

        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = document
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        let parent: PDFViewWrapper

        init(_ parent: PDFViewWrapper) {
            self.parent = parent
        }

        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            guard let pdfView = gesture.view as? PDFView else { return }

            let location = gesture.location(in: pdfView)

            guard let page = pdfView.page(for: location, nearest: true) else { return }

            let pointOnPage = pdfView.convert(location, to: page)

            parent.onTap(pointOnPage, page)
        }
    }
}
