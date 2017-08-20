//
//  MainTableView.swift
//  Parsing Test
//
//  Created by Saif Aion on 8/11/17.
//  Copyright © 2017 Saif Aion. All rights reserved.
//

import UIKit

class MainTableView: UITableViewController {
    
    
    let paperNews = ["al-jazeera-english", "bbc-news", "cnn", "the-new-york-times", "time", "usa-today"]
    let sportNews = ["espn", "espn-cric-info", "the-sport-bible", "talksport", "fox-sports", "bbc-sport"]
    let techNews = ["techradar", "the-verge", "techcrunch", "mashable", "ign", "google-news", "new-scientist"]


    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource =  self
        
        let screenSize: CGFloat = UIScreen.main.bounds.height
        
        switch screenSize {
        //iphone 7
        case 667:
            self.tableView.rowHeight = 193
            break
            
        //iphone se
        case 568:
            self.tableView.rowHeight = 170
            break
            
        //iphone 7 plus
        case 736:
            self.tableView.rowHeight = 205
            break
            
        //ipad 9.7
        case 1024:
            self.tableView.rowHeight = 255
            break
            
        //ipad 10.5
        case 1112:
            self.tableView.rowHeight = 300
            break
            
        case 1366:
            self.tableView.rowHeight = 325
            break
            
        default:
            print("Height = \(screenSize)")
            break
            
        }
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            return self.paperNews.count
        }
        else if(section == 1){
            return self.sportNews.count
        }
        
        else{
            return self.techNews.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Main News"
        }
        
        else if(section == 1){
            return "Sport News"
        }
        
        else{
            return "Tech News"
        }
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell

        if(indexPath.section == 0){
            cell.nameLabel.text = self.paperNews[indexPath.row]
        }

        else if(indexPath.section == 1){
            cell.nameLabel.text = self.sportNews[indexPath.row]
        }
        
        else{
            cell.nameLabel.text = self.techNews[indexPath.row]
        }
        
        return cell
    }
 
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let gbVC = storyboard?.instantiateViewController(withIdentifier: "news") as! ViewController
        
        if(indexPath.section == 0){
            gbVC.setUrl = self.paperNews[indexPath.row]
        }
        
        else if(indexPath.section == 1){
            gbVC.setUrl = self.sportNews[indexPath.row]
        }
        
        else{
            gbVC.setUrl = self.techNews[indexPath.row]
        }
        
        self.present(gbVC, animated: true, completion: nil)
    }
    

    
    
    @IBAction func aboutButton(_ sender: UIButton)
    {
        let gbVC = storyboard?.instantiateViewController(withIdentifier: "about") as! PoweredByView
        self.present(gbVC, animated: true, completion: nil)


    }
    
    
    
    
    
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    
}
