//
//  BountyInfo.swift
//  BountyList
//
//  Created by 문석진 on 2021/03/22.
//

import UIKit

struct BountyInfo {
    let name: String
    let bounty: Int
    var image : UIImage? {
        return UIImage(named:"\(name).jpg")
    }
}
