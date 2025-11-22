//
//  BaseResponse.swift
//  Doodie
//
//  Created by 수진 on 11/22/25.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String
    let data: T?
}
