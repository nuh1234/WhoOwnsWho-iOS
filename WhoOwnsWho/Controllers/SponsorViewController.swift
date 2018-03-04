//
//  SponsorViewController.swift
//  WhoOwnsWho
//
//  Created by Nuh Mohamud on 3/4/18.
//  Copyright © 2018 Nuh Mohamud. All rights reserved.
//

import UIKit
import Alamofire

class SponsorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var repImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var model : Model?
    var cid : String?
    var list : [Sponsor]?
    var sponsors : [String] = ["Microsoft Corp", "Boeing Co", "Blue Cross/Blue Shield", "Berkshire Hathaway", "Intellectual Ventures LLC"]
    override func viewDidLoad() {
        super.viewDidLoad()
        if let person = self.model {
            self.cid = self.getIDForName(name: self.stringRebuild(fullName: person.name))
        }
        if let link = model?.imageLink {
            let url = URL(string: link)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if let loadedData = data {
                        self.repImage.image = UIImage(data: loadedData)
                    }
                    
                }
            }
        }
        //request
        //apiRequest()
        //reload table
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated. 
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let loaded = self.list {
            return loaded.count
        }
        return sponsors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sponsorCell", for: indexPath) as! SponsorTableViewCell
//        if let loaded = self.list {
//            cell.cellLabel.text = loaded[indexPath.row].name
//        }else {
//            cell.cellLabel.text = "Unknown"
//        }
        cell.cellLabel.text = sponsors[indexPath.row]
        return cell
    }
    
    func getDataFromPlist(name: String)->(Array<[String:String]>) {
        let path = Bundle.main.path(forResource: name, ofType: "plist")
        var array : NSArray?
        array = NSArray(contentsOfFile: path!)
        return (array as? Array<Dictionary<String,String>>)!
    }
    func getIDForName(name: String)->(String) {
        var array = getDataFromPlist(name: "CIDData")
        array = array.filter{ $0["FIELD2"] == name }
        if let dict = array.first {
            if let id = dict["FIELD1"] {
                return id
            }
        }
        return ""
    }
    
    
    func stringRebuild(fullName: String)-> String{
        let fullNameArr = fullName.components(separatedBy: " ")
        if fullNameArr.count < 3 {
            let firstName: String = fullNameArr[0]
            let lastName: String = fullNameArr[1]
            return lastName + ", " + firstName
        }else if (fullNameArr.count == 3) {
            let firstName: String = fullNameArr[0]
            let middle: String = fullNameArr[1]
            let lastName: String = fullNameArr[2]
            return lastName + ", " + firstName + " " + middle
        }
        return ""
    }
    
    func apiRequest(){
        let param : Parameters = ["cid" : cid ?? "N00007360", "cycle": "2018", "apikey" : Constants.fundingAPIKey, "output": "json"]
        let headers : HTTPHeaders = [:]
        let request = Alamofire.request("https://www.opensecrets.org/api/?method=candContrib", method: .get, parameters: param, encoding: URLEncoding.queryString, headers: headers)
        request.responseJSON { response in
            
            guard let val = response.value,
                let json = val as? [String : Any] else {
                    return
            }
            
            self.list = JsonParser.parseSponsors(json: json)
            self.tableView.reloadData()
            print(self.list!.count)
            
        }
        
    }
    
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


