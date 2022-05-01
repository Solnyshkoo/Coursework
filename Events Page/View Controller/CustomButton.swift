import Foundation
import SwiftUI
struct CustomButton: View {
    @Binding var searchProperties: Set<String>
    @State var text: String
    @State var width: CGFloat
    @State var height: CGFloat
    var body: some View {
        if searchProperties.contains(text) {
            Button(action: {
                    searchProperties.remove(text)
            }) {
                Text(text).foregroundColor(ColorPalette.text)
                    .frame(width: width, height: height).padding()
            }
            .background(ColorPalette.mainBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(ColorPalette.acсentColor, lineWidth: 4)
            )
            .cornerRadius(10)
        } else {
            Button(action: {
                searchProperties.insert(text)
            }) {
                Text(text).foregroundColor(ColorPalette.text)
                    .frame(width: width, height: height).padding()
            }
            .background(ColorPalette.secondBackground)
            .cornerRadius(10)
        }
    }
}
