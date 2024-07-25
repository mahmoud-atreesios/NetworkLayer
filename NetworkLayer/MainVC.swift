//
//  ViewController.swift
//  NetworkLayer
//
//  Created by Mahmoud Mohamed Atrees on 24/07/2024.
//

import UIKit
import SDWebImage
import CoreData

class MainVC: UIViewController{
    
    @IBOutlet weak var leagueCollectionView: UICollectionView!
    
    var moviesArray: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        intailSetUp()
        fetchData()
    }
    
    @IBAction func favouriteVcButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "FavouritesVC") as? FavouritesVC {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}

//MARK: - fetch data
extension MainVC{       //https://api.themoviedb.org/3/trending/movie/day?api_key=4695f8fc3a83a2a282fe24823ac5b73a
    func fetchData(){ //https://api.themoviedb.org/3/movie/popular?api_key=4695f8fc3a83a2a282fe24823ac5b73a
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=4695f8fc3a83a2a282fe24823ac5b73a")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { data, response, error in
            print(data!)
            print("Data arrived successfully")
            
            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode(Movies.self, from: data!)
                //print(leagues)
                DispatchQueue.main.async {
                    self.moviesArray = movies.results
                    self.leagueCollectionView.reloadData()
                }
//                for league in self.moviesArray{   //iterative loop on leagues because it is an array of dictionary(object)
//                    if let leagueName = league.league_name{
//                        print(leagueName)
//                    }
//                }
            }catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

//MARK: - displaying data in the collectionview
extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = leagueCollectionView.dequeueReusableCell(withReuseIdentifier: "leagueCell", for: indexPath) as! LeagueCollectionViewCell
        if let leagueLogo = moviesArray[indexPath.row].poster_path{
            cell.leagueImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/" + leagueLogo))
        }else{
            cell.leagueImage.image = UIImage(named: "defaultLeagueLogo")
        }
        cell.leagueName.text = moviesArray[indexPath.row].title
        cell.movie = moviesArray[indexPath.row]
        cell.checkIfFavourite()
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC {
            // Pass the selected movie to the details view controller
            vc.selectedMovie = moviesArray[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}

//MARK: - intail setup
extension MainVC{
    func intailSetUp(){
        leagueCollectionView.dataSource = self
        leagueCollectionView.delegate = self
        leagueCollectionView.register(UINib(nibName: "LeagueCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "leagueCell")
    }
    
    func deleteAllFavouriteMovies(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "FavouriteMovies")
        
        do{
            let movies = try context.fetch(fetchRequest)
            context.delete(movies[0])
            try context.save()
            print("deleted successfully")
        }catch{
            print("errroror")
        }
    }
    
}
