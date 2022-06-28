//
//  WebViewController.swift
//  MoveiBubu
//
//  Created by obss on 28.06.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var link: URL?
    private var webView: WKWebView!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
     

       
    }
    override func viewDidLoad() {
        if let newURL = link {
            webView.load(URLRequest(url: newURL))
            webView.allowsBackForwardNavigationGestures = true
            
        } else {
            let alertVC = UIAlertController(title: "Error", message: "ACILMIYOR", preferredStyle: .alert)

                    let okButton = UIAlertAction(title: "OK", style: .default) { action in

                        self.navigationController?.popViewController(animated: true)

                    }

                    alertVC.addAction(okButton)

            self.present(alertVC, animated: true)
        }
    }
    

   

}
