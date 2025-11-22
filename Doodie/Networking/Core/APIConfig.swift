//
//  APIConfig.swift
//  Doodie
//
//  Created by 수진 on 11/19/25.
//
import Foundation
import Alamofire

struct APIConfig {
    static let baseURL = "https://api.doodi.store/api/v1"

    static var defaultHeaders: HTTPHeaders = [
        "Content-Type": "application/json",
        "X-User-Id":"1"
    ]
}
