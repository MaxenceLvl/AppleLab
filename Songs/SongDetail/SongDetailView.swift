//
//  SongDetailView.swift
//  Songs
//
//  Created by Maxence Levelu on 19/01/2022.
//

import SwiftUI

struct SongDetailView: View {
    @ObservedObject private var viewModel: SongDetailViewModel
    
    init(vm: SongDetailViewModel) {
        self.viewModel = vm
    }
    
    var body: some View {
        VStack {
            if let url = viewModel.favoritesSong.coverURL {
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
                if let title = viewModel.favoritesSong.title {
                    Text(title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                Spacer()
                if viewModel.favoritesSong.isFavorite != false {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 45)
            if let firstName = viewModel.favoritesSong.artist?.firstName, let lastName = viewModel.favoritesSong.artist?.lastName {
                Text("\(firstName) \(lastName)")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.top, 10)
            }
            if let lyrics = viewModel.favoritesSong.lyrics {
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
