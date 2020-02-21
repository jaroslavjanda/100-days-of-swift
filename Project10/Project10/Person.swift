//
//  Person.swift
//  Project10
//
//  Created by Jaroslav Janda on 19/02/2020.
//  Copyright © 2020 Jaroslav Janda. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
