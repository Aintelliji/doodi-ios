//
//  ResultDto.swift
//  Doodie
//
//  Created by 수진 on 10/19/25.
//

struct ResultDto: Decodable, Equatable, Hashable {
    var expEarned: Int
    var activity: ActivityDto
}

