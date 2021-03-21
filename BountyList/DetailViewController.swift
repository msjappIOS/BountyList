//
//  DetailViewController.swift
//  BountyList
//
//  Created by 문석진 on 2021/03/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var bountyLabel: UILabel!
    
    var name: String?
    var bounty: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        
        if let name = self.name , let bounty = self.bounty {
            imgView.image = UIImage(named: "\(name).jpg")
            nameLabel.text = name
            bountyLabel.text = "$\(bounty)"
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
