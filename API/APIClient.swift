//
//  ViewController.swift
//  Decodeble
//
//  Created by Subhash Sharma on 25/06/18.
//  Copyright © 2018 OctalSoftware. All rights reserved.
//

import Alamofire
import CodableAlamofire

class APIClient {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder, keyPath:String? = nil, completion:@escaping (Result<T>)->Void) -> DataRequest {
        print(route.urlRequest!)
        Global.showHud()
        return Alamofire.request(route).responseDecodableObject(queue: nil, keyPath: keyPath, decoder: decoder, completionHandler: { (response:DataResponse<T>) in
            Global.hideHud()
            print("Result:\(String(describing: response.result.value))")
                completion(response.result)
        })
    }
    
    private static var jsonDecoder:JSONDecoder {
        let jsonDecoder = JSONDecoder()
        //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        return jsonDecoder
    }
    
    public static func createSession(completion:@escaping (Result<Session>) -> Void) {
        performRequest(route: APIRouter.createSession, decoder: jsonDecoder, completion: completion)
    }
    
    public static func bannerList(id:String, completion:@escaping (Result<Banner>) -> Void) {
        performRequest(route: APIRouter.bannerList(id), decoder: jsonDecoder, completion: completion)
    }
    
    public static func latestProductsList(completion:@escaping (Result<DashboardProduct>) -> Void) {
        performRequest(route: APIRouter.latestProduct, decoder: jsonDecoder, completion: completion)
    }
    
    public static func featureProductsList(completion:@escaping (Result<DashboardProduct>) -> Void) {
        performRequest(route: APIRouter.featureProduct, decoder: jsonDecoder, completion: completion)
    }
    
    public static func specialsProductsList(completion:@escaping (Result<DashboardProduct>) -> Void) {
        performRequest(route: APIRouter.specialsProduct, decoder: jsonDecoder, completion: completion)
    }
    
    public static func login(parameters:[String:Any],completion:@escaping (Result<Login>) -> Void) {
        performRequest(route: APIRouter.login(parameters), decoder: jsonDecoder, completion: completion)
    }
    
    public static func socialLogin(parameters:[String:Any],completion:@escaping (Result<SocialLogin>) -> Void) {
        performRequest(route: APIRouter.socialLogin(parameters), decoder: jsonDecoder, completion: completion)
    }
    
    public static func register(parameters:[String:Any],completion:@escaping (Result<User>) -> Void) {
        performRequest(route: APIRouter.signup(parameters), decoder: jsonDecoder, completion: completion)
    }
    
    public static func logout(parameters:[String:Any],completion:@escaping (Result<Logout>) -> Void) {
        performRequest(route: APIRouter.logout(parameters), decoder: jsonDecoder, completion: completion)
    }
    
    public static func getCart(completion:@escaping (Result<GetCart>) -> Void) {
        performRequest(route: APIRouter.getcart, decoder: jsonDecoder, completion: completion)
    }
    
    public static func getCategories(completion:@escaping (Result<GetCategories>) -> Void) {
        performRequest(route: APIRouter.getCategories, decoder: jsonDecoder, completion: completion)
    }
    
    public static func getCategoriesById(completion:@escaping (Result<GetCategoriesByID>) -> Void) {
        performRequest(route: APIRouter.getCategoriesById, decoder: jsonDecoder, completion: completion)
    }
}
