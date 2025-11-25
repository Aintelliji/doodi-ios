//
//  HomeViewModel.swift
//  Doodie
//
//  Created by 수진 on 10/14/25.
//

import SwiftUI
import Alamofire

// 뷰모델이 뷰에 변경을 알릴 수 있게
final class HomeViewModel : ObservableObject{
    
//    var viewState : Any
    private let userRepository = UserRepository()
    // 얘가 바뀌면 뷰가 자동으로 업데이트 됨.
    @Published var activityStatusViewState : ActivityStatusViewState = .NewActivity
    
    @Published var characterInfo: CharacterInfoDto? = CharacterInfoDto(characterImgUrl: "", level: 0, currentExp: 0, minExpOfCurrentLevel: 0, maxExpOfCurrentLevel: 0)

    
    init() {
        // 진행 중인지 조회
        getIsProgress()
        
        Task{
            // 캐릭터 조회
            await getCharacterInfo()
        }
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
    
    func getCharacterInfo() async{
        // 헤더에 토큰 넣어서 사용자 인증
        // 서버에 요청
//        activityProgressViewState.
        do{
            let characterInfoResponse =  await userRepository.getCharactierInfo()
//            let characterInfoResponse = try await APIClient.shared.request(HomeRouter.getCharacterInfo, type: CharacterInfoResponse.self)

            
            if(characterInfoResponse != nil){
                //self.characterInfo?.characterImgUrl = ""
                self.characterInfo?.level = characterInfoResponse!.level // 1
                self.characterInfo?.currentExp = characterInfoResponse!.exp // 0
                self.characterInfo?.minExpOfCurrentLevel = (characterInfoResponse!.evolutionStageMinLevel-1)*100 // 0
                self.characterInfo?.maxExpOfCurrentLevel = self.characterInfo!.minExpOfCurrentLevel+100
                
                print("디버그: \(characterInfoResponse!.evolutionStageMinLevel)")
            }

            
        }catch let apiError as APIError{
            
            // api 에러 메세지 출력
        }catch{
            print("캐릭터 가져오기 에러: "+error.localizedDescription)
        }
        
        
        
//         return CharacterInfoDto(characterImgUrl: "", level: 1, currentExp: 950, minExpOfCurrentLevel: 900, maxExpOfCurrentLevel: 1000)
    }
    

    
    
}
