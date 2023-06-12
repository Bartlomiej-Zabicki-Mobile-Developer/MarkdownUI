import MarkdownUI
import Splash
import SwiftUI

struct SplashCodeSyntaxHighlighter: CodeSyntaxHighlighter {
  
  private let syntaxHighlighter: SyntaxHighlighter<TextOutputFormat>

  init(theme: Splash.Theme) {
    self.syntaxHighlighter = SyntaxHighlighter(format: TextOutputFormat(theme: theme))
  }

  func highlightCode(_ content: String, language: String?, range: NSRange) -> CodeIntermediateView {
    guard language?.lowercased() == "swift" else {
//      var attributedText = AttributedString(content)
//      if let intersectionRange = rangeHighlightConfiguration.range.intersection(range) {
//        print("Intersection range: \(intersectionRange)")
//        if let range: Range<AttributedString.Index> = .init(NSRange(location: 5, length: 10), in: attributedText) {
//          attributedText[range].backgroundColor = .red
//        }
//      }
//      return Text(attributedText)
        return CodeIntermediateView(code: content, language: language, range: range)
    }

      return CodeIntermediateView(text: self.syntaxHighlighter.highlight(content))
  }
}

extension CodeSyntaxHighlighter where Self == SplashCodeSyntaxHighlighter {
  static func splash(theme: Splash.Theme) -> Self {
    SplashCodeSyntaxHighlighter(theme: theme)
  }
}
