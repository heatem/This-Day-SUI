//
//  ImageViewModel.swift
//  This Day
//
//  Created by Heather Mason on 8/6/25.
//

import Foundation
import SwiftUI

class ImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var photoUrl: String = ""
    @Published var photographerName: String = ""
    @Published var profileUrl: String = ""
    
    private let defaults = UserDefaults.standard
    private let imageKey = "backgroundImageData"
    private let photoUrlKey = "photoUrl"
    private let dateKey = "imageRetrievedOn"
    private let nameKey = "photographer"
    private let profileUrlKey = "profileUrl"
    
    init() {
        loadImage()
    }
    
    func loadImage() {
        let today = formattedDate()
        
        if let savedDate = defaults.string(forKey: dateKey),
           savedDate == today,
           let imageData = defaults.data(forKey: imageKey),
           let cachedImage = UIImage(data: imageData) {
            self.image = cachedImage
            self.photoUrl = defaults.string(forKey: photoUrlKey) ?? ""
            self.photographerName = defaults.string(forKey: nameKey) ?? ""
            self.profileUrl = defaults.string(forKey: profileUrlKey) ?? ""
        } else {
            fetchNewImage()
        }
    }
    
    private func fetchNewImage() {
        UnsplashService.shared.fetchRandomImage { image, metadata in
            DispatchQueue.main.async {
                if let image = image, let metadata = metadata {
                    self.image = image
                    self.photoUrl = metadata.urls.regular
                    self.photographerName = metadata.user.name
                    self.profileUrl = metadata.user.links.html
                    
                    self.defaults.set(image.pngData(), forKey: self.imageKey)
                    self.defaults.set(self.photoUrl, forKey: self.photoUrlKey)
                    self.defaults.set(self.formattedDate(), forKey: self.dateKey)
                    self.defaults.set(metadata.user.name, forKey: self.nameKey)
                    self.defaults.set(metadata.user.links.html, forKey: self.profileUrlKey)
                }
            }
        }
    }
    
    private func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}

