//
//  ActivityRouter.swift
//  Doodie
//
//  Created by 수진 on 11/19/25.
//

import Alamofire
import Foundation

enum ActivityRouter: URLRequestConvertible {
    
    case getActivityTypes
    case getActivitiesById(activityId: Int)
    case postActivities(model: StartActivityRequest) // request body 필요!
    case patchActivitiesById(activityId:Int)
    case patchActivitiesByIdComplete(activityId: Int)
    case postActivitiesResult(model: ResultRequest, activityId:Int)
    

    // HTTP Method
    private var method: HTTPMethod {
        switch self {
        case .getActivityTypes: return .get
        case .getActivitiesById: return .get
        case .postActivities: return .post
        case .patchActivitiesById: return .patch
        case .patchActivitiesByIdComplete: return .patch
        case .postActivitiesResult: return .post
        }
    }

    // HTTP Path
    private var path: String {
        switch self {
        case .getActivityTypes:
            return "/activity-types"
        case .getActivitiesById(let activityId):
            return "/activities/\(activityId)"
        case .postActivities(let model):
            return "/activities"
        case .patchActivitiesById(let activityId):
            return "/activities/\(activityId)/start"
        case .patchActivitiesByIdComplete(let activityId):
            return "/activities/\(activityId)/complete"
        case .postActivitiesResult(let model, let activityId):
            return "/activities/\(activityId)/result"
        }
    }

    // Query Parameter
    private var parameters: Parameters? {
        switch self {
        default: return nil
        }
    }
    // Query Parameter Encoding
    private var encoding: ParameterEncoding {
        switch self {
        default: URLEncoding.default
        }
    }
    
    // HTTP Request body
    private var requestBody: Encodable?{
        switch self{
        case .postActivities(let model): return model
        case .postActivitiesResult(let model, let activityId): return model
        default: return nil
        }
    }

    func asURLRequest() throws -> URLRequest {
        let base = try APIConfig.baseURL.asURL()
        var request = URLRequest(url: base.appendingPathComponent(path))

        request.method = method
        request.headers = APIConfig.defaultHeaders
        // 헤더 추가 세팅하는법.
        //finalRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = requestBody{
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        return try encoding.encode(request, with: parameters)
    }
}
