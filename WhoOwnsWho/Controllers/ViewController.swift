//
//  ViewController.swift
//  WhoOwnsWho
//
//  Created by Nuh Mohamud on 3/3/18.
//  Copyright © 2018 Nuh Mohamud. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var list : [Model]?
    var location : String?
    private var address: String = ""
    @IBOutlet weak var addressOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func addressEntered(_ sender: Any) {
        if addressOutlet.text!.count > 1 {
            self.address = addressOutlet.text!
            request()
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is RepViewController
        {
            
            let view = segue.destination as? RepViewController
            view?.list = self.list
            view?.location = self.location
        }
    }
    
    private func request() {
        
        //let levels = []
        let param : Parameters = ["address" : self.address, "key" : Constants.apiKey]
        let headers : HTTPHeaders = [:]
        let request = Alamofire.request("https://www.googleapis.com/civicinfo/v2/representatives", method: .get, parameters: param, encoding: URLEncoding.queryString, headers: headers)
        request.responseJSON { response in
        
            guard let val = response.value,
                let json = val as? [String : Any] else {
                return
            }
    
            self.list = JsonParser.parse(json: json)
            self.location = JsonParser.parseLocation(json: json)
            self.performSegue(withIdentifier: "mainToSecond", sender: self)

        }
        
        
    }
    
}

