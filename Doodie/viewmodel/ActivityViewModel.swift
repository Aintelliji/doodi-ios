//
//  ActivityViewModel.swift
//  Doodie
//
//  Created by 수진 on 10/14/25.
//

import SwiftUI

// 뷰모델이 뷰에 변경을 알릴 수 있게
@Observable
final class ActivityViewModel{
    
    var activityList : [ActivityDto] = []
    var recommendMsg: String = ""
    
    init() {
        print("액티비티 뷰모델 생성")
        activityList = getActivityList()
        recommendMsg = getRecommendMsg()
    }
    
    func getRecommendMsg() -> String{
        // 해당 사용자 토큰 --> 사용자에게 맞는 메세지
        var msg = "지난 주에는 운동을 적게 했으니 오늘은 운동 어떠세요?"
        
        return msg
    }
    
    
    // 근데.. 고정 활동은 진짜 고정인데 매번 서버 호출..?
    // 뭐 큰 부하는 없겠지만.....
    func getActivityList() -> [ActivityDto] {
        
        // 길이 4개 아니면 오류처리~
        
        return [ActivityDto(activityId: 1, activityIconUrl: "💪", activityName: "운동하기", activityDescription: "몸을 움직여 건강해져요"),
                ActivityDto(activityId: 2,activityIconUrl: "📚", activityName: "책 읽기", activityDescription: "마음의 양식을 채워요"),
                ActivityDto(activityId: 3,activityIconUrl: "🎹", activityName: "악기 연주", activityDescription: "룰루랄랄라"),
                ActivityDto(activityId: 4, activityIconUrl: "🏓", activityName: "뭐가좋을까", activityDescription: "뭐가좋을까")
        ]
    }
    
}
