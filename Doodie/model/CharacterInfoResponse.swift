//
//  CharacterInfoResponse.swift
//  Doodie
//
//  Created by 수진 on 11/22/25.
//

import Foundation

struct CharacterInfoResponse: Decodable {
    let characterId: Int
    let userId: Int
    let level: Int
    let exp: Int
    let evolutionStageId: Int
    let evolutionStageCode: String
    let evolutionStageMinLevel: Int
    let evolutionStageAssetKey: String
}
