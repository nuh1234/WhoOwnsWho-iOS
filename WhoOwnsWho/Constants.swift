//
//  Constants.swift
//  WhoOwnsWho
//
//  Created by Nuh Mohamud on 3/3/18.
//  Copyright © 2018 Nuh Mohamud. All rights reserved.
//

import Foundation

class Constants {
    static let apiKey = ""
    static let fundingAPIKey = ""
    
    
    struct Representatives {
        static let endpoint = "uri"
        enum roles : String {
            case deputyHead = "deputyHeadOfGovernment"
            case execCouncil = "executiveCouncil"
            case govOff = "governmentOfficer"
            case headGov = "headOfGovernment"
            case headOfState = "headOfState"
            case highest = "highestCourtJudge"
            case judge = "judge"
            case legislatorLower = "legislatorLowerBody"
            case legislatorUpper = "legislatorUpperBody"
            case schoolBoard = "schoolBoard"
            case special = "specialPurposeOfficer"
        }
        enum levels : String{
            case admin = "administrativeArea1"
            case admin2 = "administrativeArea2"
            case country = "country"
            case international = "international"
            case local = "locality"
            case region = "regional"
            case special = "special"
            case subLocal = "subLocality1"
            case subLocal2 = "subLocality2"
        }
    }

}
