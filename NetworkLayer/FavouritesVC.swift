//
//  FavouritesVC.swift
//  NetworkLayer
//
//  Created by Mahmoud Mohamed Atrees on 25/07/2024.
//

import UIKit
import CoreData
import SDWebImage

class FavouritesVC: UIViewController{

    @IBOutlet weak var favouritesCollectionView: UICollectionView!
    
    var favouritesMoviess: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchFavouritesMoviesFromCoreData()
        intailSetUp()
    }
    
    @IBAction func backMoviesButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FavouritesVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favouritesMoviess.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favouritesCollectionView.dequeueReusableCell(withReuseIdentifier: "leagueCell", for: indexPath) as! LeagueCollectionViewCell
        let favouriteMovie = favouritesMoviess[indexPath.row]
        cell.leagueName.text = favouriteMovie.value(forKey: "title") as? String
        
        let moviePoster = favouriteMovie.value(forKey: "image") as! String
        cell.leagueImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/" + moviePoster))
        
        cell.layer.cornerRadius = 10
        return cell
    }
}

extension FavouritesVC{
    func fetchFavouritesMoviesFromCoreData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteMovies")
        
        do {
            let favouritesMovies = try context.fetch(fetchRequest)
            favouritesMoviess = favouritesMovies
            
        }catch{
            print("Error fetched data")
        }
    }
}

//MARK: - intail setup
extension FavouritesVC{
    func intailSetUp(){
        favouritesCollectionView.dataSource = self
        favouritesCollectionView.delegate = self
        favouritesCollectionView.register(UINib(nibName: "LeagueCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "leagueCell")
    }
}
