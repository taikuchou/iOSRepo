//
//  HerbDetailsViewController.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/23.
//

import UIKit

class HerbDetailsViewController: UITableViewController {
    @IBAction func webHandler(_ sender: Any) {
        if let data, let url = URL(string: data.url){
            UIApplication.shared.open(url)
        }
    }
    var data: HerbVO!
    var displaySettings: [(type: DetailsTypes, key: String, title: String, isExpended: Bool)] = //[.general_info,.cautions,.indications,.efficacy,.combinations,.fufan,.others]
    [(.general_info,"category","Category",true),(.general_info,"commonName","Common Name",true),(.general_info,"literalEnglish","Literal English",true),(.general_info,"dosage","Dosage",true),(.general_info,"channels","Channels",true),(.general_info,"properties","Properties",true),(.list_info,"actionsIndications","Actions and Indications",true),(.list_info,"contraindicationsCautions","Contraindications / Cautions",true),(.list_info,"efficacy","Efficacy",true),(.list_info,"commonCombinations","Common Combinations",true),(.list_info,"others","Others",true),(.list_info,"fuFan","FuFan",true)]
    var herbDict = [String: String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(data.chName) (\(data.pinyinName))"
        initHerbDict()
        self.tableView.rowHeight = UITableView.automaticDimension;
        let textFieldCell = UINib(nibName: "ExpandableTableViewCell",
                                      bundle: nil)
        tableView.register(textFieldCell, forCellReuseIdentifier: "ExpandableTableViewCell")
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        tableView.register(MyExpandableTableViewCell.self, forCellReuseIdentifier: "MyExpandableTableViewCell")


    }
    func initHerbDict(){
        let mirror = Mirror(reflecting: data!)

        for child in mirror.children {
            herbDict[child.label ?? ""] = "\(child.value)"
        }
    }
    func getHerbData(key: String) -> String{
        var ret = "N/A"
        if let text = herbDict[key]{
            if text.trimmingCharacters(in: CharacterSet.whitespaces).count != 0 {
                ret = "\(text.replacingOccurrences(of: "， ", with: ",", options: .literal, range: nil))"
            }
        }
        return ret
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return displaySettings.count
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.invalidateIntrinsicContentSize()
        tableView.layoutIfNeeded()
    }
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        let data = displaySettings[indexPath.row]
//        if data.type == .list_info {
//            return 700
//        }else {
//            return 50
//        }
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let data = displaySettings[indexPath.row]
        let title = "\(data.title)"
        let subtitle = "\(getHerbData(key: data.key))"
        if data.type == .general_info {
            cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
            if #available(iOS 14.0, *) {
                var config = cell.defaultContentConfiguration()
                config.text = title
                config.secondaryText = subtitle
                cell.contentConfiguration = config
            } else {
                // Fallback on earlier versions
                cell.textLabel?.text = title
                cell.detailTextLabel?.text = subtitle
            }
        }
//        else if data.type == .list_info{
//            cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath)
//            if let cell1 = cell as? CustomTableViewCell{
////                cell1.labTime.text = title
//                var stext = subtitle
//                if subtitle.contains("|") {
//                    stext = "\(subtitle.replacingOccurrences(of: "|", with: "\n"))"
//                }
//                if stext.contains("•") {
//                    stext = "\(stext.replacingOccurrences(of: "•", with: "\n•"))"
//                }
//                if stext.contains("◦") {
//                    stext = "\(stext.replacingOccurrences(of: "◦", with: "\n•"))"
//                }
//                if stext.starts(with: "\n"){
//                    stext = "\(stext[stext.index(stext.startIndex, offsetBy: 1)..<stext.endIndex])"
//                }
//                cell1.labMessage.text = stext
//                cell1.labUerName.text = "\(title)"
//            }

//        }
        else if data.type == .list_info{
            cell = tableView.dequeueReusableCell(withIdentifier: "MyExpandableTableViewCell", for: indexPath)
            if let cell1 = cell as? MyExpandableTableViewCell{
                var stext = subtitle
                if subtitle.contains("|") {
                    stext = "\(subtitle.replacingOccurrences(of: "|", with: "\n"))"
                }
                if subtitle.contains("•") {
                    stext = "\(subtitle.replacingOccurrences(of: "•", with: "\n•"))"
                }
                if subtitle.contains("◦") {
                    stext = "\(subtitle.replacingOccurrences(of: "◦", with: "\n•"))"
                }
                if stext.starts(with: "\n"){
                    stext = "\(stext[stext.index(stext.startIndex, offsetBy: 1)..<stext.endIndex])"
                }
                cell1.labMessage.text = stext
                cell1.labUerName.text = "\(title)"
                cell1.index = indexPath.row
                cell1.config = data
                cell1.helperDelegate = self
            }

        }else{
            cell = UITableViewCell()
        }
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
enum DetailsTypes: Int{
    case general_info,list_info,test//cautions,indications,efficacy,combinations,fufan,others
}

extension UITableView {

    public override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }

    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

}

extension HerbDetailsViewController: HelperDelegate {

    func heightChanged(index: Int, value: Bool) {
        displaySettings[index].isExpended = value
//        tableView.performBatchUpdates(nil)
        tableView.reloadData()
    }

}
