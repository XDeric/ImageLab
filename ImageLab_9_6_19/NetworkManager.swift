//
//  NetworkManager.swift
//  ImageLab_9_6_19
//
//  Created by EricM on 9/9/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation

class NetworkManager {
    
    // TODO: update this to cache
    private init() {}
    
    /// singleton
    static let shared = NetworkManager()
    
    //Performs GET requests for any URL
    //Parameters: URL as a string
    //Completion: Result with Data in success, AppError in failure
    
    func getPokemon(completionHandler: @escaping (Result<[Cards], AppError>) -> Void){
        
        let urlStr = "https://api.pokemontcg.io/v1/cards"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badUrl))
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler(.failure(.noDataError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noDataError))
                return
            }
            
            do {
                let pokeData = try JSONDecoder().decode(Pokemon.self, from: data)
                completionHandler(.success(pokeData.cards))
            }
            catch {
                print(error)
                completionHandler(.failure(.networkError))
            }
            }.resume()
    }
}
