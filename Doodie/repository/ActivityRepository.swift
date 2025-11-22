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

   
                //self.characterInfo?.characterImgUrl = ""
                let activityList : [ActivityDto] =  activityTypes.map{ type in
                    ActivityDto(activityId: "\(type.id)"
                                ,activityIconUrl: "",
                                activityName: type.code, activityDescription: "")
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
        
        return ActivityDto(activityId: "", activityIconUrl: "", activityName: "", activityDescription: "")
    }
    
    func postActivity(activityDto: ActivityDto){
        activityTable.addDocument(data: [
            "activityId": activityDto.activityId,
            "activityName": activityDto.activityName,
            "activityIconUrl": activityDto.activityIconUrl,
            "activityDescription": activityDto.activityDescription,
            "totalTime": activityDto.totalTime,
            "remainingTime": activityDto.remainingTime,
            
        ]){
            err in
            if let err = err {
                print(err)
            }
        }
    }

}
