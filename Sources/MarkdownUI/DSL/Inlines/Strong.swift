import Foundation

/// A strong text in a Markdown content block.
public struct Strong: InlineContentProtocol {
  public var _inlineContent: InlineContent {
    .init(inlines: [.strong(children: self.content.inlines, range: self.content.range)], range: self.content.range)
  }

  private let content: InlineContent

  init(content: InlineContent) {
    self.content = content
  }

  /// Creates a strong inline by applying the strong style to a string.
  /// - Parameter text: The text to make strong.
  public init(_ text: String, range: NSRange) {
      self.init(content: .init(inlines: [.text(text, range: range)], range: range))
  }

  /// Creates a strong inline by applying the strong style to other inline content.
  /// - Parameter content: An inline content builder that returns the inlines to make strong.
  public init(@InlineContentBuilder content: () -> InlineContent) {
    self.init(content: content())
  }
}
