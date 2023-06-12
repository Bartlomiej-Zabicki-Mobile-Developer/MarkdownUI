import Foundation

/// A Markdown paragraph element.
///
/// A paragraph is one structural unit of text. It can contain styled text, links, and images.
///
/// ```swift
/// Markdown {
///   Paragraph {
///     "You can try "
///     Strong("CommonMark")
///     SoftBreak()
///     InlineLink("here", destination: URL(string: "https://spec.commonmark.org/dingus/")!)
///     "."
///   }
///   Paragraph {
///     InlineImage(source: URL(string: "https://picsum.photos/id/237/125/75")!)
///   }
///   Paragraph {
///     "― Photo by André Spieker"
///   }
/// }
/// ```
///
/// ![](Paragraph)
public struct Paragraph: MarkdownContentProtocol {
  public var _markdownContent: MarkdownContent {
      .init(blocks: [.paragraph(content: self.content.inlines, range: self.range)])
  }

  private let content: InlineContent
    private let range: NSRange

  /// Creates a paragraph element.
  /// - Parameter content: An inline content builder that returns the inlines included in the paragraph.
    public init(@InlineContentBuilder content: () -> InlineContent, range: NSRange) {
    self.content = content()
        self.range = range
  }
}
