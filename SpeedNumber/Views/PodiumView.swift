//
//  PodiumView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 15/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import SwiftUI

struct PodiumView: View {
    
    var names: [String]
    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack(alignment: .bottom) {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: proxy.size.height))
                    path.addLine(to: CGPoint(x: proxy.size.width, y: proxy.size.height))
                    path.addLine(to: CGPoint(x: proxy.size.width, y: proxy.size.height * 0.60))
                    path.addLine(to: CGPoint(x: proxy.size.width * 0.66, y: proxy.size.height * 0.60))
                    path.addLine(to: CGPoint(x: proxy.size.width * 0.66, y: proxy.size.height * 0.40))
                    path.addLine(to: CGPoint(x: proxy.size.width * 0.33, y: proxy.size.height * 0.40))
                    path.addLine(to: CGPoint(x: proxy.size.width * 0.33, y: proxy.size.height * 0.55))
                    path.addLine(to: CGPoint(x: 0, y: proxy.size.height * 0.55))
                }
                HStack {
                    Text("2")
                        .padding(.leading, proxy.size.width * 0.10)
                    Spacer()
                    Text("1")
                    Spacer()
                    Text("3")
                        .padding(.trailing, proxy.size.width * 0.10)
                }
                .padding(.bottom, proxy.size.height / 24)
                .foregroundColor(.white)
                .font(Font.system(size: proxy.size.width / 10, weight: .heavy, design: .monospaced))
                
            }

        }
    }
    
}

struct PodiumView_Preview: PreviewProvider {
    static var previews: some View {
        return PodiumView(names: ["IR", "NO", "SI"]).previewLayout(.fixed(width: 300, height: 100))
    }
}
