import SwiftUI

struct HeadingView: View {
  @Environment(\.theme.headings) private var headings

  private let level: Int
  private let content: [InlineNode]
    private let range: NSRange

    init(level: Int, content: [InlineNode], range: NSRange) {
    self.level = level
    self.content = content
        self.range = range
  }

  var body: some View {
    self.headings[self.level - 1].makeBody(
      configuration: .init(
        label: .init(InlineText(self.content)),
        content: .init(block: .heading(level: self.level, content: self.content, range: range))
      )
    )
    .id(content.renderPlainText().kebabCased())
  }
}
