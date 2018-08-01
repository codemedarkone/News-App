//
//  ArticleCell.swift
//  News
//
//  Created by chris  on 6/30/18.
//  Copyright © 2018 kuronuma studios. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay:Article?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func displayArticle(_ article: Article) {
        
        // set the label and image view to alpha 0
        headlineLabel.alpha = 0
        articleImageView.alpha = 0
        
        //clear the imageview (in case this cell is being reused)
        articleImageView.image = nil
        
        //hold a reference to the article
        articleToDisplay = article
        
        //Display the headline
        headlineLabel.text = articleToDisplay!.title!
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.headlineLabel.alpha = 1
        }, completion: nil)
        
        //download the article image
        let urlString = articleToDisplay!.urlToImage
        
        //check if article has an image
        guard urlString != nil else {
            return
        }
        
        //before we go and download the image, check if its in the cache
        let cachedData = CacheManager.retrieveImageData(urlString!)
        
        if cachedData != nil {
            
            //if cached data exists used that instead
            articleImageView.image = UIImage(data: cachedData!)
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                self.articleImageView.alpha = 1
            }, completion: nil)
            
            return
        }
        
        // Create the url object
        let url = URL(string: urlString!)
        
        //Check that it is not nil
        guard url != nil else {
            print("Couldnt' create URL object")
            return
        }
        
        // get the session
        let session = URLSession.shared
        
        // create the dataTask
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //check that there is no error and there is data
            if error == nil && data != nil {
                
                //save the image data to cache
                CacheManager.saveImageData(urlString!, data!)
                
                //before we set the image ensure this image data is still relevant to the article
                if self.articleToDisplay?.urlToImage == urlString! {
                    
                    //set the imageview with the data
                    DispatchQueue.main.async {
                        self.articleImageView.image = UIImage(data: data!)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            self.articleImageView.alpha = 1
                        }, completion: nil)
                    }
                }
            }
        }
        
        //Fire the dataTask
        dataTask.resume()
        
    }
}
