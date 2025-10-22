//
//  CharacterInfo.swift
//  Doodie
//
//  Created by 수진 on 10/14/25.
//


//
//  File.swift
//  Doodie
//
//  Created by 수진 on 10/14/25.
//

import Foundation

struct CharacterInfoDto : Decodable{
    let characterImgUrl : String // 캐릭터 이미지
    let level : Int // 현재 레벨
    let currentExp: Int // 현재 경험치
    let minExpOfCurrentLevel: Int // 현재 레벨 최소 경험치
    let maxExpOfCurrentLevel: Int // 현재 레벨 최대 경험치
}
