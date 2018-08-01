//
//  ArticleModel.swift
//  News
//
//  Created by chris  on 6/30/18.
//  Copyright © 2018 kuronuma studios. All rights reserved.
//

import Foundation

protocol ArticleModelProtocol{
    
    func articlesRetrieved(_ articles:[Article])
}

class ArticleModel {
    
    var delegate:ArticleModelProtocol?
    
    func getArticles() {
        
        //Create a string URL
        let stringURL = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7e74b6c662d34a36b9b99d0bf56d9d36"
        
        //Create a URL Object
        let url = URL(string: stringURL)
        
        //Check that it isn't nil
        guard url != nil else {
            print("Couldn't create a url object")
            return
        }
        
        //get the URL session
        let session = URLSession.shared
        
        //Create the DataTask Object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //check if there's no error and there is data
            if error == nil && data != nil {
                
                do {
                    //Decode the data into our structs
                    let decoder = JSONDecoder()
                    let result =  try
                        decoder.decode(ArticleService.self, from: data!)
                    
                    // pass the articles back to the viewcontroller
                    let articles = result.articles!
                    
                    
                    //Do this on the main thread
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(articles)
                    }
                    
                }
                catch {
                    
                    print("couldn't decode the JSon")
                    return
                    
                }// END do catch block
            } // END if
        }// END dataTask
        
        //Resume the task to fire of the request to the API
        dataTask.resume()
    }//End getArticles
    
}//END Article Model
