import Foundation

struct RawImageData: Hashable {
  var source: String
  var alt: String
  var destination: String?
    var range: NSRange
}

extension InlineNode {
  var imageData: RawImageData? {
    switch self {
    case .image(let source, let children, let range):
        return .init(source: source, alt: children.renderPlainText(), range: range)
    case .link(let destination, let children, _) where children.count == 1:
      guard var imageData = children.first?.imageData else { return nil }
      imageData.destination = destination
      return imageData
    default:
      return nil
    }
  }
}
