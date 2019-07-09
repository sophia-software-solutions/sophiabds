//
//  Service.swift
//  PostingProject
//
//  Created by LUCAS on 7/9/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit
import Foundation
import SwiftDate
import Alamofire

class Service {
    static let shared = Service()
    var isConnectedDevice: Bool = false
    
    func performRequest(_ router: String,
                        _ xmlString: String,
                        _ successCallback:@escaping(String) -> Void,
                        _ failedCallback:@escaping(Error) -> Void) {
        
        guard let routeURL = URL(string: router) else {
            print("\n\n\n\n[DEBUG] Invalid URL \(router)")
            return
        }
        
        var xmlRequest = URLRequest(url: routeURL)
        xmlRequest.httpBody = xmlString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        xmlRequest.httpMethod = HTTPMethod.post.rawValue
        xmlRequest.addValue("application/xml", forHTTPHeaderField: "Content-Type")
        xmlRequest.addValue("Bechtel", forHTTPHeaderField: "AppName")
        xmlRequest.addValue("SuperUser", forHTTPHeaderField: "userToken")
        xmlRequest.timeoutInterval = 120
        
        print("\n\n\n\n[DEBUG] Request \n\(xmlString)\n")
        Alamofire.request(xmlRequest).responseString { response in
            switch response.result {
            case .success(let value):
                print("\n\n\n\n[DEBUG] Response \n\(value)\n")
                successCallback(value)
            case .failure(let error):
                print("\n\n\n\n[DEBUG] Response ERROR\n")
                failedCallback(error)
            }
        }
    }
    
    func uploadImage(_ image: UIImage, _ parameter: String) {
        guard let imgData = image.jpegData(compressionQuality: 0.8) else {
            //log out error
            return
        }
        
        //Insert params
        let parameters = ["parameter": parameter]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpg")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            } //Optional for extra parameters
        },
                         to:"mysite/upload.php")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print(response.result.value)
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
}
