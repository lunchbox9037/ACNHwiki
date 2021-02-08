//
//  FishTableViewController.swift
//  ACNHdex
//
//  Created by stanley phillips on 1/28/21.
//

import UIKit

class FishTableViewController: UITableViewController {
    // MARK: - Properties
    var allFish: [Fish] = []
//    var fishImages: [UIImage] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFish()
//        fetchFishImages(allFish: allFish)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Methods
    func fetchFish() {
        FishController.fetchAllFish { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let allFish):
                    self.allFish = allFish
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
//    func fetchFishImages(allFish: [Fish]) {
//        for fish in allFish {
//            DispatchQueue.main.async {
//
//            }
//        }
//    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFish.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fishCell", for: indexPath)
        cell.textLabel?.text = allFish[indexPath.row].name.nameUSen
        cell.detailTextLabel?.text = allFish[indexPath.row].availability.rarity
        FishController.fetchImageFor(fish: allFish[indexPath.row]) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let fishImage):
                    cell.imageView?.image = fishImage
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        return cell
    }
}
