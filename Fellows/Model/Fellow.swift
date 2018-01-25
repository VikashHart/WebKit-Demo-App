//
//  Fellow.swift
//  Fellows
//
//  Created by Alex Paul on 1/5/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import Foundation

struct Fellow: Codable {
    let name: String
    let imageURL: URL?
    let bio: String
    let githubURL: URL
}
