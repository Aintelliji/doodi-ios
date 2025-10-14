//
//  HomeViewModel.swift
//  Doodie
//
//  Created by 수진 on 10/14/25.
//

import SwiftUI

// 뷰모델이 뷰에 변경을 알릴 수 있게
final class HomeViewModel : ObservableObject{
    
//    var viewState : Any
  
    // 얘가 바뀌면 뷰가 자동으로 업데이트 됨.
    @Published var activityStatusViewState : ActivityStatusViewState = .NewActivity
    
    var characterInfo: CharacterInfoDto? = nil
    
    init() {
        // 진행 중인지 조회
        getIsProgress()
        
        // 캐릭터 조회
        characterInfo = getCharacterInfo()
    }
    
    
    // 활동이 진행중인지 조회
    func getIsProgress(){
        // 헤더에 토큰 넣어서 사용자 인증
        // 서버에 요청
        var isProgress = false
        
        if(!isProgress){
            activityStatusViewState = .NewActivity
        }else{
            activityStatusViewState = .ProgressingActivity
        }
    }
    
    func getCharacterInfo() -> CharacterInfoDto {
        // 헤더에 토큰 넣어서 사용자 인증
        // 서버에 요청
//        activityProgressViewState.
        return CharacterInfoDto(characterImgUrl: "", level: 1, currentExp: 950, minExpOfCurrentLevel: 900, maxExpOfCurrentLevel: 1000)
    }
    

    
    
}
