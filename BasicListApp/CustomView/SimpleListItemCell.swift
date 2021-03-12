//
//  SimpleListItemCell.swift
//  BasicListApp
//
//  Created by Luis Belo on 08/03/21.
//

import Foundation
import UIKit

class SimpleListItemCell: UITableViewCell {
    
    let title: UILabel = {
        let label = UILabel()
        label.textColor = ColorInfo.mainDarkTextColor
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.accessibilityIdentifier = "categoryListCellLabel"
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    let rightChevron: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "right_chevron")?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(UIEdgeInsets(top: -1, left: -1, bottom: -1, right: -1)))
        imageView.tintColor = ColorInfo.mainDarkTextColor
        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView(){
        self.accessibilityIdentifier = "categoryListCellIdentifier"
        self.selectionStyle = .none
        self.backgroundColor = ColorInfo.mainLightBackgroundColor
        
        let mainStack = UIStackView()
        mainStack.axis = .horizontal
        
        mainStack.addArrangedSubview(self.title)
        mainStack.addArrangedSubview(self.rightChevron)
        
        self.contentView.pinView(top: 20, trailing: -20, bottom: -20, leading: 20, viewToPin: mainStack)
    }
    
}
