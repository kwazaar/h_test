//
//  ImageStackView.swift
//  h_task
//
//  Created by MaxOS on 25.12.2023.
//

import SwiftUI

struct ImageStackView: View {
    
    @ObservedObject var imageCachingService: ImageCachingService
    let imageURL: URL
    
    init(imageCachingService: ImageCachingService, imageURL: URL) {
        self.imageCachingService = ImageCachingService()
        self.imageURL = imageURL
        self.imageCachingService.loadImage(from: imageURL)
    }
    var body: some View {
        if let image = imageCachingService.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    ImageStackView(imageCachingService: ImageCachingService(), imageURL: URL(string: "https://www.atorus.ru/sites/default/files/upload/image/News/56149/Club_Priv%C3%A9_by_Belek_Club_House.jpg")!)
}
