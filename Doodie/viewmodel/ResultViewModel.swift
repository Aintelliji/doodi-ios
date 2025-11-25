//
//  ResultViewModel.swift
//  Doodie
//
//  Created by 수진 on 10/26/25.
//
import SwiftUI

@Observable
final class ResultViewModel{

    private let userRepository = UserRepository()
    
    var characterInfo: CharacterInfoDto? = CharacterInfoDto(characterImgUrl: "", level: 0, currentExp: 0, minExpOfCurrentLevel: 0, maxExpOfCurrentLevel: 0)
    var remainingExp: Int = 0
    
    init(){
        Task{
            await initData()
        }
    }
    
    func initData() async {
        do{
            let characterInfoResponse =  await userRepository.getCharactierInfo()
            
            if(characterInfoResponse != nil){
                //self.characterInfo?.characterImgUrl = ""
                
                remainingExp = (characterInfoResponse!.level+1)*100 - characterInfoResponse!.exp
                print("디버그: \(remainingExp)")
            }

            
        }catch let apiError as APIError{
            
            // api 에러 메세지 출력
        }catch{
            print("이닛 데이터 에러: "+error.localizedDescription)
        }
    }
    
    
 
    // 사진, 코멘트 달아서 저장
    func saveResult(){
        
    }
}
