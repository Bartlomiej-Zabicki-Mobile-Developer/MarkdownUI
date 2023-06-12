import Foundation

/// A code span in a Markdown content block.
public struct Code: InlineContentProtocol {
  public var _inlineContent: InlineContent {
      .init(inlines: [.code(self.text, range: self.range)], range: self.range)
  }

  private let text: String
  private let range: NSRange

  /// Creates a code span inline element.
  /// - Parameter text: The text content inside the code span.
  public init(_ text: String, range: NSRange) {
    self.text = text
    self.range = range
  }
}
