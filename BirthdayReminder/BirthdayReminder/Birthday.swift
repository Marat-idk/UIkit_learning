//
//  Birthday.swift
//  BirthdayReminder
//
//  Created by Marat on 15.09.2022.
//

import Foundation

enum Sex: String, CaseIterable {
    case man = "Парень"
    case woman = "Девушка"
    
    init?(value: Int) {
        switch value {
        case 0:
            self = .man
        case 1:
            self = .woman
        default:
            return nil
        }
    }
}

class Person {
    var name: String
    var birthday: Date
    var age: Int
    var sex: Sex?
    var instNickname: String?
    
    var description: String {
        return "(\(name), \(birthday), \(age), \(sex ?? .woman), \(instNickname)"
    }
    
    init(name: String, birthday: Date, age: Int, sex: Sex? = nil, instNickname: String? = nil) {
        self.name = name
        self.birthday = birthday
        self.age = age
        self.sex = sex
        self.instNickname = instNickname
    }
    
    convenience init() {
        self.init(name: "", birthday: Date(), age: 0)
    }
    
    func copy(from person: Person) {
        self.name = person.name
        self.birthday = person.birthday
        self.age = person.age
        self.sex = person.sex
        self.instNickname = person.instNickname
    }
}
