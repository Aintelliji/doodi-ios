//
//  ResultRequest.swift
//  Doodie
//
//  Created by 수진 on 11/24/25.
//

import Foundation

struct ResultRequest : Encodable{
    let success: Bool
    let actualDurationSec: Int
    let summaryNote: String
}
