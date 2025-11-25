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
    var characterImgUrl : String // 캐릭터 이미지
    var level : Int // 현재 레벨
    var currentExp: Int // 현재 경험치
    var minExpOfCurrentLevel: Int // 현재 레벨 최소 경험치
    var maxExpOfCurrentLevel: Int // 현재 레벨 최대 경험치
}
