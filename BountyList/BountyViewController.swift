//
//  BountyViewController.swift
//  BountyList
//
//  Created by 문석진 on 2021/03/16.
//

import UIKit

class BountyViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    //MVVM
    
    //Model
    // - BountyInfo
    // > BountyInfo 생성(name, bounty)
    
    //View
    // - ListCell
    // > ListCell에 필요한 정보를 ViewModel 한테서 받는다.
    // > ListCell은 ViewModel로 부터 받은 정보로 뷰 업데이트를 한다.
    
    //ViewModel
    // - BountyViewModel
    // > BountyViewModel을 만든다. View 레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기. BountyInfo를 소유
    
    
    //var bountyInfoList : [BountyInfo] = []
    let viewModel = BountyViewModel()
    
    @IBOutlet var tableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let vc = segue.destination as? DetailViewController {
                if let index = sender as? Int {
                    if let bountyInfo = viewModel.bountyInfo(index) {
                        vc.viewModel.updateBountyInfo(bountyInfo)
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        
        if let info = viewModel.bountyInfo(indexPath.row) {
            cell.update(val : info)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("--> \(indexPath.row)")
        self.performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
    
    func setBountyInfo() {
        
        let nameList = viewModel.getNameList()
        let bountyList = viewModel.getBountyList()
        
        for i in 0...bountyList.count-1 {
            viewModel.bountyInfoList.append(BountyInfo(name: nameList[i], bounty: bountyList[i]))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setBountyInfo()
    }
}

class ListCell : UITableViewCell {
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var bountyLabel : UILabel!
    
    func update(val : BountyInfo) {
        imgView.image = val.image
        nameLabel.text = val.name
        bountyLabel.text = "$\(val.bounty)"
    }
}

class BountyViewModel {
    
    let nameList = ["brook", "chopper", "franky", "luffy", "nami", "robin", "sanji", "zoro"]
    let bountyList = [33000000, 50, 44000000, 300000000, 16000000, 80000000, 77000000, 120000000]
    var bountyInfoList : [BountyInfo] = []
    var sortedList : [BountyInfo] {
        let sorted = bountyInfoList.sorted { (prev, next) -> Bool in
            return prev.bounty > next.bounty
        }
        return sorted
    }
    
    var numOfBountyInfoList : Int {
        return bountyInfoList.count
    }
    
    func bountyInfo(_ index : Int) -> BountyInfo? {
        return sortedList[index]
    }
    
    func getNameList() -> [String] {
        return nameList
    }
    
    func getBountyList() -> [Int] {
        return bountyList
    }
}
