//
//  DetailViewController.swift
//  Parsing Test
//
//  Created by Saif Aion on 5/9/17.
//  Copyright © 2017 Saif Aion. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var getImage = UIImage()
    
    var getUrl : String!
    
    
    @IBOutlet var backButton: UIBarButtonItem!
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customFont = UIFont(name: "Junegull", size: 21.0)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont!], for: UIControlState.normal)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if ((currentReachabilityStatus == .reachableViaWiFi) || (currentReachabilityStatus == .reachableViaWWAN))
        {
            print("Connected to Internet")
            webView.loadRequest(URLRequest(url: URL(string: getUrl!)!))
        }
            
        else
        {
            print("NO Connection")
            DispatchQueue.main.async {
                let ac = UIAlertController(title: "NO Connection", message: "Please Check Your Internet or Wifi Connection", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(ac, animated: true, completion: nil)
            }
        }
    }
    
    
    
    @IBAction func backButton(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
