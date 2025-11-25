//
//  NewActivityResponse.swift
//  Doodie
//
//  Created by 수진 on 11/23/25.
//

import Foundation

struct NewActivityResponse : Decodable{
    let id: Int
    let userId: Int
    let typeId: Int
    let templateId: Int
    let title: String
    let plannedDurationMin: Int
    let statusId: Int
    let startedAt: String?
    let endedAt: String?
    let version: Int
    let createdAt: String
    let updatedAt: String
}
