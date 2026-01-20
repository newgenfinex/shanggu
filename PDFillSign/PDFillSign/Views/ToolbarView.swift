import SwiftUI

struct ToolbarView: View {
    @ObservedObject var annotationModel: AnnotationModel
    let onSignatureTapped: () -> Void
    let onSaveTapped: () -> Void
    let onCloseTapped: () -> Void
    let onFinalizeTapped: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: onCloseTapped) {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .padding(8)
                }

                Spacer()

                Text("PDF Fill & Sign")
                    .font(.headline)

                Button(action: onFinalizeTapped) {
                    Text("Done")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.green)
                        .cornerRadius(8)
                }

                Spacer()

                Button(action: onSaveTapped) {
                    Image(systemName: "square.and.arrow.down")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .padding(8)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(UIColor.systemBackground))

            Divider()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ToolButton(
                        icon: "hand.tap",
                        title: "Select",
                        isSelected: annotationModel.currentTool == .none,
                        action: { annotationModel.currentTool = .none }
                    )

                    ToolButton(
                        icon: "textformat",
                        title: "Text",
                        isSelected: annotationModel.currentTool == .text,
                        action: { annotationModel.currentTool = .text }
                    )

                    ToolButton(
                        icon: "signature",
                        title: "Sign",
                        isSelected: annotationModel.currentTool == .signature,
                        action: {
                            annotationModel.currentTool = .signature
                            onSignatureTapped()
                        }
                    )

                    ToolButton(
                        icon: "checkmark.circle",
                        title: "Check",
                        isSelected: annotationModel.currentTool == .checkmark,
                        action: { annotationModel.currentTool = .checkmark }
                    )

                    ToolButton(
                        icon: "circle",
                        title: "Circle",
                        isSelected: annotationModel.currentTool == .circle,
                        action: { annotationModel.currentTool = .circle }
                    )
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
            .background(Color(UIColor.secondarySystemBackground))

            Divider()
        }
    }
}

struct ToolButton: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(isSelected ? .white : .primary)
                    .frame(width: 50, height: 50)
                    .background(isSelected ? Color.blue : Color.clear)
                    .cornerRadius(10)

                Text(title)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        }
    }
}
