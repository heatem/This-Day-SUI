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
    @Published var imageUrl: String = ""
    @Published var photographerName: String = ""
    
    private let defaults = UserDefaults.standard
    private let imageKey = "backgroundImageData"
    private let imageUrlKey = "imageUrl"
    private let dateKey = "imageRetrievedOn"
    private let nameKey = "photographer"
    
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
            self.imageUrl = defaults.string(forKey: imageUrlKey) ?? ""
            self.photographerName = defaults.string(forKey: nameKey) ?? ""
        } else {
            fetchNewImage()
        }
    }
    
    private func fetchNewImage() {
        UnsplashService.shared.fetchRandomImage { image, metadata in
            DispatchQueue.main.async {
                if let image = image, let metadata = metadata {
                    self.image = image
                    self.imageUrl = metadata.urls.regular
                    self.photographerName = metadata.user.name
                    
                    self.defaults.set(image.pngData(), forKey: self.imageKey)
                    self.defaults.set(self.formattedDate(), forKey: self.dateKey)
                    self.defaults.set(metadata.user.name, forKey: self.nameKey)
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

