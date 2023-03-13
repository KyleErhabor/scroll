//
//  EditTitleFormView.swift
//  Scroll
//
//  Created by Kyle Erhabor on 3/13/23.
//

import SwiftUI

struct EditTitleFormView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.managedObjectContext) private var viewContext

  private(set) var id: Title.ID
  @State private var title = ""
  @State private var cover: Data?
  @State private var description = ""
  @State private var didError = false

  var body: some View {
    TitleFormView(
      purpose: .edit,
      title: $title,
      cover: $cover,
      description: $description,
      submit: submit,
      cancel: dismiss.callAsFunction
    ).onAppear {
      let ttl = getTitle(from: id)
      title = ttl.title!
      cover = ttl.cover

      if let desc = ttl.desc {
        description = desc
      }
    }.alert("Could not create title.", isPresented: $didError) {}
  }

  func getTitle(from id: Title.ID) -> Title {
    let id = viewContext.persistentStoreCoordinator!.managedObjectID(forURIRepresentation: id)!

    return try! (viewContext.existingObject(with: id) as! Title)
  }

  func submit() {
    let ttl = getTitle(from: id)
    ttl.title = title
    ttl.desc = description.isEmpty ? nil : description
    ttl.cover = cover

    do {
      try viewContext.save()

      dismiss()
    } catch let err {
      print(err)

      didError = true
    }
  }
}

struct EditTitleFormView_Previews: PreviewProvider {
  static var previews: some View {
    EditTitleFormView(id: .init(string: "/dev/null")!)
  }
}
