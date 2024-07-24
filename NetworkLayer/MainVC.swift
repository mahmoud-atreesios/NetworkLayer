//
//  ViewController.swift
//  NetworkLayer
//
//  Created by Mahmoud Mohamed Atrees on 24/07/2024.
//

import UIKit
import SDWebImage

class MainVC: UIViewController{
    
    @IBOutlet weak var leagueCollectionView: UICollectionView!
    
    var leaguesArray: [LeagueResults] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        intailSetUp()
        fetchData()
    }
}

//MARK: - fetch data
extension MainVC{
    func fetchData(){
        let url = URL(string: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=c7b61c6a0e2bba592fa669ec0da364ae2c51138a7eadb6edc13c539df70c30c6")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { data, response, error in
            print(data!)
            print("Data arrived successfully")
            
            do {
                let decoder = JSONDecoder()
                let leagues = try decoder.decode(Leagues.self, from: data!)
                //print(leagues)
                DispatchQueue.main.async {
                    self.leaguesArray = leagues.result
                    self.leagueCollectionView.reloadData()
                }
                for league in self.leaguesArray{   //iterative loop on leagues because it is an array of dictionary(object)
                    if let leagueName = league.league_name{
                        print(leagueName)
                    }
                }
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
        leaguesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = leagueCollectionView.dequeueReusableCell(withReuseIdentifier: "leagueCell", for: indexPath) as! LeagueCollectionViewCell
        if let leagueLogo = leaguesArray[indexPath.row].league_logo{
            cell.leagueImage.sd_setImage(with: URL(string: leagueLogo))
        }else{
            cell.leagueImage.image = UIImage(named: "defaultLeagueLogo")
        }
        cell.leagueName.text = leaguesArray[indexPath.row].league_name
        return cell
    }
}

//MARK: - intail setup
extension MainVC{
    func intailSetUp(){
        leagueCollectionView.dataSource = self
        leagueCollectionView.delegate = self
        leagueCollectionView.register(UINib(nibName: "LeagueCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "leagueCell")
    }
}
