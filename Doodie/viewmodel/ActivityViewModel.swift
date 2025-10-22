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
    private let activityRepository = ActivityRepository()
    
//    init() {
//        recommendMsg = getRecommendMsg()
//    }
    
    func getRecommendMsg() {
        // 해당 사용자 토큰 --> 사용자에게 맞는 메세지
        var msg = "지난 주에는 운동을 적게 했으니 오늘은 운동 어떠세요?"
        
        recommendMsg = msg
    }
    
    
    // 근데.. 고정 활동은 진짜 고정인데 매번 서버 호출..?
    // 뭐 큰 부하는 없겠지만.....
    func getActivityList() async {
        
        activityList =  await activityRepository.getData()
         
    }
    
}
