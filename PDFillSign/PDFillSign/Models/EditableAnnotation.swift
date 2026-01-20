import SwiftUI
import PDFKit

// Model for annotations that can be edited, moved, and resized
class EditableAnnotation: ObservableObject, Identifiable {
    let id = UUID()
    @Published var position: CGPoint
    @Published var size: CGSize
    @Published var text: String
    @Published var isEditing: Bool = false
    let type: EditableAnnotationType
    var signature: UIImage?

    init(position: CGPoint, size: CGSize, text: String = "", type: EditableAnnotationType, signature: UIImage? = nil) {
        self.position = position
        self.size = size
        self.text = text
        self.type = type
        self.signature = signature
    }
}

enum EditableAnnotationType {
    case text
    case signature
    case checkmark
    case circle
}
