//
//  BountyViewController.swift
//  BountyList
//
//  Created by 문석진 on 2021/03/16.
//

import UIKit

class BountyViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    //UICollectionViewDataSource
    //몇개를 보여줄 것인지..?
    //셀은 어떻게 표현할 것인지?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else {
            return UICollectionViewCell()
        }
        
        if let info = viewModel.bountyInfo(indexPath.item){
            cell.update(val : info)
        }
        return cell
    }

    //UICollectionViewDelegate
    //셀이 클릭되었을 때 어떻게 할 것인지?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: indexPath.item)
        
    }

    //UICollectionViewDelegateFlowLayout
    //cell size 계산 ( 목표 : 다양한 디바이스에서 일관적인 디자인을 보여주기 위해 )
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemSpacing: CGFloat = 10 // 가로에서 cell과 cell 사이의 거리
            let textAreaHeight: CGFloat = 65 // textLabel이 차지하는 높이
            let width: CGFloat = (collectionView.bounds.width - itemSpacing)/2 // 셀 하나의 너비
            let height: CGFloat = width * 10/7 + textAreaHeight //셀 하나의 높이

            return CGSize(width: width, height: height)
        }

    
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
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numOfBountyInfoList
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
//            return UITableViewCell()
//        }
//
//        if let info = viewModel.bountyInfo(indexPath.row) {
//            cell.update(val : info)
//        }
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        print("--> \(indexPath.row)")
//        self.performSegue(withIdentifier: "showDetail", sender: indexPath.row)
//    }
//
    func setBountyInfo() {
        
        let nameList = viewModel.getNameList()
        let bountyList = viewModel.getBountyList()
        
        for i in 0...bountyList.count-1 {
            viewModel.bountyInfoList.append(BountyInfo(name: nameList[i], bounty: bountyList[i]))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
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

class GridCell : UICollectionViewCell {
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
