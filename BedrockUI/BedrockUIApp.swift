import SwiftUI

@main
struct BedrockUIApp: App {
  var body: some Scene {
    WindowGroup {
      ScrollView {
        Text(sample)
          .font(.system(.footnote, design: .monospaced))
          .padding()
      }
    }
  }

  var sample: String {
    let root = Element(
      name: "main_panel",
      type: .panel,
      children: [
        Element(name: "title", type: .label)
      ]
    )
    return JsonUiExporter.json(namespace: "bedrock_ui", root: root) ?? "error"
  }
}
