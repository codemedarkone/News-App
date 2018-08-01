//
//  ViewController.swift
//  News
//
//  Created by chris  on 6/30/18.
//  Copyright © 2018 kuronuma studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var model = ArticleModel()
    var articles = [Article]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //conform to the tableview protocols
        tableView.delegate = self
        tableView.dataSource = self
        
        //Get the articles from the article model
        model.delegate = self
        model.getArticles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //get teh article which the user has tapped on
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else{
            print("user didnt select an article")
            return
        }
        
        let article = articles[indexPath!.row]
        
        //get a reference to the detail Detailviewcontroller
        let detailVC = segue.destination as! DetailViewController
        
        //set the articleUrl property of the detailviewcontroller
        detailVC.articleUrl = article.url
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //transition to the deatil view and pass the article that was selected
        
        
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return the number of articles
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        // get article that the tableview is trying to display
        let article = articles[indexPath.row]
        
        // TODO: Customize it
        cell.displayArticle(article)
        
        //Return the cell
        return cell
    }
}

extension ViewController: ArticleModelProtocol {
    
    func articlesRetrieved(_ articles: [Article]) {
        self.articles = articles
        tableView.reloadData()
    }
}
