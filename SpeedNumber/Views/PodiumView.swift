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
    
    var images: [UIImage]
    
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
                    self.positionWithImage(position: "2", image: self.images[0])
                        .padding(.leading, proxy.size.width * 0.10)
                    Spacer()
                    self.positionWithImage(position: "2", image: self.images[0])

                    Spacer()
                    self.positionWithImage(position: "2", image: self.images[0])
                    .padding(.trailing, proxy.size.width * 0.10)
                }
                .padding(.bottom, proxy.size.height / 24)
                .foregroundColor(.white)
                .font(Font.system(size: proxy.size.width / 10, weight: .heavy, design: .monospaced))
                
            }

        }
    }
    
    func positionWithImage(position: String, image: UIImage) -> some View {
        return VStack(spacing: 24) {
            Image(uiImage: image)
            Text(position)
        }
    }
    
}



struct PodiumView_Preview: PreviewProvider {
    static var previews: some View {
        return PodiumView(images: [UIImage(systemName: "pencil.circle")!, UIImage(systemName: "pencil.circle.fill")!, UIImage(systemName: "pencil.circle")!]).previewLayout(.fixed(width: 300, height: 100))
    }
}
