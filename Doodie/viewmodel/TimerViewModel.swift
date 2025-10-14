//
//  TimerViewModel.swift
//  Doodie
//
//  Created by 수진 on 10/14/25.
//

import SwiftUI

// 뷰모델이 뷰에 변경을 알릴 수 있게
final class TimerViewModel : ObservableObject{
    
    // 얘가 바뀌면 뷰가 자동으로 업데이트 됨.
    @Published var timerViewStatus : TimerViewStatus = .TimerSetting
    
    // 활동이 진행중인지 조회 - 홈이랑 중복임...
    func getIsProgress(){
        // 헤더에 토큰 넣어서 사용자 인증
        // 서버에 요청
        var isProgress = false
        
        if(!isProgress){
            timerViewStatus = .TimerSetting
        }else{
            timerViewStatus = .TimerProgress
        }
    }
    
    
    func startActivity(){
        // 서버에 활동 시작한다고 보내면서
        
        // isProgress = true 로 변경.
        // 1. 서버에서 또 바로 조회하기?
        // 2. 내부 로컬에 가지고 있기..? --> 서버 호출 시점만 조절
    }
    
}

