import SwiftUI
import PDFKit

struct PDFEditorView: View {
    let document: PDFDocument
    @ObservedObject var documentManager: DocumentManager
    @StateObject private var annotationModel = AnnotationModel()
    @State private var showingToolbar = true
    @State private var showingSignatureView = false
    @State private var showingSaveDialog = false
    @State private var editableAnnotations: [EditableAnnotation] = []
    @State private var pdfViewGeometry: GeometryProxy?
    @State private var currentPage: PDFPage?

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if showingToolbar {
                    ToolbarView(
                        annotationModel: annotationModel,
                        onSignatureTapped: { showingSignatureView = true },
                        onSaveTapped: { showingSaveDialog = true },
                        onCloseTapped: { documentManager.closeDocument() },
                        onFinalizeTapped: finalizeAllAnnotations
                    )
                }

                GeometryReader { geometry in
                    ZStack {
                        PDFViewWrapper(
                            document: document,
                            annotationModel: annotationModel,
                            onTap: { point, page in
                                handleTap(at: point, on: page, in: geometry)
                            },
                            geometry: geometry
                        )

                        // Overlay editable annotations
                        ForEach(editableAnnotations) { annotation in
                            AnnotationOverlayView(
                                annotation: annotation,
                                onDelete: {
                                    deleteAnnotation(annotation)
                                }
                            )
                        }
                    }
                    .onAppear {
                        pdfViewGeometry = geometry
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .sheet(isPresented: $showingSignatureView) {
            SignatureView(
                annotationModel: annotationModel,
                onSignatureCreated: { signature in
                    placeSignatureOnPDF(signature)
                }
            )
        }
        .sheet(isPresented: $showingSaveDialog) {
            SaveDocumentView(documentManager: documentManager)
        }
    }

    private func handleTap(at point: CGPoint, on page: PDFPage, in geometry: GeometryProxy) {
        currentPage = page

        switch annotationModel.currentTool {
        case .text:
            // Create editable text annotation at tap location
            let textAnnotation = EditableAnnotation(
                position: point,
                size: CGSize(width: 200, height: 60),
                text: "",
                type: .text
            )
            textAnnotation.isEditing = true
            editableAnnotations.append(textAnnotation)

        case .checkmark:
            // Create checkmark annotation
            let checkmarkAnnotation = EditableAnnotation(
                position: point,
                size: CGSize(width: 40, height: 40),
                text: "✓",
                type: .checkmark
            )
            editableAnnotations.append(checkmarkAnnotation)

        case .circle:
            // Create circle annotation
            let circleAnnotation = EditableAnnotation(
                position: point,
                size: CGSize(width: 60, height: 60),
                type: .circle
            )
            editableAnnotations.append(circleAnnotation)

        case .signature:
            if annotationModel.savedSignature != nil {
                // Signature already exists, user needs to tap where to place it
                showingSignatureView = true
            } else {
                // No signature yet, show signature creation
                showingSignatureView = true
            }

        case .none, .highlight:
            break
        }
    }

    private func placeSignatureOnPDF(_ signature: UIImage) {
        // Place signature in center of visible area
        guard let geometry = pdfViewGeometry else { return }

        let centerPoint = CGPoint(
            x: geometry.size.width / 2,
            y: geometry.size.height / 2
        )

        let signatureAnnotation = EditableAnnotation(
            position: centerPoint,
            size: CGSize(width: 200, height: 100),
            type: .signature,
            signature: signature
        )
        signatureAnnotation.isEditing = true
        editableAnnotations.append(signatureAnnotation)
    }

    private func deleteAnnotation(_ annotation: EditableAnnotation) {
        editableAnnotations.removeAll { $0.id == annotation.id }
    }

    private func finalizeAllAnnotations() {
        guard let page = currentPage ?? document.page(at: 0) else { return }

        for annotation in editableAnnotations {
            switch annotation.type {
            case .text:
                if !annotation.text.isEmpty {
                    let pdfAnnotation = annotationModel.createTextAnnotation(
                        at: annotation.position,
                        in: page,
                        text: annotation.text
                    )
                    page.addAnnotation(pdfAnnotation)
                }

            case .signature:
                if let signature = annotation.signature,
                   let pdfAnnotation = annotationModel.createSignatureAnnotation(
                    at: annotation.position,
                    in: page,
                    signature: signature
                   ) {
                    page.addAnnotation(pdfAnnotation)
                }

            case .checkmark:
                let pdfAnnotation = annotationModel.createCheckmarkAnnotation(
                    at: annotation.position,
                    in: page
                )
                page.addAnnotation(pdfAnnotation)

            case .circle:
                let pdfAnnotation = annotationModel.createCircleAnnotation(
                    at: annotation.position,
                    in: page
                )
                page.addAnnotation(pdfAnnotation)
            }
        }

        // Clear all editable annotations after finalizing
        editableAnnotations.removeAll()
    }
}

struct PDFViewWrapper: UIViewRepresentable {
    let document: PDFDocument
    @ObservedObject var annotationModel: AnnotationModel
    let onTap: (CGPoint, PDFPage) -> Void
    let geometry: GeometryProxy

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.backgroundColor = UIColor.systemGray6

        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        pdfView.addGestureRecognizer(tapGesture)

        context.coordinator.pdfView = pdfView

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
        weak var pdfView: PDFView?

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
