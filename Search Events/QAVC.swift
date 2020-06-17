//
//  QAVC.swift
//  FblaSignUpPage
//
//  Created by Sid on 1/2/20.
//  Copyright © 2020 sid. All rights reserved.
//

import UIKit

class QAVC: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
     let animationTiming = 0.5
    var competitions: [CompData]?
    var firstDelimiter: Int?
    var currentTag = 0
    var currentColor = #colorLiteral(red: 0.6901960784, green: 0.7215686275, blue: 0.8588235294, alpha: 1)
    
     @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var informationView  : UIView!
       @IBOutlet weak var informationLabel : UILabel!
       @IBOutlet weak var cancelButton: UIButton!
       @IBOutlet weak var titleLabel: UILabel!
       @IBOutlet weak var subLabel: UILabel!
       @IBOutlet weak var clusterLabel: UILabel!
    @IBOutlet weak var IndivObjecBtn    : UIButton!
       @IBOutlet weak var impromptuBtn     : UIButton!
       @IBOutlet weak var indivOralBtn     : UIButton!
       @IBOutlet weak var prejudgedBtn     : UIButton!
       @IBOutlet weak var techBtn          : UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var data:[QASet]?
    @IBOutlet weak var QAtableView: UITableView!
    var tempCell: QACell?
    var searchBarEdit: Bool!
    var searchData: [CompData]!
    override func viewDidLoad() {
        super.viewDidLoad()
        data = QA.questionAnswerList
        QAtableView.dataSource = self
        QAtableView.delegate = self
        informationView.layer.cornerRadius = 20
        informationView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        informationView.alpha = 0.0
        IndivObjecBtn.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7215686275, blue: 0.8588235294, alpha: 1)
        copyData()
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.alpha = 0.0
        searchBar.delegate = self
        searchData = competitions
        searchBarEdit = false
        // Do any additional setup after loading the view.
    }
    func copyData(){
        competitions = FBLACompetitionsData.indivObjecComps
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
       print("hello")
        searchBar.setShowsCancelButton(true, animated: true)
        eventTableView.alpha = 1.0
        searchBarEdit = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        eventTableView.alpha = 0.0
        QAtableView.alpha = 1.0
        // Remove focus from the search bar.
        searchBar.endEditing(true)
        searchBarEdit = false
        searchData = competitions
        eventTableView.reloadData()
        // Perform any necessary work.  E.g., repopulating a table view
        // if the search bar performs filtering.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == QAtableView)
        {
            return data!.count
        }
        else
        {
            return searchData!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == QAtableView)
        {
            let cell = QAtableView.dequeueReusableCell(withIdentifier: "customCell") as! QACell
            cell.set(data: data![indexPath.row])
            return cell
        }
        else
        {
            let cell = eventTableView.dequeueReusableCell(withIdentifier: "customCell") as! EventCell
            let data = searchData![indexPath.row]
            
            cell.set(color: currentColor, eventName: data.getName() , subcategory: data.getSub())
            return cell
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        print("hi")
        searchData = searchText.isEmpty ? competitions : competitions!.filter{
            
            (item: CompData) -> Bool in

                    // If dataItem matches the searchText, return true to include it

            return item.getName().range(of: searchText, options: .caseInsensitive, range: nil,

    locale: nil) != nil

            }
        var tempSearchData: [CompData]!
        tempSearchData = searchText.isEmpty ? competitions : competitions!.filter{
                
                (item: CompData) -> Bool in

                        // If dataItem matches the searchText, return true to include it

                return item.getSub().range(of: searchText, options: .caseInsensitive, range: nil,

        locale: nil) != nil

                }
        searchData += tempSearchData
        

            eventTableView.reloadData()

        }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == QAtableView)
        {
            return 320
        }
        else{
            return 170
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("In here")
        searchBarCancelButtonClicked(searchBar)
        QAtableView.alpha = 0.0
        if(tableView == eventTableView)
        {
            informationLabel.text   = competitions![indexPath.row].getSummary()
            titleLabel.text         = competitions![indexPath.row].getName()
            subLabel.text           = competitions![indexPath.row].getSub()
            if(competitions![indexPath.row].getCluster() == "N/A"){
                clusterLabel.text   = "No Cluster"
            } else{
                clusterLabel.text   = competitions![indexPath.row].getCluster()
            }
            UIView.animate(withDuration: animationTiming, animations: {
                self.eventTableView.alpha = 0.0
                self.informationView.transform = .identity
                self.informationView.alpha = 1.0
            })
            QAtableView.alpha = 0.0
        }
        else
        {
            QAtableView.alpha = 1.0
        }
    }
    @IBAction func newButtonPressed(_ sender: UIButton) {
        
        if(currentTag == sender.tag){ return }
        IndivObjecBtn.backgroundColor    = .white
        impromptuBtn.backgroundColor    = .white
        indivOralBtn.backgroundColor    = .white
        prejudgedBtn.backgroundColor    = .white
        techBtn.backgroundColor         = .white
        switch sender.tag {
        case 0: competitions = FBLACompetitionsData.indivObjecComps; IndivObjecBtn.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7215686275, blue: 0.8588235294, alpha: 1); currentTag = 0; currentColor = #colorLiteral(red: 0.6901960784, green: 0.7215686275, blue: 0.8588235294, alpha: 1)
        case 1: competitions = FBLACompetitionsData.impromptuComp; impromptuBtn.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7215686275, blue: 0.8588235294, alpha: 1); currentTag = 1; currentColor = #colorLiteral(red: 0.6901960784, green: 0.7215686275, blue: 0.8588235294, alpha: 1)
        case 2: competitions = FBLACompetitionsData.indivOralComps; indivOralBtn.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7215686275, blue: 0.8588235294, alpha: 1); currentTag = 2; currentColor = #colorLiteral(red: 0.6901960784, green: 0.7215686275, blue: 0.8588235294, alpha: 1)
        case 3: competitions = FBLACompetitionsData.prejudgedComp; prejudgedBtn.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7215686275, blue: 0.8588235294, alpha: 1); currentTag = 3; currentColor = #colorLiteral(red: 0.6901960784, green: 0.7215686275, blue: 0.8588235294, alpha: 1)
        case 4: competitions = FBLACompetitionsData.techComp; techBtn.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7215686275, blue: 0.8588235294, alpha: 1); currentTag = 4; currentColor = #colorLiteral(red: 0.6901960784, green: 0.7215686275, blue: 0.8588235294, alpha: 1)
        default: return
        }
        eventTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)

        
        eventTableView.reloadData()
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: animationTiming, animations: {
            self.eventTableView.alpha = 1.0
            self.informationView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.informationView.alpha = 0.0
        })
        
    }
    
    

    

}

