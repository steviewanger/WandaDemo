//
//  HealthServices.swift
//  WandaDemo
//
//  Created by Steve Wang on 4/12/16.
//  Copyright © 2016 Steve Wang. All rights reserved.
//

import Foundation

class HealthServices {
    private static let BASE_URL = "https://interview.wandalive.com/api/patient_app/measurement"
    private static let auth = "32bbf158962c1279fbd0f3ce1b4b0fab3734a966"
    
    class func getHeartRate(successBlock: (page: HealthPage) -> (), errorBlock: (error: NSError) -> ()) {
        let url = "\(BASE_URL)/?measurement_type=weight"
        getHeartRate(url, successBlock: successBlock, errorBlock: errorBlock)
        
    }
    
    class func getHeartRate(url: String, successBlock: (page: HealthPage) -> (), errorBlock: (error: NSError) -> ()) {
        let completion = { (success: Bool, json: [String: AnyObject]) in
            if success {
                successBlock(page: HealthPage(json: json))
            }
            else {
                errorBlock(error: NSError(domain: "Could not complete request", code: 0, userInfo: nil))
            }
        }
        
        getRequest(NSURL(string: url)!, params: nil, completion: completion)
    }

    class func getBodyWeight() {
        
    }
    
    class private func getRequest(URL: NSURL, params: [String: String]?, completion: (success: Bool, json: [String: AnyObject]) -> ()) {
        let request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "GET"
        
        if params != nil {
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params!, options: [])
        }
    
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Token \(auth)", forHTTPHeaderField: "Authorization")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard data != nil && error == nil else {
                print(error)
                return
            }
            
            guard let httpResponse = response as? NSHTTPURLResponse where httpResponse.statusCode == 200 else {
                print("Error: Status code")
                return
            }
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: AnyObject]
                print(json)
                completion(success: true, json: json)
                
            } catch let parseError {
                print("Error with Json: \(parseError)")
            }
        }
        task.resume()
    }
}