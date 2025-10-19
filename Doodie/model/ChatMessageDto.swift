//
//  ChatMessageDto.swift
//  Doodie
//
//  Created by 수진 on 10/15/25.
//

import SwiftUI

struct ChatMessage: Identifiable {
    var id = UUID()
    var text: String
    var time: Date = Date()
    var isMine: Bool
    var isActivity: Bool // --> Activity면 말풍선 모양 달리하기... Navigation Link로 감싼 형태 나오기...
    //이미지..? ㅠ
}
