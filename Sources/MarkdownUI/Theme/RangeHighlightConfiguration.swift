//
//  RangeHighlightConfiguration.swift
//  
//
//  Created by Bart on 12/06/2023.
//

import Foundation
import SwiftUI

public struct RangeHighlightConfiguration {
  public var range: NSRange
  public var color: Color
  
  public init(range: NSRange, color: Color) {
    self.range = range
    self.color = color
  }
  
}

extension EnvironmentValues {
  var rangeHighlighter: RangeHighlightConfiguration {
    get { self[RangeHighlighterKey.self] }
    set { self[RangeHighlighterKey.self] = newValue }
  }
}

private struct RangeHighlighterKey: EnvironmentKey {
  static let defaultValue: RangeHighlightConfiguration = .init(range: .init(), color: .yellow)
}
public extension View {
  func rangeHighlight(_ value: RangeHighlightConfiguration) -> some View {
    environment(\.rangeHighlighter, value)
  }
}
