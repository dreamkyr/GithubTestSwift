//
//  Contributor.swift
//  githubTest
//
//  Created by dreams on 7/31/19.
//  Copyright © 2019 Dreams. All rights reserved.
//

import UIKit

class Contributor: NSObject {
    var id = 0
    var name = ""
    var avatar = ""
    var contributions = 0
    var location = ""
    
    override init() {
        
    }
    
    init(dict:[String:Any]) {
        if let val = dict["id"] as? Int                           { id = val }
        if let val = dict["login"] as? String                 { name = val }
        if let val = dict["avatar_url"] as? String          { avatar = val }
        if let val = dict["contributions"] as? Int          { contributions = val }
        if let val = dict["location"] as? String             { location = val }
    }
}
