import SwiftUI

extension BlockNode: View {
  var body: some View {
    switch self {
    case .blockquote(let children):
      BlockquoteView(children: children)
    case .bulletedList(let isTight, let items):
      BulletedListView(isTight: isTight, items: items)
    case .numberedList(let isTight, let start, let items):
      NumberedListView(isTight: isTight, start: start, items: items)
    case .taskList(let isTight, let items):
      TaskListView(isTight: isTight, items: items)
    case .codeBlock(let fenceInfo, let content, let range):
      CodeBlockView(fenceInfo: fenceInfo, content: content, range: range)
    case .htmlBlock(let content, let range):
        ParagraphView(content: content, range: range)
    case .paragraph(let content, let range):
      ParagraphView(content: content, range: range)
    case .heading(let level, let content, let range):
      HeadingView(level: level, content: content, range: range)
    case .table(let columnAlignments, let rows, let range):
      if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
          TableView(columnAlignments: columnAlignments, rows: rows, range: range)
      }
    case .thematicBreak:
      ThematicBreakView()
    }
  }
}
