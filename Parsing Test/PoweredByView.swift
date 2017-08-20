//
//  PoweredByView.swift
//  Parsing Test
//
//  Created by Saif Aion on 8/11/17.
//  Copyright © 2017 Saif Aion. All rights reserved.
//

import UIKit

class PoweredByView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    @IBAction func poweredByButton(_ sender: UIButton)
    {
        UIApplication.shared.open((NSURL(string: "https://newsapi.org")! as URL), options: [:], completionHandler: nil)
 
    }

    
    @IBAction func backButton(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
}
