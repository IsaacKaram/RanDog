//
//  DogAPI.swift
//  RanDog
//
//  Created by Isaac Karam on 4/9/20.
//  Copyright © 2020 Isaac. All rights reserved.
//

import Foundation
import UIKit

class DogAPI{
    
    enum EndPoint {
        case randomImageFromAllDogsCollection
        case randomImageFromBreed(String)
        case listAllBreeds
        
        var url : URL{
            return URL(string: stringValue)!
        }
        
        var stringValue : String{
            switch self {
            case .randomImageFromAllDogsCollection :
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageFromBreed(let breed) :
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds :
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    
    class func requestBreedsList(completionHandler: @escaping ([String], Error?)->Void){
        let breedsListEndpoint = EndPoint.listAllBreeds.url
        let task = URLSession.shared.dataTask(with: breedsListEndpoint) { (data, response, error) in
           guard let data = data else{
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
            let breeds = breedsResponse.message.keys.map({$0})
            completionHandler(breeds , nil)
        }
        task.resume()
    }
    
    class func requestRandomImage(breed : String,completionHandler : @escaping (DogImage?, Error?)->Void){
        let randomImageEndpoint = EndPoint.randomImageFromBreed(breed).url
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
           guard let data = data else {
            completionHandler(nil, error)
            return
            }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            completionHandler(imageData, nil)
        }
        task.resume()
    }
    
    class func requestImageFile(url : URL, completionHandler : @escaping (UIImage?, Error?)->Void){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{
                completionHandler(nil, error)
                return
            }
            let downloadImage = UIImage(data: data)
            completionHandler(downloadImage, nil)
        }
        task.resume()
    }
    
}
