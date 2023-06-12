import Foundation

/// An emphasized text in a Markdown content block.
public struct Emphasis: InlineContentProtocol {
  public var _inlineContent: InlineContent {
    .init(inlines: [.emphasis(children: self.content.inlines, range: self.range)], range: self.content.range)
  }

  private let content: InlineContent
    private let range: NSRange

  init(content: InlineContent, range: NSRange) {
    self.content = content
      self.range = range
  }

  /// Creates an emphasized inline by applying the emphasis style to a string.
  /// - Parameter text: The text to emphasize
  public init(_ text: String, range: NSRange) {
      self.init(content: .init(inlines: [.text(text, range: range)], range: range), range: range)
  }

  /// Creates an emphasized inline by applying the emphasis style to other inline content.
  /// - Parameter content: An inline content builder that returns the inlines to emphasize.
    public init(@InlineContentBuilder content: () -> InlineContent, range: NSRange) {
      self.init(content: content(), range: range)
  }
}
