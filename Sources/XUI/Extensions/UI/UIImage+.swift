//
//  File.swift
//  
//
//  Created by Aung Ko Min on 18/7/23.
//

import SwiftUI

public extension UIImage {
    
    func resize(_ max_size: CGFloat) -> UIImage {
        let max_size_pixels = max_size
        let aspectRatio =  size.width/size.height
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage
        if aspectRatio > 1 {
            width = max_size_pixels
            height = max_size_pixels / aspectRatio
        } else {
            height = max_size_pixels
            width = max_size_pixels * aspectRatio
        }
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: UIGraphicsImageRendererFormat.default())
        newImage = renderer.image {
            (context) in
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        }
        return newImage
    }
    
    func temporaryLocalFileUrl(id: String, quality: CGFloat) async throws -> URL? {
        guard let imageData = jpegData(compressionQuality: quality) else { return nil }
        guard let localPath = FileUtil.documentDirectory?.appending(path: id) else { return nil }
        imageData.write(path: localPath.path())
        return localPath
    }
}
