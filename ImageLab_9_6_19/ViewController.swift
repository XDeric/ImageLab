//
//  ViewController.swift
//  ImageLab_9_6_19
//
//  Created by EricM on 9/6/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var pokes = [Cards]()
    @IBOutlet weak var pokeTableViewOutlet: UITableView!
    @IBOutlet weak var searchOutlet: UISearchBar!
    
    var searchString: String? = nil {
        didSet{
            self.pokeTableViewOutlet.reloadData()
        }
    }
    
    var pokeSearchReults: [Cards]{
        guard let _ = searchString else{
            return pokes
        }
        guard searchString != "" else {
            return pokes
        }
        let results = pokes.filter{$0.name.lowercased().contains(searchString!.lowercased())}
        return results
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchOutlet.resignFirstResponder()
        searchString = searchBar.text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeSearchReults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemonCard = pokeSearchReults[indexPath.row]
        if let cell = pokeTableViewOutlet.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath) as? PokeTableViewCell {
//        ImageHelper.shared.getImage(urlStr: pokemonCard.imageUrl) { (result) in
//                DispatchQueue.main.async {
//                    switch result {
//                    case .failure(let error):
//                        print(error)
//                    case .success(let imageFromOnline):
//                        cell.pokeCardImage.image = imageFromOnline
//                    }
//                }
//            }
            func loadImage(site: String){
                let urlStr = site
                guard let url = URL(string: urlStr) else{return}
                DispatchQueue.global(qos: .userInitiated).async {
                    do {
                        let data = try Data(contentsOf: url)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.pokeCardImage.image = image
                        }
                    } catch {
                        fatalError()
                    }
                }
            }
            loadImage(site: pokemonCard.imageUrl)

            return cell
        }
        return UITableViewCell()
    }
    
    
    private func loadData() {
        NetworkManager.shared.getPokemon { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let pokemonFromOnline):
                    self.pokes = pokemonFromOnline
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier != nil else { fatalError("No identifier in segue")
        }
        guard let pokemonVC = segue.destination as? PokmonDetailViewController
            else { fatalError("Unexpected segue")}
        guard let selectedIndexPath = pokeTableViewOutlet.indexPathForSelectedRow
            else { fatalError("No row selected") }
        pokemonVC.pokeInfo = pokes[selectedIndexPath.row]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pokeTableViewOutlet.dataSource = self
        pokeTableViewOutlet.delegate = self
        searchOutlet.delegate = self
        loadData()
        // Do any additional setup after loading the view.
    }


}

