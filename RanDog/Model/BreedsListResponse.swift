//
//  BreedsListResponse.swift
//  RanDog
//
//  Created by Isaac Karam on 4/9/20.
//  Copyright © 2020 Isaac. All rights reserved.
//

import Foundation

class BreedsListResponse : Codable{
    let status : String
    let message : [String : [String]]
}
