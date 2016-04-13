//
//  HealthServices.swift
//  WandaDemo
//
//  Created by Steve Wang on 4/12/16.
//  Copyright © 2016 Steve Wang. All rights reserved.
//

import Foundation

protocol HealthServiceDelegate {
    func getHealthPageSuccess(page: HealthPage)
    func getHealthPageFailure(error: NSError)
}

class HealthServices {
    private let BASE_URL = "https://interview.wandalive.com/api/patient_app/measurement"
    private let auth = "32bbf158962c1279fbd0f3ce1b4b0fab3734a966"
    
    var delegate: HealthServiceDelegate!
    
    func getHeartRate() {
        let url = "\(BASE_URL)/?measurement_type=heart_rate"
        getPage(url)
    }
    
    func getBodyWeight() {
        let url = "\(BASE_URL)/?measurement_type=weight"
        getPage(url)
    }

    func getPage(url: String) {
        let completion = { (success: Bool, json: [String: AnyObject]) in
            if success {
                self.delegate.getHealthPageSuccess(HealthPage(json: json))
            }
            else {
                self.delegate.getHealthPageFailure(NSError(domain: "Could not complete request", code: 0, userInfo: nil))
            }
        }
        
        getRequest(NSURL(string: url)!, params: nil, completion: completion)
    }
    
    private func getRequest(URL: NSURL, params: [String: String]?, completion: (success: Bool, json: [String: AnyObject]) -> ()) {
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