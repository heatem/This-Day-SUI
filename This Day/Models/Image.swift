//
//  Image.swift
//  This Day
//
//  Created by Heather Mason on 7/25/25.
//

import Foundation

struct Image: Decodable {
    let urls: Urls
    let user: User
    
    struct Urls: Decodable {
        let regular: String
    }
    
    struct User: Decodable {
        let name: String
        let links: Links
    }
    
    struct Links: Decodable {
        let html: String
    }
}
