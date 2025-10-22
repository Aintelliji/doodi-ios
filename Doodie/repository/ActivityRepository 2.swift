//
//  ActivityRepository.swift
//  Doodie
//
//  Created by 수진 on 10/22/25.
//
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserRepository{
    
    private let db = Firestore.firestore()
    private let userTable : DocumentReference
    
    init(){
        self.userTable = db.collection("user").document("user1")
    }
    
    func getProgressState() async -> Bool?  {
        do{
            let doc = try await userTable.getDocument()
            return try doc.data(as: UserDto.self).isProgress
        
        }catch{
            print("ERROR: \(error.localizedDescription)")
            return nil
        }
        
        
    }
    

}
