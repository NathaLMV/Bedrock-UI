import SwiftUI

struct CanvasView: View {
  let root: Element

  var body: some View {
    GeometryReader { geo in
      ElementBox(element: root, parent: geo.size)
    }
    .background(Color(white: 0.12))
  }
}

struct ElementBox: View {
  let element: Element
  let parent: CGSize

  var body: some View {
    let w = Self.parse(element.size[0], parent.width)
    let h = Self.parse(element.size[1], parent.height)
    let mine = CGSize(width: w, height: h)
    ZStack {
      RoundedRectangle(cornerRadius: 4)
        .stroke(Color.green, lineWidth: 1)
      Text(element.name)
        .font(.caption2)
        .foregroundColor(.green)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(4)
      ForEach(element.children) { child in
        ElementBox(element: child, parent: mine)
      }
    }
    .frame(width: w, height: h)
    .offset(x: element.offset[0], y: element.offset[1])
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
