import SwiftUI

struct TextStyleAttributesReader<Content: View>: View {
  @Environment(\.textStyle) private var textStyle

  private let content: (AttributeContainer) -> Content

  init(@ViewBuilder content: @escaping (_ attributes: AttributeContainer) -> Content) {
    self.content = content
  }

  var body: some View {
    self.content(self.attributes)
  }

  private var attributes: AttributeContainer {
    var attributes = AttributeContainer()
    self.textStyle._collectAttributes(in: &attributes)
//    let range: Range<AttributedString.Index> = .init(.init(location: 0, length: 10), in: .init("")!)!
//    attributes[range].foregroundColor = .red
    return attributes
//      .onAppear {
//        let range: Range<AttributedString.Index> = .init(.init(location: 0, length: 10), in: .init(""))
//        attributes[range].foregroundColor = .red
//        print("Blocks: \(self.blocks)")
//      }
  }
}
