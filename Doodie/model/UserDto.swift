//
//  UserDto.swift
//  Doodie
//
//  Created by 수진 on 10/22/25.
//

import FirebaseFirestoreSwift
import SwiftUI

struct UserDto : Codable{
    
    @DocumentID var userId : String?
    var isProgress : Bool
    var progressingActivityId : String
}
