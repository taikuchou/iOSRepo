//
//  CustomTableViewCell.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/23.
//
import UIKit
class CustomTableViewCell: UITableViewCell {

//    let imgUser = UIImageView()
    let labUerName = UILabel()
    let labMessage = UILabel()
//    let labTime = UILabel()
    var config: (type: DetailsTypes, key: String, title: String, isExpended: Bool)?{
        didSet{

        }
    }
    var viewsDict: [String : Any] = [: ]
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

//        imgUser.backgroundColor = UIColor.blue
//
//        imgUser.translatesAutoresizingMaskIntoConstraints = false
        labUerName.translatesAutoresizingMaskIntoConstraints = false
        labMessage.translatesAutoresizingMaskIntoConstraints = false
        labMessage.numberOfLines = 0
//        labTime.translatesAutoresizingMaskIntoConstraints = false

//        contentView.addSubview(imgUser)
        contentView.addSubview(labUerName)
        contentView.addSubview(labMessage)
//        contentView.addSubview(labTime)

        viewsDict = [
//            "image" : imgUser,
            "username" : labUerName,
            "message" : labMessage,
            //"labTime" : labTime,
            ] as [String : Any]

//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(10)]", options: [], metrics: nil, views: viewsDict))
        //contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[labTime]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[username]-[message]-|", options: [], metrics: nil, views: viewsDict))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[username]-[image(10)]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[username]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[message]-|", options: [], metrics: nil, views: viewsDict))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
