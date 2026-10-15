import SwiftUI

final class EditorState: ObservableObject {
  @Published var root: Element
  @Published var selectedID: UUID?

  init(root: Element) {
    self.root = root
  }

  func find(_ id: UUID) -> Element? {
    Self.find(id, in: root)
  }

  func update(_ id: UUID, _ change: (inout Element) -> Void) {
    Self.update(id, in: &root, change)
  }

  private static func find(_ id: UUID, in e: Element) -> Element? {
    if e.id == id { return e }
    for c in e.children {
      if let f = find(id, in: c) { return f }
    }
    return nil
  }

  private static func update(
    _ id: UUID,
    in e: inout Element,
    _ change: (inout Element) -> Void
  ) {
    if e.id == id {
      change(&e)
      return
    }
    for i in e.children.indices {
      update(id, in: &e.children[i], change)
    }
  }
}
