//
//  TitleView.swift
//  Scroll
//
//  Created by Kyle Erhabor on 3/5/23.
//

import SwiftUI

struct TitleView: View {
  @Environment(\.managedObjectContext) private var viewContext

  private(set) var title: Title

  @State private var isPresentingDeletePrompt = false

  var body: some View {
    let name = title.title ?? "..."

    ScrollView {
      VStack(alignment: .leading, spacing: 12) {
        HStack(alignment: .top) {
          let width: CGFloat = 160 // 128 * (5/4)

          VStack {
            TitleCoverView(cover: title.cover)
              .frame(width: width, height: titleCoverHeight(from: width))
              .titleCoverStyle()

//            VStack(spacing: 4) {
//
//            }
          }
          .frame(width: width)
          .labeledContentStyle(.table)
          .font(.callout)

          VStack(alignment: .leading) {
            Text(name)
              .font(.title)
              .fontWeight(.medium)

            if let desc = title.desc {
              Text(desc)
            }
          }
        }

        Divider()

        let contents = title.contentsArray

        if !contents.isEmpty {
          Text("Contents")
            .font(.title2)
            .fontWeight(.medium)

          let width: CGFloat = 128

          LazyVGrid(columns: [.init(.adaptive(minimum: width))], alignment: .leading) {
            ForEach(title.contentsArray) { content in
              GroupBox {
                Text(content.title!)
              }.contextMenu {
                EditContentButtonView(id: content.id)
              }
            }

            // On iOS, I imagine adding a translucent accented button with the text and icon vertical.
          }
        }
      }.padding()
    }
    // Looks better.
    #if os(macOS)
    .navigationTitle(name)
    #else
    .navigationSubtitle(name)
    #endif
    .toolbar {
      EditTitleButtonView(id: title.id)
      DeleteTitleButtonView(title: title)

      Menu {
        CreateContentButtonView(titleId: title.id)
      } label: {
        Label("Add", systemImage: "plus")
      }
    }
  }
}
