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
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
            } else {
                Image("LandsEnd")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
            }
            
            if !viewModel.photographerName.isEmpty {
                HStack(spacing: 4) {
                    Text("Photo by")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Button(viewModel.photographerName) {
                        if let url = URL(string: viewModel.photographerURL) {
                            UIApplication.shared.open(url)
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.white)
                    .underline()
                }
                .padding(10)
                .background(Color.black.opacity(0.4))
                .cornerRadius(8)
                .padding()
            }
        }
    }
}

#Preview {
    BackgroundImageView()
}
