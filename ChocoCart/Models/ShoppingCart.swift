//
//  ShoppingCart.swift
//  ChocoCart
//
//  Created by Sigit Hanafi on 21/04/19.
//  Copyright © 2019 Sigit Hanafi. All rights reserved.
//

import Foundation
import RxSwift

class ShoppingCart {
    static let sharedCart = ShoppingCart()
    
    let chocolates: Variable<[Chocolate]> = Variable([])
}
