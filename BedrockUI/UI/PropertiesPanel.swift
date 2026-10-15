import SwiftUI

struct PropertiesPanel: View {
  @ObservedObject var state: EditorState

  static let anchors = [
    "top_left", "top_middle", "top_right",
    "left_middle", "center", "right_middle",
    "bottom_left", "bottom_middle", "bottom_right"
  ]

  var body: some View {
    if let id = state.selectedID, state.find(id) != nil {
      Form {
        Section("Elemento") {
          TextField("Nombre", text: nameBinding(id))
          Picker("Tipo", selection: typeBinding(id)) {
            ForEach(ElementType.allCases, id: \.self) { t in
              Text(t.rawValue).tag(t)
            }
          }
        }
        Section("Tamaño") {
          TextField("Ancho", text: sizeBinding(id, 0))
          TextField("Alto", text: sizeBinding(id, 1))
        }
        Section("Offset") {
          TextField("X", value: offsetBinding(id, 0), format: .number)
          TextField("Y", value: offsetBinding(id, 1), format: .number)
        }
        Section("Anclaje") {
          Picker("Anclaje", selection: anchorBinding(id)) {
            ForEach(Self.anchors, id: \.self) { a in
              Text(a).tag(a)
            }
          }
        }
      }
    } else {
      Text("Toca una caja")
        .foregroundColor(.gray)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }

  private func nameBinding(_ id: UUID) -> Binding<String> {
    Binding(
      get: { state.find(id)?.name ?? "" },
      set: { v in state.update(id) { $0.name = v } }
    )
  }

  private func typeBinding(_ id: UUID) -> Binding<ElementType> {
    Binding(
      get: { state.find(id)?.type ?? .panel },
      set: { v in state.update(id) { $0.type = v } }
    )
  }

  private func sizeBinding(_ id: UUID, _ i: Int) -> Binding<String> {
    Binding(
      get: { state.find(id)?.size[i] ?? "" },
      set: { v in state.update(id) { $0.size[i] = v } }
    )
  }

  private func offsetBinding(_ id: UUID, _ i: Int) -> Binding<Double> {
    Binding(
      get: { state.find(id)?.offset[i] ?? 0 },
      set: { v in state.update(id) { $0.offset[i] = v } }
    )
  }

  private func anchorBinding(_ id: UUID) -> Binding<String> {
    Binding(
      get: { state.find(id)?.anchor ?? "center" },
      set: { v in state.update(id) { $0.anchor = v } }
    )
  }
}
