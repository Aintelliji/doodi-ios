//
//  StartActivityRequest.swift
//  Doodie
//
//  Created by 수진 on 11/23/25.
//

import Foundation

struct StartActivityRequest: Encodable{
    let title: String
    let typeId: Int
    let templateId: Int = 0
    let plannedDurationMin: Int
}
