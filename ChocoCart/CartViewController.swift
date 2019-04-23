//
//  CartViewController.swift
//  ChocoCart
//
//  Created by Sigit Hanafi on 21/04/19.
//  Copyright © 2019 Sigit Hanafi. All rights reserved.
//

import AsyncDisplayKit

class CartViewController: ASViewController<ASDisplayNode> {
    
    private let cartListTableNode = ASTableNode()
    private let checkoutButtonNode = ASButtonNode()
    private let resetButtonNode = ASButtonNode()
    private let shoppingCart = ShoppingCart.sharedCart
    private let emptyCart = ASDisplayNode()
    
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
        
        cartListTableNode.delegate = self
        cartListTableNode.dataSource = self
    }
    
    func generateView() {
        emptyCart.automaticallyManagesSubnodes = true
        emptyCart.style.preferredSize = CGSize(width: cartListTableNode.view.frame.width, height: cartListTableNode.view.frame.height)
        emptyCart.layoutSpecBlock = { (_, _) -> ASLayoutSpec in
            let emptyCartText = ASTextNode()
            emptyCartText.attributedText = NSAttributedString(string: "Your cart is empty! Let's shopping.", attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.7)
                ])
            
            
            let emptyCartTextInsetWrapper = ASCenterLayoutSpec(centeringOptions: ASCenterLayoutSpecCenteringOptions(rawValue: ASCenterLayoutSpecSizingOptions.minimumXY.rawValue), sizingOptions: ASCenterLayoutSpecSizingOptions(arrayLiteral: ASCenterLayoutSpecSizingOptions.minimumXY), child: emptyCartText)
            
            return emptyCartTextInsetWrapper
        }
        
        cartListTableNode.view.separatorStyle = .none
        if shoppingCart.chocolates.count <= 0 {
            cartListTableNode.view.backgroundView = emptyCart.view
        }
        
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
            let cartListTableNodeWrapper = ASWrapperLayoutSpec(layoutElement: self.cartListTableNode)
            cartListTableNodeWrapper.style.flexGrow = 1
            cartListTableNodeWrapper.style.flexShrink = 1
            
            self.checkoutButtonNode.style.width = ASDimensionMake((constrainedSize.max.width - 48) / 2)
            self.resetButtonNode.style.width = ASDimensionMake((constrainedSize.max.width - 48) / 2)
            
            let checkouButtonHorizontalWrapper = ASStackLayoutSpec.horizontal()
            checkouButtonHorizontalWrapper.children = [self.resetButtonNode, self.checkoutButtonNode]
            checkouButtonHorizontalWrapper.spacing = 16
            
            let checkouButtonInsetWrapper = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: checkouButtonHorizontalWrapper)
            checkouButtonInsetWrapper.style.flexGrow = 0
            checkouButtonInsetWrapper.style.flexShrink = 0
            
            let cartNodeVerticalWrapper = ASStackLayoutSpec.vertical()
            cartNodeVerticalWrapper.children = [cartListTableNodeWrapper, checkouButtonInsetWrapper]
            
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: cartNodeVerticalWrapper)
        }
    }
    
    @objc func resetShoppingCart() {
        cart.chocolates = []
        cartListTableNode.view.backgroundView = emptyCart.view
        cartListTableNode.reloadData()
    }

}

extension CartViewController: ASTableDelegate, ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return shoppingCart.chocolates.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let chocolate = shoppingCart.chocolates[indexPath.row]
        return {
            let cell = ChocoViewCell()
            cell.setChocolate(choco: chocolate)
            return cell
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRangeUnconstrained
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        // let chocolate = shoppingCart.chocolates[indexPath.row]
        tableNode.deselectRow(at: indexPath, animated: true)
    }
    
}
