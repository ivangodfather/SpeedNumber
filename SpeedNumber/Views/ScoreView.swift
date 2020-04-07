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
    let maxScore: String?
    
    let completion: () -> ()
    
    var body: some View {
        VStack {
            Spacer()
            MiniScoreView(title: Translation.lastScore, score: score, size: 48)
            Spacer()
            if maxScore != nil {
                MiniScoreView(title: Translation.bestScore, score: maxScore!, size: 32)
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
        .onTapGesture {
            self.completion()
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: "32.2", maxScore: "20.0", completion: {})
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
            }
        }
    }
}
