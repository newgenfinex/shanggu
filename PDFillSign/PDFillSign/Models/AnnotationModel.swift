import SwiftUI
import PDFKit

enum AnnotationType {
    case text
    case signature
    case checkmark
    case circle
    case highlight
    case none
}

class AnnotationModel: ObservableObject {
    @Published var currentTool: AnnotationType = .none
    @Published var currentColor: UIColor = .blue
    @Published var fontSize: CGFloat = 12
    @Published var savedSignature: UIImage?

    func createTextAnnotation(at point: CGPoint, in page: PDFPage, text: String) -> PDFAnnotation {
        let bounds = CGRect(x: point.x, y: point.y, width: 200, height: 50)
        let annotation = PDFAnnotation(bounds: bounds, forType: .freeText, withProperties: nil)
        annotation.contents = text
        annotation.font = UIFont.systemFont(ofSize: fontSize)
        annotation.fontColor = currentColor
        annotation.color = .clear
        annotation.border = nil
        return annotation
    }

    func createCheckmarkAnnotation(at point: CGPoint, in page: PDFPage) -> PDFAnnotation {
        let size: CGFloat = 20
        let bounds = CGRect(x: point.x - size/2, y: point.y - size/2, width: size, height: size)
        let annotation = PDFAnnotation(bounds: bounds, forType: .stamp, withProperties: nil)
        annotation.contents = "✓"
        annotation.color = currentColor
        return annotation
    }

    func createCircleAnnotation(at point: CGPoint, in page: PDFPage, radius: CGFloat = 15) -> PDFAnnotation {
        let bounds = CGRect(
            x: point.x - radius,
            y: point.y - radius,
            width: radius * 2,
            height: radius * 2
        )
        let annotation = PDFAnnotation(bounds: bounds, forType: .circle, withProperties: nil)
        annotation.color = .clear
        annotation.interiorColor = .clear
        let border = PDFBorder()
        border.lineWidth = 2.0
        annotation.border = border
        return annotation
    }

    func createSignatureAnnotation(at point: CGPoint, in page: PDFPage, signature: UIImage) -> PDFAnnotation? {
        let targetWidth: CGFloat = 150
        let targetHeight: CGFloat = 75

        let bounds = CGRect(x: point.x - targetWidth/2, y: point.y - targetHeight/2, width: targetWidth, height: targetHeight)
        let annotation = PDFAnnotation(bounds: bounds, forType: .stamp, withProperties: nil)

        if let imageData = signature.pngData() {
            annotation.setValue(imageData, forAnnotationKey: .stampImage)
        }

        return annotation
    }
}

extension PDFAnnotationKey {
    static let stampImage = PDFAnnotationKey(rawValue: "/AP")
}
