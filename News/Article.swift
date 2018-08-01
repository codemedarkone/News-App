//
//  Article.swift
//  News
//
//  Created by chris  on 6/30/18.
//  Copyright © 2018 kuronuma studios. All rights reserved.
//

import Foundation

struct Article: Decodable {
    
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    
    
    
}
