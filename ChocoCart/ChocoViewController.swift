//
//  ViewController.swift
//  ChocoCart
//
//  Created by Sigit Hanafi on 21/04/19.
//  Copyright © 2019 Sigit Hanafi. All rights reserved.
//

import AsyncDisplayKit

class ChocoViewController: ASViewController<ASDisplayNode> {
    
    private let chochoTableView = ASTableNode()
    private var rightButtonItem = UIBarButtonItem()
    
    private var chocoList = [Chocolate]()
    private let cart = ShoppingCart.sharedCart
    
    init() {
        let node = ASDisplayNode()
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true

        chocoList.append(Chocolate(name: "Belgian Choco - Almond", country: "Belgium", price: "100.000"))
        chocoList.append(Chocolate(name: "Belgian Choco - Dark", country: "Belgium", price: "130.000"))
        chocoList.append(Chocolate(name: "Belgian Choco - Milk", country: "Belgium", price: "130.000"))
        chocoList.append(Chocolate(name: "Belgian Choco - Dark & Milk", country: "Belgium", price: "150.000"))
        
//        cart.chocolates.append(Chocolate(name: "Belgian Choco - Dark & Milk", country: "Belgium", price: "150.000"))
        
        super.init(node: node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Choco Shop"
        navigationController?.navigationBar.isTranslucent = false
        
        rightButtonItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)
            ], for: .normal)
        rightButtonItem.action = #selector(openCartViewController)
        rightButtonItem.target = self
        navigationItem.rightBarButtonItem = rightButtonItem
        
        generateView()
        updateCartCount()
        
        chochoTableView.delegate = self
        chochoTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateCartCount()
    }

    func generateView() {
        self.chochoTableView.view.separatorStyle = .none
        
        node.layoutSpecBlock = { (_, constrainedSize) -> ASLayoutSpec in
            return ASWrapperLayoutSpec(layoutElement: self.chochoTableView)
        }
        
    }
    
    func updateCartCount() {
        rightButtonItem.title = "Cart (\(cart.chocolates.count))"
    }
    
    func addToCart(chocolate: Chocolate) {
        cart.chocolates.append(chocolate)
        updateCartCount()
    }
    
    @objc func openCartViewController() {
        let cartViewController = CartViewController()
        navigationController?.pushViewController(cartViewController, animated: true)
    }

}

extension ChocoViewController: ASTableDelegate, ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.chocoList.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let chocolate = chocoList[indexPath.row]
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
        let chocolate = chocoList[indexPath.row]
        addToCart(chocolate: chocolate)
        tableNode.deselectRow(at: indexPath, animated: true)
    }
}

