//
//  TitleCoverView.swift
//  Scroll
//
//  Created by Kyle Erhabor on 3/9/23.
//

import SwiftUI

struct TitleCoverView: View {
  private(set) var cover: Data?

  var body: some View {
    if let data = cover,
       let image = NSImage(data: data) {
      // It would maybe be nice to use an AsyncImage here to not block the UI, but I can't convert Data to URL.
      Image(nsImage: image)
        .resizable()
        .scaledToFill()
    } else {
      Color.secondary
    }
  }
}
