//
//  ImageStackView.swift
//  h_task
//
//  Created by MaxOS on 25.12.2023.
//

import SwiftUI

struct ImageView: View {
    
    @ObservedObject var imageCachingService = ImageCachingService()
    let imageURL: URL
    
    init(imageURL: URL) {
        self.imageURL = imageURL
        self.imageCachingService.loadImage(from: imageURL)
    }
    var body: some View {
        if let image = imageCachingService.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: 343, height: 257, alignment: .center)
                
        }
    }
}

#Preview {
    ImageView(imageURL: URL(string: "https://www.atorus.ru/sites/default/files/upload/image/News/56149/Club_Priv%C3%A9_by_Belek_Club_House.jpg")!)
}
