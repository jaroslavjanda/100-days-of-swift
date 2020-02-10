//
//  Petition.swift
//  Project7
//
//  Created by Jaroslav Janda on 06/02/2020.
//  Copyright © 2020 Jaroslav Janda. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
