//
//  ActivityRepository.swift
//  Doodie
//
//  Created by 수진 on 10/22/25.
//
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ActivityRepository{
    
    private let db = Firestore.firestore()
    private let activityTable : CollectionReference
    
    init(){
        self.activityTable = db.collection("activity")
    }
    
    func getData() async -> [ActivityDto]{
        do{
            let activityTypes = try await APIClient.shared.request(ActivityRouter.getActivityTypes, type: [ActivityTypeResponse].self)

   
                let activityList : [ActivityDto] =  activityTypes.map{ type in
                    ActivityDto(activityId: 0
                                ,activityIconUrl: "",
                                activityName: type.code, activityDescription: "", typeId: type.id)
                }
                
                print("디버그: \(activityTypes[0].code)")
                
                return activityList

            
        }catch let apiError as APIError{
            
            // api 에러 메세지 출력
        }catch{
            print("활동타입들 가져오기 에러: "+error.localizedDescription)
        }
        
        return []
        
    }
    
    func getDataById(id: String) async -> ActivityDto{
        do{
            let doc = try await activityTable.document(id).getDocument()
            return try doc.data(as: ActivityDto.self)
            
        }catch{
            print("datas get Error: \(error.localizedDescription)")
        }
        
        return ActivityDto(activityId: 0, activityIconUrl: "", activityName: "", activityDescription: "", typeId: 1)
    }
    
    func postActivity(activityDto: ActivityDto) async -> NewActivityResponse?{
        
        do{
            let requestDto = StartActivityRequest(title: activityDto.activityName, typeId: activityDto.typeId, plannedDurationMin: Int(activityDto.totalTime ?? 0))
            
            let newActivity = try await APIClient.shared.request(ActivityRouter.postActivities(model: requestDto), type: NewActivityResponse.self)

   
            print("디버그: \(newActivity.id)")
            
            let tmp = try await APIClient.shared.request(ActivityRouter.patchActivitiesById(activityId: newActivity.id), type: NewActivityResponse.self)
            
            print("디버그2: \(tmp.id)")
            return tmp
            
        }catch let apiError as APIError{
            
            // api 에러 메세지 출력
        }catch{
            print("활동생성 에러: "+error.localizedDescription)
        }
        
        return nil
        
    }
    
    func endActivity(activity: ActivityDto, durationSec: Int, success: Bool) async -> ResultResponse? {
        do{
            
            // 완료처리
            let data = try await APIClient.shared.request(ActivityRouter.patchActivitiesByIdComplete(activityId: activity.activityId), type: NewActivityResponse.self)
            
            // 완료결과
            let model = ResultRequest(success: success, actualDurationSec: durationSec, summaryNote: "")
            
            let result = try await APIClient.shared.request(ActivityRouter.postActivitiesResult(model: model, activityId: activity.activityId), type: ResultResponse.self)
            
            return result
            
        }catch let apiError as APIError{
            
        }catch{
            print("활동종료 에러: "+error.localizedDescription)
        }
        
        return nil
    }

}
