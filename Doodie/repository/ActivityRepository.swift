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
    

}
