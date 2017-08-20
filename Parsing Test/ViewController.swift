//
//  ViewController.swift
//  Parsing Test
//
//  Created by Saif Aion on 5/7/17.
//  Copyright © 2017 Saif Aion. All rights reserved.
//

import UIKit
import Kingfisher
import GoogleMobileAds


var nameArray: [String] = []

var capitalArray: [String] = []

var sortedCountryArray : [String] = []

var sortedCapitalArray : [String] = []

var authorArray : [String] = []

var titleArray : [String] = []

var imageURL : [String] = []

var cache = NSCache<AnyObject, AnyObject>()

var cacheItem : [String] = []

var refreshControl: UIRefreshControl?

var urlArray : [String] = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate, GADInterstitialDelegate {
    
    
    @IBOutlet var CountryNameTable: UITableView!
    
    static var getCellNumber:NSString = ""
    
    var setUrl:String!
    
    var timerSet = Timer()
    
    var interstital: GADInterstitial!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CountryNameTable.delegate = self
        self.CountryNameTable.dataSource = self
        
        let screenSize: CGFloat = UIScreen.main.bounds.height
        
        switch screenSize {
        //iphone 7
        case 667:
            self.CountryNameTable.rowHeight = 193
            break
            
        //iphone se
        case 568:
            self.CountryNameTable.rowHeight = 170
            break
            
        //iphone 7 plus
        case 736:
            self.CountryNameTable.rowHeight = 205
            break
            
        //ipad 9.7
        case 1024:
            self.CountryNameTable.rowHeight = 255
            break
            
        //ipad 10.5
        case 1112:
            self.CountryNameTable.rowHeight = 300
            break
            
        case 1366:
            self.CountryNameTable.rowHeight = 325
            break
            
        default:
            print("Height = \(screenSize)")
            break
            
        }
        
        
        showAdmobBanner()
        
        timerSet = Timer.scheduledTimer(timeInterval: 90, target: self, selector: #selector(showInterstital), userInfo: nil, repeats: true)
        
        
        cacheItem = []
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
            if ((currentReachabilityStatus == .reachableViaWiFi) || (currentReachabilityStatus == .reachableViaWWAN))
            {
                print("Connected to Internet")
                self.parseJSon2()
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
    
    
    
    func showAdmobBanner()
    {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let bannerView = GADBannerView(frame: CGRect(x: 0, y: screenSize.height-50, width: 320, height: 50))
        bannerView.center.x = self.view.center.x
        bannerView.autoresizingMask = UIViewAutoresizing.flexibleBottomMargin
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-9421421942329381/8449902872"
        bannerView.rootViewController = self
        self.view.addSubview(bannerView)
        
        let request: GADRequest = GADRequest()
        
        //request.testDevices = [kGADSimulatorID]
        
        bannerView.load(request)
    }
    
    
    func showInterstital()
    {
        interstital = GADInterstitial(adUnitID: "ca-app-pub-9421421942329381/3006004501")
        interstital.delegate = self
        let request = GADRequest()
        //request.testDevices = [kGADSimulatorID]
        interstital.load(request)
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        interstital.present(fromRootViewController: self)
    }

    
    
    
    func parseJSon2()
    {
        authorArray = []
        titleArray = []
        imageURL = []
        urlArray = []
        
        
        let url = "https://newsapi.org/v1/articles?source=\(setUrl!)&sortBy=top&apiKey=74e11fde433244be85ab969c727c21ba"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if (error != nil)
            {
                print(error!)
            }
            else
            {
                do
                {
                    let fetchData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    let actorArray = fetchData?["articles"] as? NSArray
                    for actor in actorArray!
                    {
                        let nameDict = actor as? NSDictionary
        
                        let title = nameDict?["title"] as! String
                        let description = nameDict?["description"] as! String
                        let imageUrl = nameDict?["urlToImage"] as! String
                        let pageUrl = nameDict?["url"] as! String
                        
                        authorArray.append(title)
                        titleArray.append(description)
                        imageURL.append(imageUrl)
                        urlArray.append(pageUrl)
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.CountryNameTable.reloadData()
                    }
                    
                    print(authorArray)
                    print(titleArray)
                    print(imageURL)
                    print(urlArray)
                }
                    
                catch let Error2
                {
                    print(Error2.localizedDescription)
                    
                    if let string = String(data: data!, encoding: .utf8)
                    {
                        print(string)
                        print(response!)
                    }
                }
                
            }
        }
        
        task.resume()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return authorArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CountryNameTableCell
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        cell.imgView.layer.cornerRadius = 10
        
        cell.authorLabel.text = authorArray[indexPath.row]
        cell.titleLabel.text = titleArray[indexPath.row]
        
        
        
        // 1
        
        cacheItem = [titleArray[indexPath.row]]
        
        
        // 2
        
        /*if let img = cache.object(forKey: imageURL[indexPath.row] as AnyObject)
        {
            cell.imgView.image = img as? UIImage
        }
        else
        {
            //cell.imgView.downloadImage(from: imageURL[indexPath.row])
            
            DispatchQueue.global().async {
                let url = NSURL(string: imageURL[indexPath.row])
                let data = NSData(contentsOf: (url! as URL))
                
                DispatchQueue.main.async {
                    cell.imgView.image = UIImage(data: data! as Data)
                    cache.setObject(cell.imgView.image!, forKey: imageURL[indexPath.row] as AnyObject)
                }
            }
        }*/
        
        // 3
        
        let resource = ImageResource(downloadURL: URL(string: imageURL[indexPath.row])!, cacheKey: imageURL[indexPath.row])
        
        cell.imgView.kf.setImage(with: resource)
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let gbVC = storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        
        gbVC.getUrl = urlArray[indexPath.row]
        
        self.present(gbVC, animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func refresh() {
        // Code to refresh table view
        
        DispatchQueue.main.async {
            self.CountryNameTable.reloadData()
            refreshControl?.endRefreshing()
        }
    }
    
    
    @IBAction func backButton(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension UIImageView
{
    func downloadImage(from url: String)
    {
        let urlReuest = URLRequest(url : URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlReuest) {(data, response, error) in
         
            if error != nil{
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
                cache.setObject(self.image!, forKey: cacheItem as AnyObject)
            }
        }
        
        task.resume()
    }
}

