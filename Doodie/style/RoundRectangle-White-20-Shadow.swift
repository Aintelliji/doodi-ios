//
//  RoundRectangle-White-20-Shadow.swift
//  Doodie
//
//  Created by 수진 on 10/12/25.
//

import SwiftUI

struct RoundRectangle_20_Shadow: View {
    var width: CGFloat
    var height: CGFloat
    var color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(color)
            .frame(width: width, height: height)
            .shadow(color: .gray, radius: 4, x: 0, y: 4)
    }
}

#Preview {
    RoundRectangle_20_Shadow(width:120, height: 120, color: Color.white)
}
