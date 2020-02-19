//
//  StringExtension.swift
//  MilestoneProject3
//
//  Created by Jaroslav Janda on 13/02/2020.
//  Copyright © 2020 Jaroslav Janda. All rights reserved.
//

extension String {
    func replace(_ with: String, at index: Int) -> String {
        var modifiedString = String()
        for (i, char) in self.enumerated() {
            modifiedString += String((i == index) ? with : String(char))
        }
        return modifiedString
    }
}
