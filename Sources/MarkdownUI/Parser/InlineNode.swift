import Foundation

enum InlineNode: Hashable {
  case text(String, range: NSRange)
    case softBreak(range: NSRange)
  case lineBreak(range: NSRange)
  case code(String, range: NSRange)
  case html(String, range: NSRange)
  case emphasis(children: [InlineNode], range: NSRange)
  case strong(children: [InlineNode], range: NSRange)
  case strikethrough(children: [InlineNode], range: NSRange)
  case link(destination: String, children: [InlineNode], range: NSRange)
  case image(source: String, children: [InlineNode], range: NSRange)
}

extension InlineNode {
  var children: [InlineNode] {
    get {
      switch self {
      case .emphasis(let children, _):
        return children
      case .strong(let children, _):
        return children
      case .strikethrough(let children, _):
        return children
      case .link(_, let children, _):
        return children
      case .image(_, let children, _):
        return children
      default:
        return []
      }
    }

    set {
      switch self {
      case .emphasis(_, let range):
        self = .emphasis(children: newValue, range: range)
      case .strong(_, let range):
        self = .strong(children: newValue, range: range)
      case .strikethrough(_, let range):
          self = .strikethrough(children: newValue, range: range)
      case .link(let destination, _, let range):
        self = .link(destination: destination, children: newValue, range: range)
      case .image(let source, _, let range):
          self = .image(source: source, children: newValue, range: range)
      default:
        break
      }
    }
  }
}
