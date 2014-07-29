//
//  Helpers.swift
//  CanvasKit
//
//  Created by Rick Roberts on 7/3/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

import Foundation

class Helpers: NSObject {
    
    class func loadJSONFixture(fixtureName: String) -> AnyObject? {
        
        
        var bundle = NSBundle(forClass: Helpers.self)
        var filePath = bundle.pathForResource(fixtureName, ofType: "json")
        
        var data = NSData(contentsOfFile: filePath)
        
        var error: NSError? = nil
        var result: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error)
        
        if(error != nil) {
            return nil;
        }
        
        return result
    }
    
}