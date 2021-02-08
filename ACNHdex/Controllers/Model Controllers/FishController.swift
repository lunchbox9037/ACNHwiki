//
//  FishController.swift
//  ACNHdex
//
//  Created by stanley phillips on 1/27/21.
//

import UIKit

class FishController {
    static let baseURL = URL(string: "https://acnhapi.com/v1a/fish")
    
    static func fetchFish(id: String, completion: @escaping (Result<Fish, FishError>) -> Void) {
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let finalURL = baseURL.appendingPathComponent(id)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let fish = try JSONDecoder().decode(Fish.self, from: data)
                completion(.success(fish))
            } catch {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }//end func
    
    static func fetchAllFish(completion: @escaping (Result<[Fish], FishError>) -> Void) {
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        print(baseURL)
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let fish = try JSONDecoder().decode([Fish].self, from: data)
                completion(.success(fish))
            } catch {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }//end func
    
    static func fetchImageFor(fish: Fish, completion: @escaping (Result<UIImage, FishError>) -> Void) {
        let url = fish.imageURL
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            guard let fishImage = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            completion(.success(fishImage))
        }.resume()
    }//end func
    
}//end of class

