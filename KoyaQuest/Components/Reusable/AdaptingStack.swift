//
//  AdaptingStack.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/23.
//

import SwiftUI

struct AdaptingStack<Content>: View where Content: View {
  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content
  }
  
  var content: () -> Content
  @Environment(\.sizeCategory) var sizeCategory
  
    var body: some View {
      switch sizeCategory {
      case .accessibilityLarge,
           .accessibilityExtraLarge,
           .accessibilityExtraExtraLarge,
           .accessibilityExtraExtraExtraLarge:
        return AnyView(VStack(content: self.content).padding(.top, 10))
      default:
        return AnyView(HStack(alignment: .top, content: self.content))
      }
    }
}
func wideElement(sizeCategory: ContentSizeCategory) -> Bool {
    switch sizeCategory {
    case .accessibilityMedium,
         .accessibilityLarge,
         .accessibilityExtraLarge,
         .accessibilityExtraExtraLarge,
         .accessibilityExtraExtraExtraLarge:
        return true
    default:
        return false
    }
}
