//
//  ViewController.swift
//  json dat complex
//
//  Created by macmini01 on 23/11/17.
//  Copyright © 2017 Avasoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource ,UITableViewDelegate {
    
    
    let urlStringdemo = "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors"
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var imageArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Downloadurl()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func Downloadurl() {
        let url = NSURL(string: urlStringdemo)
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            // let urlStringdemo = "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors"
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary{
                if let actorarry = jsonObj!.object(forKey: "actors") as? NSArray {
                    for actor in actorarry {
                        if let actdicinary = actor as? NSDictionary {
                            if let image = actdicinary.value(forKey: "image"){
                                self.imageArray.append(image as! String)
                            }
                            OperationQueue.main.addOperation ({
                                self.tableView.reloadData()
                            })
                        }
                    }
                }
            }
            
            
        }).resume()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        let imageUrl = NSURL(string: imageArray[indexPath.row])
        let data = NSData(contentsOf: imageUrl! as URL)
        cell.imageview.image = UIImage(data: data! as Data)
        cell.imageview?.layer.cornerRadius = (cell.imageview?.frame.size.width)! / 3
        cell.imageview?.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray.count  - 3
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
//            self.dataprint(number: (indexPath.row), number2: (imageArray.count - 1))
       
//        if(indexPath.row == 1){
//        let imageSelected = imageArray[indexPath.row];
//        imageArray.remove(at: indexPath.row)
//        imageArray.insert(imageSelected, at: (indexPath.row + 1 ) )
//        self.tableView .reloadData()
//        }
        
        if(indexPath.row == 1){
        
        let newArray = imageArray
        imageArray.removeAll()
        for i in indexPath.row ..< newArray.count {
        
            let image = newArray[i]
            imageArray.append(image)

        }
        for i in 0 ..< indexPath.row
        {
            let image = newArray[i]
            imageArray.append(image)
            
        }

        self.tableView .reloadData()
    }
    }
   
}


