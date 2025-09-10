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
                
                HStack {
                    let referralSuffix = "?utm_source=This_Day&utm_medium=referral"
                    
                    // Picture link:
                    Button {
                        if let photoUrl = URL(string: "\(viewModel.photoUrl)\(referralSuffix)") {
                            UIApplication.shared.open(photoUrl)
                        }
                    } label: {
                        Text("Photo")
                            .underline()
                    }
                    .padding(8)
                    
                    Text("by")
                    
                    // Photographer profile link
                    Button {
                        if let photogProfileUrl = URL(string: "\(viewModel.profileUrl)\(referralSuffix)") {
                            UIApplication.shared.open(photogProfileUrl)
                        }
                    } label: {
                        Text(viewModel.photographerName)
                            .underline()
                    }
                    .padding(8)
                    
                    Text("on")
                    
                    // Unsplash link
                    Button {
                        if let unsplashUrl = URL(string: "https://unsplash.com/\(referralSuffix)") {
                            UIApplication.shared.open(unsplashUrl)
                        }
                    } label: {
                        Text("Unsplash")
                            .underline()
                    }
                    .padding(8)
                }
                .foregroundColor(.white)
                .background(Color.black.opacity(0.5))
                .cornerRadius(8)
                .padding(.leading)
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
