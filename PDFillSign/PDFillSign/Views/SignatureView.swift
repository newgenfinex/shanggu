import SwiftUI

struct SignatureView: View {
    @ObservedObject var annotationModel: AnnotationModel
    var onSignatureCreated: ((UIImage) -> Void)? = nil
    @Environment(\.presentationMode) var presentationMode
    @State private var currentDrawing = Drawing()
    @State private var drawings: [Drawing] = []

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Draw Your Signature")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)

                Text("Sign naturally with your finger")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)

                    // Signature line
                    VStack {
                        Spacer()
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 1)
                            .padding(.horizontal, 40)
                            .padding(.bottom, 60)
                    }

                    DrawingCanvas(currentDrawing: $currentDrawing, drawings: $drawings)
                        .frame(height: 250)
                }
                .frame(height: 250)
                .padding(.horizontal, 20)

                HStack(spacing: 15) {
                    Button(action: clearSignature) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                            Text("Clear")
                        }
                        .font(.headline)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(12)
                    }

                    Button(action: saveSignature) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Use Signature")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                    .disabled(drawings.isEmpty && currentDrawing.points.isEmpty)
                    .opacity((drawings.isEmpty && currentDrawing.points.isEmpty) ? 0.5 : 1.0)
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationBarItems(
                trailing: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }

    private func clearSignature() {
        withAnimation {
            drawings.removeAll()
            currentDrawing = Drawing()
        }
    }

    private func saveSignature() {
        let image = renderSignatureImage()
        annotationModel.savedSignature = image
        onSignatureCreated?(image)
        presentationMode.wrappedValue.dismiss()
    }

    private func renderSignatureImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 600, height: 300))
        return renderer.image { context in
            // Transparent background
            UIColor.clear.setFill()
            context.fill(CGRect(origin: .zero, size: CGSize(width: 600, height: 300)))

            // Draw signature with smooth, elegant style
            context.cgContext.setLineCap(.round)
            context.cgContext.setLineJoin(.round)

            for drawing in drawings + [currentDrawing] {
                guard !drawing.points.isEmpty else { continue }

                // Create smooth path using curves instead of straight lines
                let path = createSmoothPath(from: drawing.points)

                // Use gradient stroke for more elegant appearance
                context.cgContext.setStrokeColor(UIColor.black.cgColor)
                context.cgContext.setLineWidth(4)
                context.cgContext.addPath(path)
                context.cgContext.strokePath()
            }
        }
    }

    // Create smooth curved path from points for more natural signature appearance
    private func createSmoothPath(from points: [CGPoint]) -> CGPath {
        guard points.count > 2 else {
            let path = UIBezierPath()
            if let first = points.first {
                path.move(to: first)
                for point in points.dropFirst() {
                    path.addLine(to: point)
                }
            }
            return path.cgPath
        }

        let path = UIBezierPath()
        path.move(to: points[0])

        for i in 1..<points.count {
            let currentPoint = points[i]
            let previousPoint = points[i - 1]

            // Calculate midpoint for smoother curves
            let midPoint = CGPoint(
                x: (currentPoint.x + previousPoint.x) / 2,
                y: (currentPoint.y + previousPoint.y) / 2
            )

            if i == 1 {
                path.addLine(to: midPoint)
            } else {
                path.addQuadCurve(to: midPoint, control: previousPoint)
            }
        }

        // Add final point
        if let lastPoint = points.last {
            path.addLine(to: lastPoint)
        }

        return path.cgPath
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
            // Draw completed signature strokes
            for drawing in drawings {
                drawSmoothStroke(drawing.points, in: context)
            }

            // Draw current stroke being drawn
            drawSmoothStroke(currentDrawing.points, in: context)
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
        .background(Color.clear)
    }

    private func drawSmoothStroke(_ points: [CGPoint], in context: GraphicsContext) {
        guard points.count > 1 else { return }

        var path = Path()
        path.move(to: points[0])

        if points.count == 2 {
            path.addLine(to: points[1])
        } else {
            for i in 1..<points.count {
                let currentPoint = points[i]
                let previousPoint = points[i - 1]

                let midPoint = CGPoint(
                    x: (currentPoint.x + previousPoint.x) / 2,
                    y: (currentPoint.y + previousPoint.y) / 2
                )

                if i == 1 {
                    path.addLine(to: midPoint)
                } else {
                    path.addQuadCurve(to: midPoint, control: previousPoint)
                }
            }

            if let lastPoint = points.last {
                path.addLine(to: lastPoint)
            }
        }

        context.stroke(
            path,
            with: .color(.black),
            style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)
        )
    }
}
