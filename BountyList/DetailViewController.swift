//
//  DetailViewController.swift
//  BountyList
//
//  Created by 문석진 on 2021/03/21.
//

import UIKit

class DetailViewController: UIViewController {

    
    //MVVM
    
    //Model
    // - BountyInfo
    // > BountyInfo 생성(name, bounty)
    
    //View
    // - imgView, nameLabel, bountyLabel
    // > view들은 viewModel을 통해서 구성된다.
    
    //ViewModel
    // - DetailViewModel
    // > View 레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기. BountyInfo를 소유
    
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var bountyLabel: UILabel!
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        
        if let bountyInfo = self.viewModel.bountyInfo{
            imgView.image = UIImage(named: "\(bountyInfo.name).jpg")
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "$\(bountyInfo.bounty)"
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

class DetailViewModel {
    var bountyInfo : BountyInfo?
    
    func updateBountyInfo(_ info : BountyInfo) {
        bountyInfo = info
    }
}

