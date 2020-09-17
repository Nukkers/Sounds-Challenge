//
//  RMSConfig.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 15/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import Foundation

struct AppStatus: Codable {
    var status: Status
    var rmsConfig: RMSConfig
}

struct Status: Codable {
    var isOn: Bool
}

struct RMSConfig: Codable {
    var apiKey: String
    var rootUrl: String
}

//TODO: - Split into a seperate file
struct DisplayableItem: Codable {
    var data: [RMSPlayableItem]
}

//TODO: - Create coding keys for _
struct RMSPlayableItem: Codable {
    var image_url: String
    var titles: Title
    var id: String
}

struct Title: Codable {
    var primary: String
    var secondary: String
}
