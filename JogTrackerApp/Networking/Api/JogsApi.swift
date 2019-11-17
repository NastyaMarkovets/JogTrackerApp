//
//  AuthorizationRouter.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation
import Alamofire

enum JogsApi: JogsBaseApi {    

    case authorize(uuid: String)
    case addNewJog(jog: Jog)
    case updateExistingJog
    case syncJogs

    var method: HTTPMethod {
        switch self {
        case .authorize, .addNewJog:
            return .post
        case .updateExistingJog:
            return .put
        case .syncJogs:
            return .get
        }
    }

    var path: String {
        switch self {
        case .authorize:
            return Server.PathComponent.auth
        case .addNewJog:
            return Server.PathComponent.jog
        case .updateExistingJog:
            return ""
        case .syncJogs:
            return ""
        }
    }

    var parameters: Parameters? {
        return nil
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case .authorize(let uuid):
            return ["uuid" : uuid]
        case .addNewJog(let jog):
            guard let accessToken = UserAccountManager.accessToken else { return nil }
            return [
                "date": jog.date,
                "time": String(jog.time),
                "distance": String(jog.distance),
                UserAccountManager.accessTokenKey: accessToken]
        default:
            return nil
        }
    }
    
}
