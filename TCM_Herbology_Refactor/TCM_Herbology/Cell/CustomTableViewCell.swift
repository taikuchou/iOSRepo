//
//  CustomTableViewCell.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/23.
//
import UIKit
class CustomTableViewCell: UITableViewCell {

    let labUerName = UILabel()
    let labMessage = UILabel()

    var config: (type: DetailsTypes, key: String, title: String, isExpended: Bool)?{
        didSet{

        }
    }
    var viewsDict: [String : Any] = [: ]
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        labUerName.translatesAutoresizingMaskIntoConstraints = false
        labMessage.translatesAutoresizingMaskIntoConstraints = false
        labMessage.numberOfLines = 0
        contentView.addSubview(labUerName)
        contentView.addSubview(labMessage)
        
        viewsDict = [
            "username" : labUerName,
            "message" : labMessage,
        ]
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[username]-[message]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[username]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[message]-|", options: [], metrics: nil, views: viewsDict))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
