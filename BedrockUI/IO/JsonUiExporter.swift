import Foundation

enum JsonUiExporter {
  static func export(_ e: Element) -> [String: Any] {
    var d: [String: Any] = [
      "type": e.type.rawValue,
      "size": e.size,
      "offset": e.offset,
      "anchor_from": e.anchor,
      "anchor_to": e.anchor
    ]
    e.properties.forEach { d[$0.key] = $0.value }
    if !e.children.isEmpty {
      d["controls"] = e.children.map { [$0.name: export($0)] }
    }
    return d
  }

  static func json(namespace: String, root: Element) -> String? {
    let doc: [String: Any] = [
      "namespace": namespace,
      root.name: export(root)
    ]
    guard let data = try? JSONSerialization.data(
      withJSONObject: doc,
      options: [.prettyPrinted, .sortedKeys]
    ) else { return nil }
    return String(data: data, encoding: .utf8)
  }
}
