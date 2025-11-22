//
//  ActivityDto.swift
//  Doodie
//
//  Created by 수진 on 10/12/25.
//
import FirebaseFirestoreSwift

struct ActivityDto : Codable, Equatable, Hashable {
//    @DocumentID var userId: String?
    @DocumentID var activityId: String?
    var activityIconUrl: String //Img url
    var activityName: String // 활동명
    var activityDescription: String // 활동 설명
    
    // 생성하는 경우 설정한 시간값으로 두개를 동일하게 채워서 보냄.
    // 진행중인 경우 조회할때는 db에서 가져온 값 세팅.
    var totalTime: Double? = nil // 설정한 시간
    var remainingTime: Double? = nil // 남은 시간
}


// 만약에 진행중이다.
// 진행 중인 활동의 아이디 가지고 있어야됨.

