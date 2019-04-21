//
//  CartViewController.swift
//  ChocoCart
//
//  Created by Sigit Hanafi on 21/04/19.
//  Copyright © 2019 Sigit Hanafi. All rights reserved.
//

import AsyncDisplayKit

class CartViewController: ASViewController<ASDisplayNode> {
    
    private let checkoutButtonNode = ASButtonNode()
    private let resetButtonNode = ASButtonNode()
    
    private let cart = ShoppingCart.sharedCart
    
    init() {
        let node = ASDisplayNode()
        node.automaticallyManagesSubnodes = true
        super.init(node: node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        title = "Choco Cart"
        
        print(cart.chocolates.count)
        
        generateView()
    }
    
    func generateView() {
        let checkoutButtonAttributedString = NSAttributedString(string: "Checkout", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor.white
            ])
        checkoutButtonNode.setAttributedTitle(checkoutButtonAttributedString, for: .normal)
        checkoutButtonNode.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        checkoutButtonNode.contentEdgeInsets = UIEdgeInsets(top: 12, left: 32, bottom: 12, right: 32)
        checkoutButtonNode.cornerRadius = 4
        checkoutButtonNode.style.flexGrow = 1
        
        let resetButtonAttributedString = NSAttributedString(string: "Reset", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5)
            ])
        resetButtonNode.setAttributedTitle(resetButtonAttributedString, for: .normal)
        resetButtonNode.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        resetButtonNode.contentEdgeInsets = UIEdgeInsets(top: 12, left: 32, bottom: 12, right: 32)
        resetButtonNode.cornerRadius = 4
        resetButtonNode.style.flexGrow = 1
        resetButtonNode.addTarget(self, action: #selector(resetShoppingCart), forControlEvents: .touchUpInside)
        
        node.layoutSpecBlock = { (_, constrainedSize) -> ASLayoutSpec in
            self.checkoutButtonNode.style.width = ASDimensionMake((constrainedSize.max.width - 48) / 2)
            self.resetButtonNode.style.width = ASDimensionMake((constrainedSize.max.width - 48) / 2)
            
            let checkouButtonHorizontalWrapper = ASStackLayoutSpec.horizontal()
            checkouButtonHorizontalWrapper.children = [self.resetButtonNode, self.checkoutButtonNode]
            checkouButtonHorizontalWrapper.spacing = 16
            
            let cartNodeVerticalWrapper = ASStackLayoutSpec.vertical()
            cartNodeVerticalWrapper.children = [checkouButtonHorizontalWrapper]
            
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: cartNodeVerticalWrapper)
        }
    }
    
    @objc func resetShoppingCart() {
        cart.chocolates = []
    }

}
