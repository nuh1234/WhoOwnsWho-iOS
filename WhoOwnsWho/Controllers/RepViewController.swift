//
//  RepViewController.swift
//  WhoOwnsWho
//
//  Created by Nuh Mohamud on 3/3/18.
//  Copyright © 2018 Nuh Mohamud. All rights reserved.
//

import UIKit

class RepViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    var list : [Model]?
    var location : String?
    private var index : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if let locationLoaded = location {
            self.title = locationLoaded
            let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.init(red: 50/255.0, green: 60/255.0, blue: 139/255.0, alpha: 1)]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
            self.navigationController?.navigationBar.tintColor = UIColor.init(red: 50/255.0, green: 60/255.0, blue: 139/255.0, alpha: 1);

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.index = indexPath.row
        self.performSegue(withIdentifier: "repToSponsors", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SponsorViewController
        {
            let view = segue.destination as? SponsorViewController
            view?.model = self.list?[index]
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let loaded = list {
            return loaded.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RepresentativeCollectionViewCell
        if let loaded = list {
            if let link = loaded[indexPath.row].imageLink {
                let url = URL(string: link)
                
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!) 
                    DispatchQueue.main.async {
                        if let loadedData = data {
                            cell.cellImage.image = UIImage(data: loadedData)
                        }
                        collectionView.reloadInputViews()
                    }
                }
            }
            cell.layer.cornerRadius = 8
            cell.nameLabel.text = loaded[indexPath.row].name
            let party : String = loaded[indexPath.row].party
            cell.partyLabel.text = party
            cell.partyLabel.textColor = partyColor(party: party)
            if let office = loaded[indexPath.row].position {
                cell.officeLabel.text = office
            }else {
                cell.officeLabel.text = "Local"
            }
            
        }
        return cell
    }

    func partyColor(party: String) -> UIColor {
        switch party {
        case "Democratic":
            return UIColor.init(red: 135/255.0, green: 206/255.0, blue: 250/255.0, alpha: 1)
        case "Republican":
            return UIColor.red
        case "Independent":
            return UIColor.green
        default:
            UIColor.white
        }
        return UIColor.white

    }
   
}
