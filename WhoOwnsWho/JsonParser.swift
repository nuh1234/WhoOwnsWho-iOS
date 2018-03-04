//
//  JsonParser.swift
//  WhoOwnsWho
//
//  Created by Nuh Mohamud on 3/3/18.
//  Copyright © 2018 Nuh Mohamud. All rights reserved.
//

import Foundation
class JsonParser {
    public static func parse(json: [String : Any]) -> [Model]{
        var list = [Model]()
        if let officialsArray = json["officials"] as? [[String: Any]] {
            for i in officialsArray {
                if let person = i as? [String : Any] {
                    if let url = person["photoUrl"] as? String {
                        if let party = person["party"] as? String {
                            list.append(Model(name: person["name"] as! String, party: party, imageLink: url))
                        }
                    } else {
                        //list.append(Model(name: person["name"] as! String, party: person["party"] as! String, imageLink: nil))
                    }
                    
                }
            }
        }
        
        if let officies = json["offices"] as? [[String: Any]] {
            for i in officies {
                if let office = i as? [String : Any] {
                    if let index = office["officialIndices"] as? [Int] {
                        if let position = office["name"] as? String {
                            if(index.first! < list.count) {
                                list[index.first!].position = position
                            }
                        }
                    }
                    
                }
            }
        }
        return list
    }
    public static func parseLocation(json: [String : Any]) -> String {
        var location : String = ""
        if let data = json["normalizedInput"] as? [String: Any] {
            if let city = data["city"] as? String {
                location = city + ", "
            }
            if let state = data["state"] as? String {
                location += " " + state
            }
        }
        return location
    }
    
    public static func parseSponsors(json: [String : Any]) -> [Sponsor] {
        var list = [Sponsor]()
        if let dataArray = json["response"] as? [String : Any] {
            if let data = dataArray["contributors"] as? [String : Any] {
                if let array = data["contributor"] as? [[String : Any]] {
                    for i in array {
                        if let single = i as? [String : Any] {
                            if let name = single["org_name"] as? String {
                                list.append(Sponsor(name: name, totalReciepts: nil, totalIndv: nil, totalPacs: nil))
                                print()
                            }

                        }
                    }
                }
            }
        }
        return list
    }
}
