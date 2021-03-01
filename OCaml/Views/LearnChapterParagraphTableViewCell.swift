//
//  LearnChapterParagraphTableViewCell.swift
//  OCaml
//
//  Created by Nathan FALLET on 06/01/2021.
//

import UIKit

class LearnChapterParagraphTableViewCell: UITableViewCell, LearnChapterCell {

    static var identifier: String { return "paragraphCell" }

    var label = UILabel()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func with(element: LearnChapterElement, in tableView: UITableView) -> UITableViewCell {
        if let paragraph = element as? LearnParagraph {
            label.text = paragraph.content.localized()
        }
        
        return self
    }

}