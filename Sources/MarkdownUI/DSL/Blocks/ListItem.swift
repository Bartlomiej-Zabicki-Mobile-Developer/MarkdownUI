import Foundation

/// A Markdown list item.
///
/// You can use list items to compose bulleted and numbered lists.
///
/// ```swift
/// Markdown {
///   NumberedList {
///     ListItem {
///       "Item one"
///       "Additional paragraph"
///     }
///     ListItem {
///       "Item two"
///       BulletedList {
///         "Subitem one"
///         "Subitem two"
///       }
///     }
///   }
/// }
/// ```
///
/// ![](ListItem)
public struct ListItem: Hashable {
  let children: [BlockNode]
    let range: NSRange

  init(children: [BlockNode], range: NSRange) {
    self.children = children
      self.range = range
  }

    init(_ text: String, range: NSRange) {
        self.init(children: [.paragraph(content: [.text(text, range: range)], range: range)], range: range)
  }

  public init(@MarkdownContentBuilder content: () -> MarkdownContent, range: NSRange) {
      self.init(children: content().blocks, range: range)
  }
}
