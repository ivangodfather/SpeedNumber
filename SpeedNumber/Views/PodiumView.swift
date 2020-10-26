//
//  PodiumView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 15/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import SwiftUI
typealias Scores = [(name: String, photo: UIImage?)]

struct PodiumView: View {
    @State var scores: Scores? = nil
    @EnvironmentObject private var gameCenter: GameCenter

    var body: some View {
        VStack {
            if let scores = scores {
                PodiumBodyView(scores: scores)
            } else {
                ProgressView()
            }
        }.onAppear {
            gameCenter.loadScores { self.scores = $0 }
        }
    }
}

struct PodiumBodyView: View {
    let scores: Scores

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
                    self.positionWithImage(position: "2", image: scores[1].photo)
                        .padding(.leading, proxy.size.width * 0.10)
                    Spacer()
                    self.positionWithImage(position: "1", image: scores[0].photo)

                    Spacer()
                    self.positionWithImage(position: "3", image: scores[2].photo)
                        .padding(.trailing, proxy.size.width * 0.10)
                }
                .padding(.bottom, proxy.size.height / 24)
                .foregroundColor(.white)
                .font(Font.system(size: proxy.size.width / 10, weight: .heavy, design: .monospaced))

            }
        }.frame(width: 350, height: 140)
    }

    func positionWithImage(position: String, image: UIImage?) -> some View {
        return VStack(spacing: 48) {
            if let image = image {
                Image(uiImage: image).resizable().frame(width: 50, height: 50, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            } else {
                Image(systemName: "person")
            }
            Text(position)
        }
    }
}

struct PodiumView_Preview: PreviewProvider {
    static var previews: some View {
        return PodiumBodyView(scores: [("ivan", UIImage(systemName: "pencil.circle")!), ("pepe", UIImage(systemName: "pencil.circle.fill")!), ("jose", UIImage(systemName: "pencil.circle")!)])
    }
}
