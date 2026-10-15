import SwiftUI

@main
struct BedrockUIApp: App {
  @StateObject private var state = EditorState(root: BedrockUIApp.sample())

  var body: some Scene {
    WindowGroup {
      VStack(spacing: 0) {
        CanvasView(state: state)
        Text(selectedName)
          .font(.footnote)
          .foregroundColor(.white)
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color(white: 0.2))
      }
    }
  }

  var selectedName: String {
    guard let id = state.selectedID, let e = state.find(id) else {
      return "Toca una caja"
    }
    return "\(e.name) (\(e.type.rawValue))"
  }

  static func sample() -> Element {
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
