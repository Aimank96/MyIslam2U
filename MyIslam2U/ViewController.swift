//
//  ViewController.swift
//  MyIslam2U
//
//  Created by Metech3 on 18/04/2017.
//  Copyright © 2017 Ayus. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var surahTableView: UITableView!

    var Surah = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        surahTableView.estimatedRowHeight = 60
        surahTableView.rowHeight = UITableViewAutomaticDimension
        
        loadAPI()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Surah.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = surahTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomIndexSurahTableViewCell
        
        let indexSurah = Surah[indexPath.row] as! Dictionary<String, AnyObject>
        let namaSurah = indexSurah["translated_name"] as! String
        
        cell.titleLbl.text = namaSurah
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexSurah = Surah[indexPath.row] as! Dictionary<String, AnyObject>
        let idSurah = indexSurah["id"] as! Int
        print("\(idSurah)")
    }
    
    func loadAPI() {
        Alamofire.request("https://quran.kiblat.my/surah/index").responseJSON { response in
            
            switch response.result {
            case .success:
                
                do {
                    
                    let json = try JSON(JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers))
                    
                    if json["status"].string == "OK" {
                        
                        self.Surah = json["surah"].arrayObject!
                        
                        self.surahTableView.reloadData()
                        
                        // ((json["surah"].arrayObject)?[0] as! Dictionary<String, AnyObject>)["id"] as! String
                        
                    } else {
                        
                    }
                    
                } catch {
                    
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }

}

