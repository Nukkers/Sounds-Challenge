//
//  ViewController.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 02/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit

// MARK: - JSON codable structs

struct Config: Codable {
    var status: Status
    var rmsConfig: RmsConfig
    
}

struct Status: Codable {
    var isOn: Bool
}

struct RmsConfig: Codable {
    var apiKey: String
    var rootUrl: String
}

struct SoundsData: Codable {
    var data: [Data]
}

struct Data: Codable {
    var image_url: String
    var titles: Title
    var id: String
}

struct Title: Codable {
    var primary: String
    var secondary: String
}

// MARK: - Custom table view cell classes

class PlayableItemCell: UITableViewCell{
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var SubtitleLabel: UILabel!
    
    func setPlayableItem(item: PlayableItem){
        ImageView.image = item.image
        TitleLabel.text = item.primary
        SubtitleLabel.text = item.secondary
    }
}

class PlayableItem {
    var primary: String
    var secondary: String
    var image: UIImage
    var image_url: String
    
    init(primary: String, secondary: String, image: UIImage, image_url: String) {
        self.primary = primary
        self.secondary = secondary
        self.image = image
        self.image_url = image_url
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
    
    var soundsData: SoundsData?
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    
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
        
        let session = URLSession.shared
        let url = URL(string: "https://iplayer-radio-mobile-appconfig.files.bbci.co.uk/appconfig/cap/ios/1.6.0/config.json")!
        var apiKey = ""
        var rootUrl =  ""
        
        var config: Config!
        
        let task = session.dataTask(with: url) { data, response, error in
            
            // check if we have any errors
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let data = data else { return }
            
            // Check the response is of type HTTPURLResponse &&
            // statusCode is between 200-299
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            // Check if the application type is JSON
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            let decoder = JSONDecoder()
            do {
                config = try decoder.decode(Config.self, from: data)
                apiKey = config.rmsConfig.apiKey
                rootUrl = config.rmsConfig.rootUrl
                
            } catch {
                print(error.localizedDescription)
            }
            
            let session = URLSession.shared
            let url = URL(string: "\(rootUrl)/v2/networks/playable?promoted=true")!
            
            var request = URLRequest(url: url)
            request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
            
            let task2 = session.dataTask(with: request) { data2, response, error in
                // check if we have any errors
                if error != nil || data2 == nil {
                    print("Client error!")
                    return
                }
                
                guard let data2 = data2 else { return }
                
                // Check the response is of type HTTPURLResponse &&
                // statusCode is between 200-299
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    return
                }
                
                // Check if the application type is JSON
                guard let mime = response.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    return
                }
                
                let decoderData = JSONDecoder()
                
                do {
                    // Decode the data
                    self.soundsData = try decoderData.decode(SoundsData.self, from: data2)
                    
                    self.soundsData!.data = self.soundsData!.data.map({
                        Data(image_url: $0.image_url.replacingOccurrences(of: "{recipe}", with: "320x320"), titles: $0.titles, id: $0.id)
                    })
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }catch{
                    print("There was an error \(error)")
                }
            }
            task2.resume()
        }
        
        task.resume()
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Check to see if soundsData contains any values if not return 0
        guard let count = self.soundsData?.data.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the current array element out of soundsData.data array
        let playableItem = soundsData!.data[indexPath.row]
        
        // Will re-use the same cell with the following ID
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayableItemCell") as! PlayableItemCell
        
        // Assign the text label and subtitle label with the data
        cell.TitleLabel.text = playableItem.titles.primary
        cell.SubtitleLabel.text = playableItem.titles.secondary
        
        // Load the image from remote URL
        if let url = URL(string: playableItem.image_url){
            cell.ImageView.load(url: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myCellIndex = indexPath.row
        let selectedRow = soundsData?.data[myCellIndex]
        performSegue(withIdentifier: "MasterToDetail", sender: selectedRow)
    }
}
