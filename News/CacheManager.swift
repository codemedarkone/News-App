//
//  CacheManager.swift
//  News
//
//  Created by chris  on 6/30/18.
//  Copyright © 2018 kuronuma studios. All rights reserved.
//

import Foundation


class CacheManager {
    
    static var imageDictionary = [String:Data]()
    
    static func saveImageData(_ url:String, _ data:Data) {
        
        //saveing the image data to our image dictionary
        imageDictionary[url] = data
    }
    
    static func retrieveImageData(_ url:String) -> Data? {
        
        //try to retrieve teh value for the key that's pased into this method
        return imageDictionary[url]
    }
    
}
