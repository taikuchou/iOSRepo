//
//  InnerTableViewCell.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/24.
//


import UIKit
import CoreData
class InnerTableViewCell: UITableViewCell {

    let imgUser = UIImageView()
    let tableView = UITableView()
    let titleView = UILabel()
    var managedContext: NSManagedObjectContext!
    func initCoreData() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        managedContext = appDelegate.persistentContainer.viewContext
    }
    var config: (type: DetailsTypes, key: String, title: String, isExpended: Bool)?{
        didSet{
            if let _config = config {
                titleView.text = _config.title
                show(_config.isExpended)
            }
        }
    }
    func show(_ isExpended: Bool){
        if (!isExpended){
            imgUser.image = UIImage(systemName: "arrowshape.down.circle")
            self.tableView.removeFromSuperview()
        }else{
            imgUser.image = UIImage(systemName: "arrowshape.up.circle")
            contentView.addSubview(tableView)
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleView]-[tableView]-|", options: [], metrics: nil, views: viewsDict))
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableView]-|", options: [], metrics: nil, views: viewsDict))
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleView]-|", options: [], metrics: nil, views: viewsDict))
        }
    }
    var list: [String]?{
        didSet{
            if let list {
                tableView.reloadData()
                contentView.setNeedsLayout()
            }
        }
    }

    var viewsDict: [String : Any] = [: ]
    var helperDelegate: HelperDelegate?
    var index = Int()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initCoreData()
        imgUser.isUserInteractionEnabled = true
        imgUser.image = UIImage(systemName: "arrowshape.up.circle")


        let nib = UINib(nibName: "LabelTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CELL")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = .init(top: 0, left: -15, bottom: 0, right: 0)
        imgUser.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imgUser)
        contentView.addSubview(titleView)
        contentView.addSubview(tableView)
        viewsDict = [
            "image" : imgUser,
            "tableView" : tableView,
            "titleView" : titleView,
        ]

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(15)]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleView]-[image(15)]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleView]-[tableView]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableView]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleView]-|", options: [], metrics: nil, views: viewsDict))
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
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension InnerTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let list, let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as? LabelTableViewCell{
            var data = "• "+list[indexPath.row] 
            if #available(iOS 14.0, *) {
                var config = cell.defaultContentConfiguration()
                config.text = data
                cell.contentConfiguration = config
            } else {
                // Fallback on earlier versions
                cell.textLabel?.text = data
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
}


extension InnerTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let list{
            let data = list[indexPath.row]
            if let endIdx = data.index(of: "=") {
                let fufan = "\(data[data.startIndex..<endIdx])"
                let urlString = getURL(fufan)
                if let url = URL(string: urlString){
                    UIApplication.shared.open(url)
                }
            }
        }
    }

    func getURL(_ name: String) -> String {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FufanEntity")
        fetchRequest.predicate = NSPredicate(format: "name == %@ ", name);
        do {
            let fufans: [NSManagedObject] = try managedContext.fetch(fetchRequest)
            if(!fufans.isEmpty){
                let fufan = FufanVO().fromNSManagedObject(fufans[0])
                return fufan.url
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return ""
    }
}



