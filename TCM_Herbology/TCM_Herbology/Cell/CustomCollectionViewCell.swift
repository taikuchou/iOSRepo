//
//  CustomCollectionViewCell.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/24.
//

import UIKit
class CustomCell: UICollectionViewCell {

    var data: HerbVO? {
        didSet {
            guard let data = data else { return }
//            bg.backgroundColor = UIColor.secondaryLabel
            name.text = "\(data.chName) ( \(data.pinyinName) )"
//            latin.text = data.latinName
//            pinyin.text = "( \(data.pinyinName) )"
//            channels.text = "\(data.channels)"
//            name.attributedText = setAttributeString(title: "Name:\n", data: "\(data.chName)")
            latin.attributedText = setAttributeString(title: "Latin:\n", data: "\(data.latinName)")
            pinyin.attributedText = setAttributeString(title: "Pinyin:\n", data: "\(data.pinyinName)")
            channels.attributedText = setAttributeString(title: "Channels:\n", data: "\(data.channels)")
        }
    }

    fileprivate let bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.secondaryLabel.cgColor
        return iv
    }()
    fileprivate let name = {
        let iv = UILabel()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    fileprivate let latin = {
        let iv = UILabel()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.numberOfLines = 0
        return iv
    }()
    fileprivate let pinyin = {
        let iv = UILabel()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    fileprivate let channels = {
        let iv = UILabel()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.numberOfLines = 0
        return iv
    }()
    var viewsDict: [String : Any] = [: ]
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(bg)
        contentView.addSubview(name)
//        contentView.addSubview(pinyin)
        contentView.addSubview(latin)
        contentView.addSubview(channels)
        viewsDict = [
            "name" : name,
            "latin" : latin,
            "pinyin" : pinyin,
            "channels" : channels,
        ]
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[name]-|", options: [], metrics: nil, views: viewsDict))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[name]-[latin]", options: [], metrics: nil, views: viewsDict))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[channels]-|", options: [], metrics: nil, views: viewsDict))
//        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[pinyin]-|", options: [], metrics: nil, views: viewsDict))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[latin]-|", options: [], metrics: nil, views: viewsDict))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[channels]-|", options: [], metrics: nil, views: viewsDict))

        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAttributeString(title: String, data: String? = "") -> NSAttributedString {
        let fs: CGFloat = 14
        let titleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fs, weight: .semibold)]
        let dataAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fs, weight: .regular)]

        let partOne = NSMutableAttributedString(string: title, attributes: titleAttribute)
        let partTwo = NSMutableAttributedString(string: data!, attributes: dataAttribute)

        let combination = NSMutableAttributedString()
        combination.append(partOne)
        combination.append(partTwo)
        return combination
    }
}


