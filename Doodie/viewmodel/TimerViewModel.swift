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
    
    private let userRepository = UserRepository()
    private let activityRepository = ActivityRepository()
    
    
    
    // 얘가 바뀌면 뷰가 자동으로 업데이트 됨.
    var timerViewStatus : TimerViewStatus = .TimerSetting
    var endActivityEventStatus: EndActivityEventStatus = .NotEnded

    //화면변경용
    var activityDto: ActivityDto = ActivityDto(activityId: 0, activityIconUrl: "", activityName: "", activityDescription: "", typeId: 1, totalTime: nil, remainingTime: nil)
    // 데이터 넘기는용..
    var activityDto2: ActivityDto = ActivityDto(activityId: 0, activityIconUrl: "", activityName: "", activityDescription: "", typeId: 1, totalTime: nil, remainingTime: nil)
    
    @ObservationIgnored var resultDto = ResultDto(expEarned: 0, activity: ActivityDto(activityId: 0, activityIconUrl: "", activityName: "", activityDescription: "", typeId: 1, totalTime: nil, remainingTime: nil))
    
    // 상태 관리용 (화면은 딴데서 그리니까 구독 x)
    @ObservationIgnored var remainingTime: Double = 0
    
    init(activity: ActivityDto) {
//        getActivityById(id: activityId)
  //      print("🔥 TimerViewModel init called")
        activityDto = activity
    }
    


    func getIsProgress() async {
        // 헤더에 토큰 넣어서 사용자 인증
        // 서버에 요청
        guard var isProgress = await userRepository.getProgressState() else {return}
        
        // 진행중이면 getActivityId로 활동 정보 가져오기.
        // 아니면 프론트에서 넘어온 값 세팅하기.
        if(!isProgress){
            timerViewStatus = .TimerSetting
        }else{
            // 진행중이면 이 때 activityId 불러오기.  유저꺼
            // 접속한 유저의 활동을 먼저 불러옴.
            guard let activityId = await userRepository.getProgressingActivityId() else { return }
            activityDto = await getActivityById(id: activityId)
            timerViewStatus = .TimerProgress
        }
    }
    
    // 새로운 활동 클릭해서 넘어올 경우
    // 미리 정의된 ActivityDto 가져옴. id 1,2,3,4
    // 또 서버 호출? 이건 아닌듯. 프론트에서 데이터 넘겨야됨.
    
    // 진행중인 활동 클릭해서 넘어올 경우
    // 새로운 id 부여해서.. 그걸로 가져오기 ㅎ
    
    // 하 미친.. 챗봇이 새로운 활동을 준다..
    // 그냥 거기서 새로 생성되어야지 뭐... 뒷단은 알아서 ㅎ 안쓰는 활동은 삭제하던지..
    
    func getActivityById(id: String) async -> ActivityDto{
        // 0을 넘기면? 아니다. 사용자 정보 가져와서 가지고 있는 다음에 그걸 보내자!!
        // 그 외는 이거
        await activityRepository.getData()
        
        
        return activityDto
    }
    
    func startActivity(selectedTime: Double) async {
        // 서버에 활동 시작한다고 보내면서
        // 설정한 시간.. 보내기?
        let newActivityDto = ActivityDto(activityId: 0, activityIconUrl: activityDto.activityIconUrl, activityName: activityDto.activityName, activityDescription: activityDto.activityDescription, typeId: activityDto.typeId, totalTime: selectedTime*60, remainingTime: selectedTime*60)
        // 초단위로 보냄.
        
        // 내부 dto 업데이트
        // 화면 변경용
        self.activityDto = newActivityDto
        
        
        // isProgress = true 로 변경해야됨.
        timerViewStatus = .TimerProgress // 임시
        // 1. 서버에서 또 바로 조회하기?
        let tmp = await activityRepository.postActivity(activityDto: newActivityDto)
        
        activityDto2.activityId =  tmp?.id ?? 0
        activityDto2.activityName = tmp?.title ?? ""
        activityDto2.activityIconUrl = ""
        activityDto2.activityDescription = ""
        activityDto2.typeId = tmp?.typeId ?? 0
        activityDto2.totalTime = selectedTime
        activityDto2.remainingTime = selectedTime
        
        // getIsProgress()
        // 2. 내부 로컬에 가지고 있기..? --> 서버 호출 시점만 조절
    }
    
    // 활동 종료
    func endActivity() async {
        
        print("활동 종료합니다...: \(self.remainingTime), \(self.activityDto2.activityId)")
        activityDto2.remainingTime = remainingTime
        
        if self.remainingTime < 1 {
            // 활동 잘 종료..
//          박수 페이지..?로 이동
            let result = await activityRepository.endActivity(activity: activityDto2, durationSec: Int(activityDto2.totalTime ?? 0), success: true)
            if result != nil{
                resultDto.expEarned = result?.expEarned ?? 0
                resultDto.activity = activityDto2
                endActivityEventStatus = .Finished
            }
        }else{
            // 활동 미리 종료..
            // 그냥 종료 페이지로 이동..
            let result = await activityRepository.endActivity(activity: activityDto2, durationSec: Int(activityDto2.totalTime ?? remainingTime - remainingTime), success: false)
            if result != nil {
                resultDto.expEarned = result?.expEarned ?? 0
                resultDto.activity = activityDto2
                endActivityEventStatus = .EarlyFinished
            }
            
        }
        
        
    }
    // 이벤트 스테이터스 생성해서 쟤가 감지하도록..!!
    
}

