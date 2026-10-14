import SwiftUI

@main
struct BedrockUIApp: App {
  var body: some Scene {
    WindowGroup {
      CanvasView(root: sample)
    }
  }

  var sample: Element {
    var title = Element(name: "title", type: .label)
    title.size = ["80%", "20%"]
    title.anchor = "top_middle"

    var body = Element(name: "body", type: .panel)
    body.size = ["80%", "50%"]
    body.offset = [0, 40]

    var root = Element(name: "main_panel", type: .panel)
    root.size = ["90%", "80%"]
    root.children = [title, body]
    return root
  }
}
