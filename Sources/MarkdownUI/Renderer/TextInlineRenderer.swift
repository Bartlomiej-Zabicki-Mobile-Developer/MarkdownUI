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
    case .text(let content):
      self.renderText(content)
    case .softBreak:
      self.renderSoftBreak()
    case .html(let content):
      self.renderHTML(content)
    case .image(let source, _):
      self.renderImage(source)
    default:
      self.defaultRender(inline)
    }
  }

  private mutating func renderText(_ text: String) {
    var text = text

    if self.shouldSkipNextWhitespace {
      self.shouldSkipNextWhitespace = false
      text = text.replacingOccurrences(of: "^\\s+", with: "", options: .regularExpression)
    }

    self.defaultRender(.text(text))
  }

  private mutating func renderSoftBreak() {
    if self.shouldSkipNextWhitespace {
      self.shouldSkipNextWhitespace = false
    } else {
      self.defaultRender(.softBreak)
    }
  }

  private mutating func renderHTML(_ html: String) {
    let tag = HTMLTag(html)

    switch tag?.name.lowercased() {
    case "br":
      self.defaultRender(.lineBreak)
      self.shouldSkipNextWhitespace = true
    default:
      self.defaultRender(.html(html))
    }
  }

  private mutating func renderImage(_ source: String) {
    if let image = self.images[source] {
      self.result = self.result + Text(image)
    }
  }

  private mutating func defaultRender(_ inline: InlineNode) {
    attributed += inline.renderAttributedString(
      baseURL: self.baseURL,
      textStyles: self.textStyles,
      attributes: self.attributes
    )
    if let range: Range<AttributedString.Index> = .init(rangeHighlightConfiguration.range, in: attributed) {
      attributed[range].backgroundColor = rangeHighlightConfiguration.color
    }
    self.result = Text(attributed)
  }
}
