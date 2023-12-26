//
//  ImageStackViewModel.swift
//  h_task
//
//  Created by MaxOS on 25.12.2023.
//

import Foundation


class ImageStackViewModel {
    
    @Published var imageStack: [URLCache]?
    @Published var imageURL: [URL]
    
    init(imageURL: [URL]) {
        self.imageURL = imageURL
    }
    
    func fetchImage() {
        for url in imageURL {
           // Реализовать сохранение изображений
        }
    }
    
}
