//
//  Views.swift
//  Scroll
//
//  Created by Kyle Erhabor on 3/10/23.
//

import Foundation
import SwiftUI

func titleCoverHeight(from width: CGFloat) -> CGFloat {
  width * (4 / 3)
}

struct TableLabeledContentStyle: LabeledContentStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label
        .foregroundColor(.secondary)
      
      Spacer()
      configuration.content
    }
  }
}

extension LabeledContentStyle where Self == TableLabeledContentStyle {
  static var table: TableLabeledContentStyle { .init() }
}