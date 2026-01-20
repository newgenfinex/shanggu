import SwiftUI

struct SignatureView: View {
    @ObservedObject var annotationModel: AnnotationModel
    @Environment(\.presentationMode) var presentationMode
    @State private var currentDrawing = Drawing()
    @State private var drawings: [Drawing] = []

    var body: some View {
        NavigationView {
            VStack {
                Text("Draw Your Signature")
                    .font(.headline)
                    .padding()

                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .border(Color.gray, width: 1)

                    DrawingCanvas(currentDrawing: $currentDrawing, drawings: $drawings)
                        .frame(height: 200)
                }
                .padding()

                HStack(spacing: 20) {
                    Button(action: clearSignature) {
                        Label("Clear", systemImage: "trash")
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(10)
                    }

                    Button(action: saveSignature) {
                        Label("Use Signature", systemImage: "checkmark")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()

                Spacer()
            }
            .navigationBarItems(
                trailing: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }

    private func clearSignature() {
        drawings.removeAll()
        currentDrawing = Drawing()
    }

    private func saveSignature() {
        let image = renderSignatureImage()
        annotationModel.savedSignature = image
        presentationMode.wrappedValue.dismiss()
    }

    private func renderSignatureImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 400, height: 200))
        return renderer.image { context in
            UIColor.white.setFill()
            context.fill(CGRect(origin: .zero, size: CGSize(width: 400, height: 200)))

            UIColor.black.setStroke()
            context.cgContext.setLineWidth(3)
            context.cgContext.setLineCap(.round)

            for drawing in drawings + [currentDrawing] {
                guard !drawing.points.isEmpty else { continue }

                let path = UIBezierPath()
                path.move(to: drawing.points[0])
                for point in drawing.points.dropFirst() {
                    path.addLine(to: point)
                }
                path.stroke()
            }
        }
    }
}

struct Drawing {
    var points: [CGPoint] = []
}

struct DrawingCanvas: View {
    @Binding var currentDrawing: Drawing
    @Binding var drawings: [Drawing]

    var body: some View {
        Canvas { context, size in
            for drawing in drawings {
                var path = Path()
                if !drawing.points.isEmpty {
                    path.move(to: drawing.points[0])
                    for point in drawing.points.dropFirst() {
                        path.addLine(to: point)
                    }
                }
                context.stroke(path, with: .color(.black), lineWidth: 3)
            }

            var currentPath = Path()
            if !currentDrawing.points.isEmpty {
                currentPath.move(to: currentDrawing.points[0])
                for point in currentDrawing.points.dropFirst() {
                    currentPath.addLine(to: point)
                }
            }
            context.stroke(currentPath, with: .color(.black), lineWidth: 3)
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    currentDrawing.points.append(value.location)
                }
                .onEnded { _ in
                    drawings.append(currentDrawing)
                    currentDrawing = Drawing()
                }
        )
    }
}
