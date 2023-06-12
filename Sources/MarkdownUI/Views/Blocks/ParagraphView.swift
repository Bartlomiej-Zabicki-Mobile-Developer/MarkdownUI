import SwiftUI

struct ParagraphView: View {
  @Environment(\.theme.paragraph) private var paragraph

  private let content: [InlineNode]
    private let range: NSRange

    init(content: String, range: NSRange) {
    self.init(
      content: [
        .text(content.hasSuffix("\n") ? String(content.dropLast()) : content, range: range)
      ],
      range: range
    )
  }

    init(content: [InlineNode], range: NSRange) {
    self.content = content
        self.range = range
  }

  var body: some View {
    self.paragraph.makeBody(
      configuration: .init(
        label: .init(self.label),
        content: .init(block: .paragraph(content: self.content, range: range))
      )
    )
  }

  @ViewBuilder private var label: some View {
    if let imageView = ImageView(content) {
      imageView
    } else if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *),
      let imageFlow = ImageFlow(content)
    {
      imageFlow
    } else {
      InlineText(content)
    }
  }
}
