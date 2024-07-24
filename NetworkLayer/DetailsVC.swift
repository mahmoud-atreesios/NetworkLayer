//
//  DetailsVC.swift
//  NetworkLayer
//
//  Created by Mahmoud Mohamed Atrees on 24/07/2024.
//

import UIKit
import SDWebImage

class DetailsVC: UIViewController {

    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieReleaseYear: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    var selectedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        movieDetails()
        intialSetup()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailsVC{
    func movieDetails(){
        if let movieePoster = selectedMovie?.poster_path, let movieeTitle = selectedMovie?.title, let movieeRating = selectedMovie?.vote_average, let movieeOverview = selectedMovie?.overview, let movieeReleaseYear = selectedMovie?.release_date{
            moviePoster.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/" + movieePoster))
            movieTitle.text = movieeTitle
            movieRating.text = "\(movieeRating)"
            movieOverview.text = movieeOverview
            movieReleaseYear.text = movieeReleaseYear
        }
    }
    
    func intialSetup(){
        moviePoster.layer.cornerRadius = 10
        moviePoster.layer.borderWidth = 2
        moviePoster.layer.borderColor = UIColor.white.cgColor
    }
    
}
