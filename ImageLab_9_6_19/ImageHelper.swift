//
//  ImageHelper.swift
//  ImageLab_9_6_19
//
//  Created by EricM on 9/9/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    
    private init() {}
    
    static let shared = ImageHelper()
    
    
    func getImage(urlStr: String, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(AppError.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler(.failure(AppError.noDataError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(AppError.noDataError))
                return
            }
            
            
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(AppError.noDataError))
                return
            }
            
            completionHandler(.success(image))
            
            
            }.resume()
    }
}


//class ImageHelper {
//    //one instance in the app of the imageCache
//    private init() {}
//    static let shared = ImageHelper()
//
//    func fetchImage(urlString: String, completionHandler: @escaping (Result<UIImage,AppError>) -> ()) {
//        NetworkManager.shared.fetchData(urlString: urlString) { (result) in
//            switch result {
//            case .failure(let error):
//                completionHandler(.failure(error))
//            case .success(let data):
//                guard let image = UIImage(data: data) else {completionHandler(.failure(.badImageData))
//                    return
//                }
//                completionHandler(.success(image))
//            }
//        }
//    }
//}
