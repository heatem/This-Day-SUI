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
    @Published var photographerName: String = ""
    @Published var photographerURL: String = ""
    
    private let defaults = UserDefaults.standard
    private let imageKey = "backgroundImageData"
    private let dateKey = "imageRetrievedOn"
    private let nameKey = "photographer"
    private let urlKey = "photographerProfile"
    
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
            self.photographerName = defaults.string(forKey: nameKey) ?? ""
            self.photographerURL = defaults.string(forKey: urlKey) ?? ""
        } else {
            fetchNewImage()
        }
    }
    
    private func fetchNewImage() {
        UnsplashService.shared.fetchRandomImage { image, metadata in
            DispatchQueue.main.async {
                if let image = image, let metadata = metadata {
                    self.image = image
                    self.photographerName = metadata.user.name
                    self.photographerURL = metadata.user.links.html
                    
                    self.defaults.set(image.pngData(), forKey: self.imageKey)
                    self.defaults.set(self.formattedDate(), forKey: self.dateKey)
                    self.defaults.set(metadata.user.name, forKey: self.nameKey)
                    self.defaults.set(metadata.user.links.html, forKey: self.urlKey)
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

