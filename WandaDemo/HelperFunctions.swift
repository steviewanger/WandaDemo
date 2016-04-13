//
//  HelperFunctions.swift
//  WandaDemo
//
//  Created by Steve Wang on 4/12/16.
//  Copyright © 2016 Steve Wang. All rights reserved.
//

import Foundation

class HelperFunctions {
    static func dateFromString(dateString: String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd\'T\'HH:mm:ss.SSSSSSZ"
        return dateFormatter.dateFromString(dateString)
    }
}