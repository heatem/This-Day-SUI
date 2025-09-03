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
        if let uiImage = viewModel.image {
            ZStack(alignment: .bottomLeading) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.size.width)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                
                Button {
                    if let url = URL(string: viewModel.imageUrl) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    VStack {
                        HStack {
                            Text("\(Image(systemName: "camera.fill"))")
                            Text("\(viewModel.photographerName.count > 0 ? viewModel.photographerName + " / " : "")Unsplash")
                                .underline()
                        }
                        .foregroundColor(.white.opacity(0.7))
                        .padding(8)
                    }
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(8)
                    .padding(.leading)
                }
            }
        } else {
            Image("LandsEnd")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.size.width)
                .clipped()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    BackgroundImageView()
}
