//
//  File.swift
//  Git Hub Application
//
//  Created by Mobile on 4/13/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
