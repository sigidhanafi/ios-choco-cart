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
    
    init() {
        let node = ASDisplayNode()
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
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
        
        let rightButtonItem = UIBarButtonItem()
        rightButtonItem.title = "Cart"
        rightButtonItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)
            ], for: .normal)
        rightButtonItem.action = #selector(openCartViewController)
        rightButtonItem.target = self
        navigationItem.rightBarButtonItem = rightButtonItem
        
        generateView()
        
        chochoTableView.delegate = self
        chochoTableView.dataSource = self
    }

    func generateView() {
        self.chochoTableView.view.separatorStyle = .none
        
        node.layoutSpecBlock = { (_, constrainedSize) -> ASLayoutSpec in
            return ASWrapperLayoutSpec(layoutElement: self.chochoTableView)
        }
        
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
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let cell = ChocoViewCell()
            return cell
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRangeUnconstrained
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
    }
}

