//
//  TimerViewModel.swift
//  Doodie
//
//  Created by 수진 on 10/14/25.
//

import SwiftUI

// 뷰모델이 뷰에 변경을 알릴 수 있게
@Observable
final class TimerViewModel{
    
    // 얘가 바뀌면 뷰가 자동으로 업데이트 됨.
    var timerViewStatus : TimerViewStatus = .TimerSetting
    var endActivityEventStatus: EndActivityEventStatus = .NotEnded
    var isFinished = false
    
    var activityDto: ActivityDto = ActivityDto(activityId: 0, activityIconUrl: "", activityName: "", activityDescription: "")
    
    init(activityId: Float) {
        getActivityById(id: activityId)
        print("🔥 TimerViewModel init called")
    }
    
    // 활동이 진행중인지 조회 - 홈이랑 중복임...
    func getIsProgress(){
        // 헤더에 토큰 넣어서 사용자 인증
        // 서버에 요청
        var isProgress = true
        
        if(!isProgress){
            timerViewStatus = .TimerSetting
        }else{
            timerViewStatus = .TimerProgress
        }
    }
    
    // 새로운 활동 클릭해서 넘어올 경우
    // 미리 정의된 ActivityDto 가져옴. id 1,2,3,4
    
    // 진행중인 활동 클릭해서 넘어올 경우
    // 새로운 id 부여해서.. 그걸로 가져오기 ㅎ
    
    // 하 미친.. 챗봇이 새로운 활동을 준다..
    // 그냥 거기서 새로 생성되어야지 뭐... 뒷단은 알아서 ㅎ 안쓰는 활동은 삭제하던지..
    
    func getActivityById(id: Float) -> ActivityDto{
        // 0을 넘기면? 아니다. 사용자 정보 가져와서 가지고 있는 다음에 그걸 보내자!!
        // 그 외는 이거
        activityDto = ActivityDto(activityId: id, activityIconUrl: "💪", activityName: "운동하기", activityDescription: "몸을 움직여 건강해져요", totalTime: 100, remainingTime: 80)
        
        
        return activityDto
    }
    
    func startActivity(selectedTime: Double){
        // 서버에 활동 시작한다고 보내면서
        // 설정한 시간.. 보내기?

        let newActivityDto = ActivityDto(activityId: 0, activityIconUrl: activityDto.activityIconUrl, activityName: activityDto.activityName, activityDescription: activityDto.activityDescription, totalTime: selectedTime*60, remainingTime: selectedTime*60)
        // 초단위로 보냄.
        
        // isProgress = true 로 변경해야됨.
        timerViewStatus = .TimerProgress // 임시
        // 1. 서버에서 또 바로 조회하기?
        // getIsProgress()
        // 2. 내부 로컬에 가지고 있기..? --> 서버 호출 시점만 조절
    }
    
    // 활동 종료
    func endActivity(){
        isFinished = true
        if activityDto.remainingTime! <= 0 {
            // 활동 잘 종료..
//          박수 페이지..?로 이동
            endActivityEventStatus = .Finished
        }else{
            // 활동 잘 종료..
            // 그냥 종료 페이지로 이동..
            endActivityEventStatus = .EarlyFinished
        }
        
        
    }
    // 이벤트 스테이터스 생성해서 쟤가 감지하도록..!!
    
}

