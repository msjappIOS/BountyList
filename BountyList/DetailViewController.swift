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
    @IBOutlet var nameLabelCenterX: NSLayoutConstraint!
    @IBOutlet var bountyLabelCenterX: NSLayoutConstraint!
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        prepareAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimation()
        
    }
    
    private func prepareAnimation() {
        nameLabelCenterX.constant = view.bounds.width
        bountyLabelCenterX.constant = view.bounds.width
    }
    
    private func showAnimation() {
        nameLabelCenterX.constant = 0
        bountyLabelCenterX.constant = 0
        
//        UIView.animate(withDuration: 0.3,
//                       delay: 0.1,
//                       options: .curveEaseIn,
//                       animations: {
//            self.view.layoutIfNeeded()
//        }, completion: nil )
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: .allowUserInteraction, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.transition(with: imgView, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
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

