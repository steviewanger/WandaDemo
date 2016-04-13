//
//  HealthPage.swift
//  WandaDemo
//
//  Created by Steve Wang on 4/12/16.
//  Copyright © 2016 Steve Wang. All rights reserved.
//

import Foundation

class HealthPage {
    let count: Int!
    let next: String?
    let previous: String?
    var data: [HealthData] = Array<HealthData>()
    
    init(json: [String: AnyObject]) {
        if let obj = json["count"] as? Int {
            count = obj
        }
        else {
            count = 0
        }
        
        if let obj = json["next"] as? String {
            next = obj
        }
        else {
            next = nil
        }
        
        if let obj = json["previous"] as? String {
            previous = obj
        }
        else {
            previous = nil
        }
        
        if let objs = json["results"] as? Array<AnyObject> {
            for obj in objs {
                data.append(HealthData(json: obj as! [String : AnyObject]))
            }
        }
    }
}