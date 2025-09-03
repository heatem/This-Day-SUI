//
//  BackgroundImageView.swift
//  This Day
//
//  Created by Heather Mason on 8/6/25.
//

import SwiftUI

struct BackgroundImageView: View {
    @StateObject private var viewModel = ImageViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let uiImage = viewModel.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.size.width)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
//                    .transition(.opacity)
            } else {
                Image("LandsEnd")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.size.width)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
//                    .transition(.opacity)
            }

//            if !viewModel.photographerName.isEmpty {
                Button {
                    if let url = URL(string: viewModel.photographerURL) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    HStack {
                        Text("\(Image(systemName: "camera.fill"))")
                        Text("\(viewModel.photographerName.count > 0 ? viewModel.photographerName + " / " : "")Unsplash")
                            .underline()
                    }
                    .foregroundColor(.white.opacity(0.7))
                    .padding(10)
                }
                .background(Color.black.opacity(0.5))
                .cornerRadius(8)
            }
//        }
    }
}

#Preview {
    BackgroundImageView()
}
