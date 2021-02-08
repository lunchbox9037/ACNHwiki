//
//  FishDetailViewController.swift
//  ACNHdex
//
//  Created by stanley phillips on 1/27/21.
//

import UIKit

class FishDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var fishNameLabel: UILabel!
    @IBOutlet weak var goFishingButton: UIButton!
    @IBOutlet weak var catchPhraseLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var rarityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var fishImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var catchPhraseImageView: UIImageView!
    @IBOutlet weak var locationStackView: UIStackView!
    @IBOutlet weak var priceStackView: UIStackView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        hideKeyboardWhenTappedAround()
        goFishingButton.layer.cornerRadius = 8
        locationStackView.layer.cornerRadius = 12
        priceStackView.layer.cornerRadius = 12
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let randomFish = Int.random(in: 1...80)
        FishController.fetchFish(id: "\(randomFish)") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let fish):
                    self.fetchImageAndUpdateViews(for: fish)
                    print(fish)
                case .failure(let error):
                    print(error.errorDescription)
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    func fetchImageAndUpdateViews(for fish: Fish) {
        FishController.fetchImageFor(fish: fish) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let fishImage):
                    self.fishNameLabel.text = fish.name.nameUSen.capitalized
                    self.catchPhraseLabel.text = fish.catchPhrase
                    self.locationLabel.text = "  Location:\n  \(fish.availability.location)"
                    self.priceLabel.text = "  Price: \(fish.price.withCommas())"
                    self.rarityLabel.text = "  Rarity:\n  \(fish.availability.rarity)"
                    self.fishImageView.image = fishImage
                    self.catchPhraseImageView.image = UIImage(named: "chatbubble")
                case .failure(let error):
                    print(error.errorDescription)
                }
            }
        }
    }
}//end of class

// MARK: - Search bar delegate
extension FishDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else {return}
        let formattedSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "_")
        FishController.fetchFish(id: formattedSearchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let fish):
                    self.fetchImageAndUpdateViews(for: fish)
                    self.searchBar.endEditing(true)
                    self.searchBar.text = ""
                    print(fish)
                case .failure(let error):
                    print(error.errorDescription)
                }
            }
        }
    }
}

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
