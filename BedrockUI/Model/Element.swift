import Foundation

enum ElementType: String, Codable, CaseIterable {
  case panel, stack_panel, collection_panel
  case scrolling_panel, image, label, button
  case input_panel, toggle, custom
}

struct Element: Identifiable, Codable {
  var id = UUID()
  var name: String
  var type: ElementType
  var size: [String] = ["100%", "100%"]
  var offset: [Double] = [0, 0]
  var anchor: String = "center"
  var properties: [String: String] = [:]
  var children: [Element] = []
}
