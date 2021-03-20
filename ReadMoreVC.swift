//
//  ReadMoreVC.swift
//  EnglishPlus
//
//  Created by Max on 2019/6/9.
//  Copyright © 2019 MAX. All rights reserved.
//

import UIKit
import WebKit

class ReadMoreVC: UIViewController, WKNavigationDelegate {

    var passedData:String?
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
        myWebView.navigationDelegate = self
        let address = passedData
        let webURL = URL(string: address!)
        if let url = webURL{
            let request = URLRequest(url: url)
            myWebView.load(request)
        }
    }
    
    func startLoading(){
        myActivityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!){
        myActivityIndicator.stopAnimating()
    }
}
