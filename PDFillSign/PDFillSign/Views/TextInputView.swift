import SwiftUI

struct TextInputView: View {
    @Binding var text: String
    let onAdd: () -> Void
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Add Text")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)

                TextField("Enter text", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.body)

                Text("The text will be added at the location you tapped")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(10)
                    }

                    Button(action: {
                        onAdd()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(text.isEmpty)
                }
            }
            .padding()
        }
    }
}
