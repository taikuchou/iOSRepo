//
//  MyExpandableTableViewCell.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/23.
//

import UIKit
class MyExpandableTableViewCell: UITableViewCell {

    let imgUser = UIImageView()
    let labUerName = UILabel()
    let labMessage = UILabel()
    var config: (type: DetailsTypes, key: String, title: String, isExpended: Bool)?{
        didSet{
            if let config {
                show(config.isExpended)
            }
        }
    }
    func show(_ isExpended: Bool){
        if (!isExpended){
            imgUser.image = UIImage(systemName: "arrowshape.down.circle")
            self.labMessage.removeFromSuperview()
        }else{
            imgUser.image = UIImage(systemName: "arrowshape.up.circle")
            self.contentView.addSubview(self.labMessage)
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[username]-[message]-|", options: [], metrics: nil, views: viewsDict))
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[message]-|", options: [], metrics: nil, views: viewsDict))
        }
    }
    var viewsDict: [String : Any] = [: ]
    var helperDelegate: HelperDelegate?
    var index = Int()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imgUser.isUserInteractionEnabled = true
//        imgUser.backgroundColor = UIColor.blue
        imgUser.image = UIImage(systemName: "arrowshape.up.circle")

        imgUser.translatesAutoresizingMaskIntoConstraints = false
        labUerName.translatesAutoresizingMaskIntoConstraints = false
        labMessage.translatesAutoresizingMaskIntoConstraints = false
        labMessage.numberOfLines = 0

        contentView.addSubview(imgUser)
        contentView.addSubview(labUerName)
        contentView.addSubview(labMessage)

        viewsDict = [
            "image" : imgUser,
            "username" : labUerName,
            "message" : labMessage,
        ] as [String : Any]

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(15)]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[username]-[image(15)]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[username]-[message]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[username]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[message]-|", options: [], metrics: nil, views: viewsDict))
        addTapEvent()
    }

    func addTapEvent() {
        let panGesture = UITapGestureRecognizer(target: self, action: #selector(handleActon))
        imgUser.addGestureRecognizer(panGesture)

    }
    @objc private func handleActon() {

        guard let _config = config else {
            return
        }

        UIView.animate(withDuration: 0.3) {
            self.show(_config.isExpended)
            //self.contentView.setNeedsLayout()
            self.helperDelegate?.heightChanged(index: self.index, value: !_config.isExpended)
        }
    }


    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            if let _config = config{
                UIView.animate(withDuration: 0.3) {
                    self.show(_config.isExpended)
                    self.helperDelegate?.heightChanged(index: self.index, value: !_config.isExpended)
                }
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

