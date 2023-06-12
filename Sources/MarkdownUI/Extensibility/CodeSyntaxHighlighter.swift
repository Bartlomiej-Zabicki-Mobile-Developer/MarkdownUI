import SwiftUI

/// A type that provides syntax highlighting to code blocks in a Markdown view.
///
/// To configure the current code syntax highlighter for a view hierarchy, use the
/// `markdownCodeSyntaxHighlighter(_:)` modifier.
public protocol CodeSyntaxHighlighter {
  /// Returns a text view configured with the syntax highlighted code.
  /// - Parameters:
  ///   - code: The code block.
  ///   - language: The language of the code block.
  func highlightCode(_ code: String, language: String?, range: NSRange) -> CodeIntermediateView
}

/// A code syntax highlighter that returns unstyled code blocks.
public struct PlainTextCodeSyntaxHighlighter: CodeSyntaxHighlighter {
  
  /// Creates a plain text code syntax highlighter.
  public init() {}

    public func highlightCode(_ code: String, language: String?, range: NSRange) -> CodeIntermediateView {
      CodeIntermediateView(code: code, language: language, range: range)
  }
}

extension CodeSyntaxHighlighter where Self == PlainTextCodeSyntaxHighlighter {
  /// A code syntax highlighter that returns unstyled code blocks.
  public static var plainText: Self {
    PlainTextCodeSyntaxHighlighter()
  }
}


public struct CodeIntermediateView: View {
    
    @Environment(\.rangeHighlighter) var rangeHighlightConfiguration
    
    var code: String!
    var language: String?
    var range: NSRange!
    var text: Text?
    
    public init(code: String, language: String? = nil, range: NSRange) {
        self.code = code
        self.language = language
        self.range = range
    }
    
    public init(text: Text) {
        self.text = text
    }
    
    public var body: some View {
        if let text {
            return text
        } else {
            var attributedText = AttributedString(code)
            if let intersectionRange = rangeHighlightConfiguration.range.intersection(range) {
                print("Intersection range: \(intersectionRange)")
                if let range: Range<AttributedString.Index> = .init(intersectionRange, in: attributedText) {
                    attributedText[range].backgroundColor = rangeHighlightConfiguration.color
                }
            }
            return Text(attributedText)
        }
    }
}
