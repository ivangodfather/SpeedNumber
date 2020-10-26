//
//  ScoreView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 02/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct ScoreView: View {
    let score: String
    let maxScoreHandler: (@escaping ((Int?) -> Void)) -> ()
    let completion: () -> Void
    @State private var maxScore: Int? = nil

    @State private var isSharePresented: Bool = false

    var body: some View {
        GeometryReader { _ in
            VStack {
                Spacer()
                MiniScoreView(title: Translation.lastScore, score: self.score, size: 48)
                Button(action: { self.isSharePresented.toggle() }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color(.systemPink))
                        Text(Translation.shareMe).modifier(BodyLabel())
                    }.padding()
                }
                Spacer()
                if let maxScore = maxScore {
                    MiniScoreView(title: Translation.bestScore, score: maxScore.description, size: 32)
                        .padding()
                }
                PodiumView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
            .onTapGesture {
                self.completion()
            }.sheet(isPresented: self.$isSharePresented, onDismiss: {}) {
                ActivityViewController(activityItems: self.items())
            }
        }.onAppear {
            maxScoreHandler { value in
                if let value = value {
                    maxScore = value
                }
            }
        }
    }

    private func items() -> [Any] {
        [
            String(format: NSLocalizedString("share.content", comment: ""), score),
            URL(string: "https://apps.apple.com/\(Locale.current.isSpain ? "es": "us")/app/speedynumbers/id1505831179?ls=1")!
        ]

    }
}
import GameKit
struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["es", "en"], id: \.self) { id in
            ScoreView(score: "32.2", maxScoreHandler: { _ in }, completion: {})
                .environment(\.locale, .init(identifier: id))
        }
    }
}

struct MiniScoreView: View {
    let title: LocalizedStringKey
    let score: String
    let size: CGFloat
    var body: some View {
        VStack(spacing: 8) {
            Text(title).font(Font.system(size: CGFloat(size / 2), design: .monospaced))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding([.leading, .trailing])
            HStack(spacing: 16) {
                Image(systemName: "timer")
                    .resizable()
                    .frame(width: size, height: size)
                    .foregroundColor(Color(.systemPink))

                Text(score)
                    .font(Font.system(size: size, design: .monospaced))
                    .minimumScaleFactor(0.5)
            }
        }
    }
}
