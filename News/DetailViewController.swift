//
//  DetailViewController.swift
//  News
//
//  Created by chris  on 6/30/18.
//  Copyright © 2018 kuronuma studios. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    
    var articleUrl:String?
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // start the activity spinner
        spinner.alpha = 1
        spinner.startAnimating()
        
        // set delegate for the webview
        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //check if there is a url, if there is display it
        if articleUrl != nil {
            
            //create a url object
            let url = URL(string: articleUrl!)
            
            guard url != nil else {
                return
            }
            
            //create the request
            let request = URLRequest(url: url!)
            
            //load the request
            webView.load(request)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //remove spinner
        spinner.stopAnimating()
        spinner.alpha = 0
    }
    
}
