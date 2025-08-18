//
//  UnsplashService.swift
//  This Day
//
//  Created by Heather Mason on 7/25/25.
//

import Foundation
import UIKit

class UnsplashService {
    static let shared = UnsplashService()
    
    func fetchRandomImage(completion: @escaping (UIImage?, UnsplashImage?) -> Void) {
        guard let url = URL(string: "https://api.unsplash.com/photos/random?client_id=\(UNSPLASH_KEY)&query=landscapes") else {
            completion(nil, nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard
                let data = data,
                error == nil,
                let decoded = try? JSONDecoder().decode(UnsplashImage.self, from: data),
                let imageUrl = URL(string: decoded.urls.regular),
                let imageData = try? Data(contentsOf: imageUrl),
                let image = UIImage(data: imageData)
            else {
                completion(nil, nil)
                return
            }
            
            completion(image, decoded)
        }.resume()
    }
}
