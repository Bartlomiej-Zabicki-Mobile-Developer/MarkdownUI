import MarkdownUI
import SwiftUI

struct TextStylesView: View {
  private let content = """
    ```
    **This is bold textBlock**
    ```
    **This is bold textHeader**
    ```
    *This text is italicized*
    ```
    *This text is italicized*
    ```
    ~~This was mistaken text~~
    ```
    ~~This was mistaken text~~
    ```
    **This text is _extremely_ important**
    ```
    **This text is _extremely_ important**
    ```
    ***All this text is important***
    ```
    ***All this text is important***
    ```
    MarkdownUI block is fully compliant with the [CommonMark Spec](https://spec.commonmark.org/current/).
    ```
    MarkdownUI is fully compliant with the [CommonMark Spec](https://spec.commonmark.org/current/).
    ```
    Visit Block https://github.com.
    ```
    Visit https://github.com.
    ```
    Use Block `git status` to list all new or modified files that haven't yet been committed.
    ```
    Use `git status` to list all new or modified files that haven't yet been committed.
    """
    private let simpleContent = """
    ```
    **This is bold textBlock**
    ```
    **This is bold textHeader**
    """
  @State var rangeHighlightConfiguration: RangeHighlightConfiguration = .init(range: .init(), color: .blue)
  
  var body: some View {
    DemoView {
      Markdown(self.simpleContent)
            .rangeHighlight(rangeHighlightConfiguration)
            
//        .markdownCodeSyntaxHighlighter(.splash(theme: .sunset(withFont: .init(size: 16))))
            .textSelection(.enabled)

//      Section("Customization Example") {
//        Markdown(self.content)
//      }
//      .markdownTextStyle(\.code) {
//        FontFamilyVariant(.monospaced)
//        BackgroundColor(.yellow.opacity(0.5))
//      }
//      .markdownTextStyle(\.emphasis) {
//        FontStyle(.italic)
//        UnderlineStyle(.single)
//      }
//      .markdownTextStyle(\.strong) {
//        FontWeight(.heavy)
//      }
//      .markdownTextStyle(\.strikethrough) {
//        StrikethroughStyle(.init(pattern: .solid, color: .red))
//      }
//      .markdownTextStyle(\.link) {
//        ForegroundColor(.mint)
//        UnderlineStyle(.init(pattern: .dot))
//      }
        Section("Test") {
            Button("Change") {
              rangeHighlightConfiguration.range.location += 5
            }
        }
        
    }
    .onAppear {
      rangeHighlightConfiguration.range = .init(location: 0, length: 10)
    }
  }
}

struct TextStylesView_Previews: PreviewProvider {
  static var previews: some View {
    TextStylesView()
  }
}
