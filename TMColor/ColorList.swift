//
//  ColorList.swift
//  TMColor
//
//  Created by 汤天明 on 4/24/20.
//  Copyright © 2020 汤天明. All rights reserved.
//

import SwiftUI

struct ColorList: View {
    var colors:[Color]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 230) {
                ForEach(colors, id: \.self) { color  in
                    GeometryReader { geometry   in
                        
                        Rectangle()
                        .foregroundColor(color)

                        .frame(width: 200, height: 300, alignment: .center)
                        .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
                        .rotation3DEffect(Angle(degrees: (Double(geometry.frame(in: .global).minX) - 210) / -20), axis: (x: 0, y: 1.0, z: 0))

                    }
                }
            }.padding(.horizontal, 210)
        }
    }
}

struct ColorList_Previews: PreviewProvider {
    static var previews: some View {
        ColorList(colors: [.red,.green,.blue,.yellow,.orange,.purple])
    }
}
