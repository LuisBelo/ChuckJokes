//
//  ImageDownloader.swift
//  BasicListApp
//
//  Created by Luis Belo on 09/03/21.
//

import Foundation
import Alamofire
import AlamofireImage

/// A escolha do Alamofire para capturar imagens remotas se deve a utilização de uma lib já adicionada no projeto, o aproveitamento da lib.
/// A lib também oferece alguns modificadores que facilitam o manuseio da imagem como alterar escala, forma e cache.
struct ImageDownloader {
    
    static let imageCache = AutoPurgingImageCache()
    
    static func downloadImage(url: String, toImageView view: UIImageView){
        let formattedUrl = URL(string: url)
        
        var cachedImage: UIImage?
        if let checkedURL = formattedUrl {
            let urlRequest = URLRequest(url: checkedURL)
            cachedImage = ImageDownloader.imageCache.image(for: urlRequest)
        }
        
        if let checkedCachedImage = cachedImage {
            view.image = checkedCachedImage
        } else {
            AF.request(url).responseImage { (imageData) in
                
                if case .success(let downloadedImage) = imageData.result {
                    
                    let downloadedURL = URL(string: url)
                    if let checkedDownloadedUrl = downloadedURL {
                        let urlRequest = URLRequest(url: checkedDownloadedUrl)
                        ImageDownloader.imageCache.add(downloadedImage, for: urlRequest)
                    }
                    
                    view.image = downloadedImage
                }
                
            }
        }
        
        
    }
    
}
