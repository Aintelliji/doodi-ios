//
//  ResultResponse.swift
//  Doodie
//
//  Created by 수진 on 11/25/25.
//

import Foundation

struct ResultResponse : Decodable{
    let id: Int
    let activityId: Int
    let success: Bool
    let actualDurationSec: Int
    let summaryNote: String
    let expEarned: Int
    let createdAt: String
    
}
