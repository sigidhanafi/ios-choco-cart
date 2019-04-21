//
//  ChocoViewCell.swift
//  ChocoCart
//
//  Created by Sigit Hanafi on 21/04/19.
//  Copyright © 2019 Sigit Hanafi. All rights reserved.
//

import AsyncDisplayKit

class ChocoViewCell: ASCellNode {
    
    private let chocoNameTextNode = ASTextNode()
    private let chocoPriceTextNode = ASTextNode()
    private let chocoCountryTextNode = ASTextNode()
    private let chocoImagetextNode = ASTextNode()
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true

    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let chocoLeftSideVerticalWrapper = ASStackLayoutSpec.vertical()
        chocoLeftSideVerticalWrapper.children = [self.chocoNameTextNode, self.chocoCountryTextNode]
        
        let chocoLeftSideInsetWrapper = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0), child: chocoLeftSideVerticalWrapper)
        chocoLeftSideInsetWrapper.style.flexGrow = 1
        
        let chocoInfoHorizontalWrapper = ASStackLayoutSpec.horizontal()
        chocoInfoHorizontalWrapper.children = [chocoImagetextNode, chocoLeftSideInsetWrapper, self.chocoPriceTextNode]
        chocoInfoHorizontalWrapper.alignItems = .center
        
        let chocoNodeInsetWrapper = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: chocoInfoHorizontalWrapper)
        
        let chocoCellNodeSeparator = ASDisplayNode()
        chocoCellNodeSeparator.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        chocoCellNodeSeparator.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 0.5)
        
        let chocoNodeVerticalWrapper = ASStackLayoutSpec.vertical()
        chocoNodeVerticalWrapper.children = [chocoNodeInsetWrapper, chocoCellNodeSeparator]
        
        return chocoNodeVerticalWrapper
    }
    
    internal func setChocolate(choco: Chocolate) {
        chocoNameTextNode.attributedText = NSAttributedString(string: choco.name, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: UIColor.black
            ])
        
        chocoPriceTextNode.attributedText = NSAttributedString(string: choco.price, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: UIColor.black
            ])
        
        chocoCountryTextNode.attributedText = NSAttributedString(string: choco.country, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.7)
            ])
        
        chocoImagetextNode.attributedText = NSAttributedString(string: "🍫", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
            ])
    }
}
