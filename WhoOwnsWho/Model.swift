//
//  Model.swift
//  WhoOwnsWho
//
//  Created by Nuh Mohamud on 3/3/18.
//  Copyright © 2018 Nuh Mohamud. All rights reserved.
//

import Foundation
class Model {
    var name : String
    var party : String
    var position : String?
    var imageLink : String?
    public init(name: String, party: String, imageLink: String?){
        self.name = name
        self.party = party
        self.imageLink = imageLink
    }
}

class Sponsor {
    var name : String
    var totalReciepts : Int?
    var totalIndv : Int?
    var totalPacs : Int?
    
    public init(name: String, totalReciepts: Int?, totalIndv: Int?, totalPacs: Int?) {
        self.name = name
        self.totalReciepts = totalReciepts
        self.totalIndv = totalIndv
        self.totalPacs = totalPacs
    }
}
