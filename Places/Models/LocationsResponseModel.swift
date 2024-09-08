//
//  LocationsResponseModel.swift
//  Places
//
//  Created by Dennis van Oosten on 05/09/2024.
//

import Foundation

struct LocationsResponseModel: Decodable {
    let locations: [LocationModel]
}
