//
//  SongDetailView.swift
//  Songs
//
//  Created by Maxence Levelu on 19/01/2022.
//

import SwiftUI

struct SongDetailView: View {
    var song: Song
    
    var body: some View {
        VStack {
            if let url = song.coverURL {
                AsyncImage(
                    url: url,
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300, maxHeight: 300)
                            .padding(.bottom, 25)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                
            }
            HStack(alignment: .center) {
                if let title = song.title {
                    Text(title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                Spacer()
                ShowRatingView(rating: Int(song.rate))
            }
            .padding(.horizontal, 15)
            if let firstName = song.artist?.firstName, let lastName = song.artist?.lastName {
                Text("\(firstName) \(lastName)")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.top, 10)
            }
            if let lyrics = song.lyrics {
                Text("\(lyrics)")
                    .foregroundColor(.white)
                    .font(Font.system(size: 16).italic())
                    .fontWeight(.light)
                    .padding(.top, 10)
            }
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.black, Color.random]), startPoint: .bottomTrailing, endPoint: .topLeading)
        )
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
