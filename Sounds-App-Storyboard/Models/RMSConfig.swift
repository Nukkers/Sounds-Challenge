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
    var rmsConfig: RmsConfig
}

struct Status: Codable {
    var isOn: Bool
}

struct RmsConfig: Codable {
    var apiKey: String
    var rootUrl: String
}

struct DisplayableItem: Codable {
    var data: [Data] // May need to change back to data
}

struct Data: Codable {
    var image_url: String
    var titles: Title
    var id: String
}

struct Title: Codable {
    var primary: String
    var secondary: String
}
