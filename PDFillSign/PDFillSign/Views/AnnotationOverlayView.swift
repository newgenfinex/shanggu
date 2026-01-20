import SwiftUI

struct AnnotationOverlayView: View {
    @ObservedObject var annotation: EditableAnnotation
    let onDelete: () -> Void
    @State private var isDragging = false

    var body: some View {
        ZStack {
            switch annotation.type {
            case .text:
                TextAnnotationView(annotation: annotation)
            case .signature:
                SignatureAnnotationView(annotation: annotation)
            case .checkmark:
                CheckmarkAnnotationView(annotation: annotation)
            case .circle:
                CircleAnnotationView(annotation: annotation)
            }

            // Resize handle at bottom-right (only when editing)
            if annotation.isEditing {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ResizeHandle()
                    }
                }
            }
        }
        .frame(width: annotation.size.width, height: annotation.size.height)
        .position(annotation.position)
        .gesture(dragGesture)
        .gesture(resizeGesture)
        .overlay(
            annotation.isEditing ? overlayBorder : nil
        )
    }

    private var overlayBorder: some View {
        RoundedRectangle(cornerRadius: 4)
            .stroke(Color.blue, lineWidth: 2)
            .background(
                HStack {
                    Spacer()
                    VStack {
                        Button(action: onDelete) {
                            Image(systemName: "trash.fill")
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.red)
                                .clipShape(Circle())
                        }
                        .offset(x: 10, y: -10)
                        Spacer()
                    }
                }
            )
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                annotation.isEditing = true
                annotation.position = value.location
            }
    }

    private var resizeGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let newWidth = max(100, annotation.size.width + value.translation.width)
                let newHeight = max(50, annotation.size.height + value.translation.height)
                annotation.size = CGSize(width: newWidth, height: newHeight)
            }
    }
}

struct TextAnnotationView: View {
    @ObservedObject var annotation: EditableAnnotation

    var body: some View {
        ZStack {
            // Only show background when editing
            if annotation.isEditing {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white.opacity(0.9))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.blue.opacity(0.5), lineWidth: 1)
                    )
            }

            if annotation.isEditing {
                TextField("Type here", text: $annotation.text)
                    .font(.system(size: 16))
                    .padding(8)
                    .multilineTextAlignment(.leading)
            } else {
                // Show clean text without any box
                Text(annotation.text.isEmpty ? "Tap to edit" : annotation.text)
                    .font(.system(size: 16))
                    .foregroundColor(annotation.text.isEmpty ? .gray.opacity(0.5) : .black)
                    .padding(8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .background(annotation.text.isEmpty ? Color.gray.opacity(0.1) : Color.clear)
            }
        }
        .onTapGesture {
            annotation.isEditing.toggle()
        }
    }
}

struct SignatureAnnotationView: View {
    @ObservedObject var annotation: EditableAnnotation

    var body: some View {
        ZStack {
            // Transparent background, only show border when selected
            if annotation.isEditing {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
            }

            if let signature = annotation.signature {
                Image(uiImage: signature)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(annotation.isEditing ? 4 : 0)
            } else {
                // Fallback if no signature
                Text("No signature")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CheckmarkAnnotationView: View {
    @ObservedObject var annotation: EditableAnnotation

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.green.opacity(0.1))

            Text("✓")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.green)
        }
    }
}

struct CircleAnnotationView: View {
    @ObservedObject var annotation: EditableAnnotation

    var body: some View {
        Circle()
            .stroke(Color.red, lineWidth: 3)
            .background(Color.clear)
    }
}

struct ResizeHandle: View {
    var body: some View {
        Image(systemName: "arrow.up.left.and.arrow.down.right")
            .font(.system(size: 12))
            .foregroundColor(.blue)
            .padding(4)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(radius: 2)
    }
}
