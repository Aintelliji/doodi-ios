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
            let datas = try await activityTable.getDocuments()
            let activities = datas.documents.compactMap{ doc in
                try? doc.data(as: ActivityDto.self)
            }
            return activities
        }catch{
            print("datas get Error: \(error.localizedDescription)")
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
