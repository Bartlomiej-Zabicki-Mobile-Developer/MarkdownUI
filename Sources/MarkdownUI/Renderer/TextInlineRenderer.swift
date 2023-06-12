import SwiftUI

extension Sequence where Element == InlineNode {
  func renderText(
    baseURL: URL?,
    textStyles: InlineTextStyles,
    images: [String: Image],
    attributes: AttributeContainer,
    rangeHighlightConfiguration: RangeHighlightConfiguration
  ) -> Text {
    var renderer = TextInlineRenderer(
      baseURL: baseURL,
      textStyles: textStyles,
      images: images,
      attributes: attributes,
      rangeHighlightConfiguration: rangeHighlightConfiguration
    )
    renderer.render(self)
    return renderer.result
  }
}

private struct TextInlineRenderer {
  var result = Text("")
    var attributed: AttributedString = .init("")

  private let baseURL: URL?
  private let textStyles: InlineTextStyles
  private let images: [String: Image]
  private let attributes: AttributeContainer
  private var shouldSkipNextWhitespace = false
  private let rangeHighlightConfiguration: RangeHighlightConfiguration

  init(
    baseURL: URL?,
    textStyles: InlineTextStyles,
    images: [String: Image],
    attributes: AttributeContainer,
    rangeHighlightConfiguration: RangeHighlightConfiguration
  ) {
    self.baseURL = baseURL
    self.textStyles = textStyles
    self.images = images
    self.attributes = attributes
    self.rangeHighlightConfiguration = rangeHighlightConfiguration
  }

  mutating func render<S: Sequence>(_ inlines: S) where S.Element == InlineNode {
    for inline in inlines {
      self.render(inline)
    }
  }

  private mutating func render(_ inline: InlineNode) {
    switch inline {
    case .text(let content, let range):
      self.renderText(content, range: range)
    case .softBreak(let range):
        self.renderSoftBreak(range: range)
    case .html(let content, let range):
        self.renderHTML(content, range: range)
    case .image(let source, _, let range):
      self.renderImage(source)
    case .lineBreak(range: let range):
        self.defaultRender(inline, range: range)
    case .code(_, range: let range):
        self.defaultRender(inline, range: range)
    case .emphasis(children: let children, range: let range):
        self.defaultRender(inline, range: range)
    case .strong(children: let children, range: let range):
        self.defaultRender(inline, range: range)
    case .strikethrough(children: let children, range: let range):
        self.defaultRender(inline, range: range)
    case .link(destination: let destination, children: let children, range: let range):
        self.defaultRender(inline, range: range)
    }
  }

    private mutating func renderText(_ text: String, range: NSRange) {
    var text = text

    if self.shouldSkipNextWhitespace {
      self.shouldSkipNextWhitespace = false
      text = text.replacingOccurrences(of: "^\\s+", with: "", options: .regularExpression)
    }

        self.defaultRender(.text(text, range: range), range: range)
  }

  private mutating func renderSoftBreak(range: NSRange) {
    if self.shouldSkipNextWhitespace {
      self.shouldSkipNextWhitespace = false
    } else {
        self.defaultRender(.softBreak(range: range), range: range)
    }
  }

  private mutating func renderHTML(_ html: String, range: NSRange) {
    let tag = HTMLTag(html)

    switch tag?.name.lowercased() {
    case "br":
      self.defaultRender(.lineBreak(range: range), range: range)
      self.shouldSkipNextWhitespace = true
    default:
        self.defaultRender(.html(html, range: range), range: range)
    }
  }

  private mutating func renderImage(_ source: String) {
    if let image = self.images[source] {
      self.result = self.result + Text(image)
    }
  }

    private mutating func defaultRender(_ inline: InlineNode, range: NSRange) {
    attributed += inline.renderAttributedString(
      baseURL: self.baseURL,
      textStyles: self.textStyles,
      attributes: self.attributes
    )
        
        if let intersectionRange = rangeHighlightConfiguration.range.intersection(range) {
            var normalizedRange = intersectionRange
            normalizedRange.location -= range.location
            if let range: Range<AttributedString.Index> = .init(normalizedRange, in: attributed) {
                attributed[range].backgroundColor = rangeHighlightConfiguration.color
            } else {
                normalizedRange.location -= 1
                if let range: Range<AttributedString.Index> = .init(normalizedRange, in: attributed) {
                    attributed[range].backgroundColor = rangeHighlightConfiguration.color
                }
            }
        }
        self.result = Text(attributed)
    }
    
}
