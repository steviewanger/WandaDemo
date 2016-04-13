//
//  HealthData.swift
//  WandaDemo
//
//  Created by Steve Wang on 4/12/16.
//  Copyright © 2016 Steve Wang. All rights reserved.
//

import Foundation

class HealthData {
    let id: String!
    let type: String!
    let patientId: Int!
    let time: NSDate!
    let value: Double!
    
    init(json: [String: AnyObject]) {
        if let obj = json["id"] as? String {
            id = obj
        }
        else {
            id = nil
        }
        
        if let obj = json["measurement_type"] as? String {
            type = obj
        }
        else {
            type = nil
        }
        
        if let obj = json["patient_id"] as? Int {
            patientId = obj
        }
        else {
            patientId = nil
        }
        
        if let obj = json["measurement_time"] as? String {
            time = HelperFunctions.dateFromString(obj)
        }
        else {
            time = nil
        }
        if let obj = json["measurement_value"] as? Double {
            value = obj
        }
        else {
            value = nil
        }
        
    }
}