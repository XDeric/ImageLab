//
//  PokeJson.swift
//  ImageLab_9_6_19
//
//  Created by EricM on 9/9/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable {
    let cards: [Cards]    
}

struct Cards: Codable {
    let name: String
    let imageUrl: String
    let types: [String]?
    let weaknesses: [Weakness]?
    let set: String
}

struct Weakness: Codable {
    let type: String
}
