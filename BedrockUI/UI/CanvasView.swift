import SwiftUI

struct CanvasView: View {
  @ObservedObject var state: EditorState

  var body: some View {
    GeometryReader { geo in
      ElementBox(
        element: state.root,
        parent: geo.size,
        state: state
      )
      .frame(
        width: geo.size.width,
        height: geo.size.height,
        alignment: ElementBox.alignment(state.root.anchor)
      )
    }
    .background(Color(white: 0.12))
  }
}

struct ElementBox: View {
  let element: Element
  let parent: CGSize
  @ObservedObject var state: EditorState

  var isSelected: Bool { state.selectedID == element.id }

  var body: some View {
    let w = Self.parse(element.size[0], parent.width)
    let h = Self.parse(element.size[1], parent.height)
    let mine = CGSize(width: w, height: h)
    ZStack {
      RoundedRectangle(cornerRadius: 4)
        .fill(Color.green.opacity(isSelected ? 0.15 : 0.001))
        .onTapGesture { state.selectedID = element.id }
      RoundedRectangle(cornerRadius: 4)
        .stroke(
          isSelected ? Color.yellow : Color.green,
          lineWidth: isSelected ? 2 : 1
        )
        .allowsHitTesting(false)
      Text(element.name)
        .font(.caption2)
        .foregroundColor(isSelected ? .yellow : .green)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(4)
        .allowsHitTesting(false)
      ForEach(element.children) { child in
        ElementBox(element: child, parent: mine, state: state)
          .frame(
            width: mine.width,
            height: mine.height,
            alignment: Self.alignment(child.anchor)
          )
      }
    }
    .frame(width: w, height: h)
    .offset(x: element.offset[0], y: element.offset[1])
  }

  static func alignment(_ a: String) -> Alignment {
    switch a {
    case "top_left": return .topLeading
    case "top_middle": return .top
    case "top_right": return .topTrailing
    case "left_middle": return .leading
    case "right_middle": return .trailing
    case "bottom_left": return .bottomLeading
    case "bottom_middle": return .bottom
    case "bottom_right": return .bottomTrailing
    default: return .center
    }
  }

  static func parse(_ s: String, _ total: CGFloat) -> CGFloat {
    if s.hasSuffix("%"), let v = Double(s.dropLast()) {
      return total * CGFloat(v / 100)
    }
    if s.hasSuffix("px"), let v = Double(s.dropLast(2)) {
      return CGFloat(v)
    }
    return total
  }
}
