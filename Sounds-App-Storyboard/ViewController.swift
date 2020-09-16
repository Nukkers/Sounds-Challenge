//
//  ViewController.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 02/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit

// MARK: - Custom table view cell classes

class PlayableItemCell: UITableViewCell{
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var SubtitleLabel: UILabel!
    
    func setPlayableItem(item: PlayableItem){
        ImageView.image = item.image
        TitleLabel.text = item.primaryTitle
        SubtitleLabel.text = item.secondaryTitle
    }
}

extension UIImageView {
    func load(url: URL) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            let newImage = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.image = newImage
            }
        }
        task.resume()
    }
}


var myCellIndex = 0

// MARK: - ViewController

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var playableItemVM: PlayableItemViewModel?

    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    // Coordinator pattern for this
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "MasterToDetail" {
            let destVC = segue.destination as! DetailViewController
            destVC.soundsData = sender as? Data
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupNavBar()
        
        
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        playableItemVM = PlayableItemViewModel(table: self.tableView)
        
    }
}



extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Check to see if soundsData contains any values if not return 0
        guard let count = self.playableItemVM?.displayableItem?.data
            .count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the current array element out of soundsData.data array
        let playableItem = self.playableItemVM?.displayableItem?.data[indexPath.row]

        // Will re-use the same cell with the following ID
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayableItemCell") as! PlayableItemCell

        // Assign the text label and subtitle label with the data
        cell.TitleLabel.text = playableItem?.titles.primary
        cell.SubtitleLabel.text = playableItem?.titles.secondary

        // Load the image from remote URL
        if let url = URL(string: playableItem!.image_url){
            cell.ImageView.load(url: url)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myCellIndex = indexPath.row
        let selectedRow = playableItemVM?.displayableItem?.data[myCellIndex]
        performSegue(withIdentifier: "MasterToDetail", sender: selectedRow)
    }
}

