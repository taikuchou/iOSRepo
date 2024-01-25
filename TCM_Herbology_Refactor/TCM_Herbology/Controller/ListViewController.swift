//
//  ListViewController.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/22.
//

import UIKit
import CoreData

class ListViewController: UITableViewController {
    lazy var searchBar: UISearchBar = UISearchBar()
    var showType = ShowTypes.all
    var managedContext: NSManagedObjectContext!
    var lists = [HerbVO]()
    var glists = [String]()
    var gdatalists = [[HerbVO]]()
    func initCoreData() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        managedContext = appDelegate.persistentContainer.viewContext
    }
    func initHerbList(_ key: String? = nil){
        lists.removeAll()
        glists.removeAll()
        gdatalists.removeAll()
        var gSet = Set<String>()
        if let herbs: [NSManagedObject] = HerbDAO.shared.getResultByKey(key: key) {
            for data in herbs{
                var herb = HerbVO.fromNSManagedObject(data)
                lists.append(herb)
                gSet.insert(herb.group)
            }
            glists = gSet.sorted()
            for i in 0..<glists.count{
                initGroupHerbList(i,key)
            }
        }
    }

    @IBAction func handler(_ sender: UISegmentedControl) {
        showType = ShowTypes(rawValue: sender.selectedSegmentIndex) ?? ShowTypes.all
        self.tableView.reloadData()
    }
    func initGroupHerbList(_ idx : Int, _ key: String? = nil){
        let group = glists[idx]
        var list = [HerbVO]()
        if let herbs: [NSManagedObject] = HerbDAO.shared.getResultByGroupAndKey(group: group, key: key){
            for data in herbs{
                var herb = HerbVO.fromNSManagedObject(data)
                list.append(herb)
            }
            gdatalists.append(list)
        }
    }
    var showSearchBar = false
    @IBAction func searchHandler(_ sender: UIBarButtonItem) {
        showSearchBar = !showSearchBar
        if showSearchBar{
            self.tableView.tableHeaderView = searchBar;
        }else{
            self.tableView.tableHeaderView = nil;
        }
    }
    func initSearchBar(){
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        //navigationItem.titleView = searchBar
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initCoreData()
        initHerbList()
        initSearchBar()
//        print(NSHomeDirectory())
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if showType == .all {
            return 1
        }
        return glists.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if showType == .all {
            return ""
        }
        return glists[section]
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if showType == .all {
            return ""
        }
        return "Total: \(gdatalists[section].count)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if showType == .all {
            return lists.count
        }
        return gdatalists[section].count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        var data: HerbVO
        if showType == .all {
            data = lists[indexPath.row]
        }else{
            data = gdatalists[indexPath.section][indexPath.row]
        }
        let title = "\(data.chName) (\(data.pinyinName))"
        let subtitle = "\(data.efficacy)"
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let next = segue.destination as? HerbDetailsViewController, let indexPath = self.tableView.indexPathForSelectedRow {
            if showType == .all {
                next.data = lists[indexPath.row]
            }else{
                next.data = gdatalists[indexPath.section][indexPath.row]
            }
        }
    }


}

enum ShowTypes: Int{
    case all,group
}


extension ListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchText)")
        initHerbList(searchText)
        self.tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.reloadData()
    }


}
