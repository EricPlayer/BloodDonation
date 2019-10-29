//
//  CityModel.swift
//  Rafd
//
//  Created by Salem Masrahi on 2019-03-23.
//  Copyright © 2019 eric. All rights reserved.
//

import Foundation

class CityModel {
    private var id: String
    private var name: String
    
    init() {
        self.id = ""
        self.name = ""
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    public func getId() -> String {
        return id
    }
    
    public func getName() -> String {
        return name
    }
}
