//
//  ViewController.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 02/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit




var myCellIndex = 0

// MARK: - ViewController

class StationsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var playableItemVM: StationsViewModel?
   
    
    // Coordinator pattern for this
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "MasterToDetail" {
            let destVC = segue.destination as! DetailViewController
            destVC.soundsData = sender as? RMSPlayableItem
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        playableItemVM = StationsViewModel()
        playableItemVM?.displayablesUpdatedDelegate = self
        
    }
}

extension StationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Check to see if soundsData contains any values if not return 0
        guard let count = self.playableItemVM?.displayableItem?.data
            .count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Will re-use the same cell with the following ID
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell") as! StationCell
        
        // Get the current array element out of soundsData.data array
        guard let rmsPlayableItem = self.playableItemVM?.displayableItem?.data[indexPath.row]
            else {
                return cell
        }
        
        let playableItem = PlayableItem(rmsPlayableItem: rmsPlayableItem)
        let playableItemCellVM = StationCellViewModel(playableItem: playableItem)
        cell.setStationCellVM(item: playableItemCellVM)
        

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myCellIndex = indexPath.row
        let selectedRow = playableItemVM?.displayableItem?.data[myCellIndex]
        performSegue(withIdentifier: "MasterToDetail", sender: selectedRow)
    }
}

extension StationsViewController: DisplayablesUpdatedDelegate {
    func displayablesUpdated() {
        tableView.reloadData()
    }
}

