//
//  ResultModel.swift
//  Rafd
//
//  Created by eric on 3/22/19.
//  Copyright © 2019 eric. All rights reserved.
//

import Foundation

class ResultModel {
    
    private var firstName = ""
    private var lastName = ""
    private var phone = ""
    private var gender = ""
    private var bloodType = ""
    private var age = ""
    private var city = ""
    
    init() {
        self.firstName = ""
        self.lastName = ""
        self.phone = ""
        self.gender = ""
        self.bloodType = ""
        self.age = ""
        self.city = ""
    }
    
    init(firstName: String, lastName: String, phone: String, gender: String,
         bloodType: String, age: String, city: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.gender = gender
        self.bloodType = bloodType
        self.age = age
        self.city = city
    }
    
    public func getFirstName() -> String {
        return firstName
    }
    
    public func getLastName() -> String {
        return lastName
    }
    
    public func getPhone() -> String {
        return phone
    }
    
    public func getGender() -> String {
        return gender
    }
    
    public func getBloodType() -> String {
        return bloodType
    }
    
    public func getAge() -> String {
        return age
    }
    
    public func getCity() -> String {
        return city
    }
}
