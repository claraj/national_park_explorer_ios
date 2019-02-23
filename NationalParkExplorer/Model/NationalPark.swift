//
//  NationalPark.swift
//  NationalParkExplorer
//
//  Created by student1 on 2/22/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation


struct NationalParkResult: Decodable {
    let total: Int
    let data: [NationalPark]
}

struct NationalPark: Decodable {
    let states: String
    let description: String
    let fullName: String
    
}
