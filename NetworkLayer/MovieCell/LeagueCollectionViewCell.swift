//
//  LeagueCollectionViewCell.swift
//  NetworkLayer
//
//  Created by Mahmoud Mohamed Atrees on 24/07/2024.
//

import UIKit
import CoreData

class LeagueCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var isFavourite: Bool = false
    var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func favouriteButtonPressed(_ sender: UIButton) {
        if isFavourite {
            deleteFavourite()
            favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            isFavourite = false
        } else {
            saveFavourite()
            favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            isFavourite = true
        }
    }
}

extension LeagueCollectionViewCell{
    func saveFavourite(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "FavouriteMovies", in: context){
            let favouriteMovie = NSManagedObject(entity: entity, insertInto: context)
            favouriteMovie.setValue(movie?.title, forKey: "title")
            favouriteMovie.setValue(movie?.release_date, forKey: "releaseYear")
            favouriteMovie.setValue(movie?.poster_path, forKey: "image")
            favouriteMovie.setValue(true, forKey: "isFavourite")
            
            do {
                try context.save()
                print("Data saved successfully")
            }catch{
                print("Data did not saved")
            }
            
        }else {
            print("Entity not found")
        }
    }

    func deleteFavourite(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteMovies")
        fetchRequest.predicate = NSPredicate(format: "title == %@", movie?.title ?? "")

        do {
            let movies = try context.fetch(fetchRequest)
            if let movieToDelete = movies.first {
                context.delete(movieToDelete)
                try context.save()
                print("Deleted successfully")
            } else {
                print("No matching movie found to delete")
            }
        } catch {
            print("Error occurred while deleting: \(error)")
        }
    }
    
    func checkIfFavourite() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteMovies")
        fetchRequest.predicate = NSPredicate(format: "title == %@", movie?.title ?? "")
        
        do {
            let movies = try context.fetch(fetchRequest)
            if movies.count > 0 {
                favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                isFavourite = true
            } else {
                favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
                isFavourite = false
            }
        } catch {
            print("Error occurred while fetching: \(error)")
        }
    }
    
}
