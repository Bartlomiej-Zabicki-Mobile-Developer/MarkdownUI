import Foundation

/// A deleted or redacted text in a Markdown content block.
public struct Strikethrough: InlineContentProtocol {
  public var _inlineContent: InlineContent {
    .init(inlines: [.strikethrough(children: self.content.inlines, range: range)], range: self.content.range)
  }

  private let content: InlineContent
    private let range: NSRange

    init(content: InlineContent, range: NSRange) {
    self.content = content
        self.range = range
  }

  /// Creates a deleted inline by applying the deleted style to a string.
  /// - Parameter text: The text to delete.
  public init(_ text: String, range: NSRange) {
      self.init(content: .init(inlines: [.text(text, range: range)], range: range), range: range)
  }

  /// Creates a deleted inline by applying the deleted style to other inline content.
  /// - Parameter content: An inline content builder that returns the inlines to delete.
    public init(@InlineContentBuilder content: () -> InlineContent, range: NSRange) {
    self.init(content: content(), range: range)
  }
}
