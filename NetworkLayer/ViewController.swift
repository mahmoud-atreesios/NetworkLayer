//
//  ViewController.swift
//  NetworkLayer
//
//  Created by Mahmoud Mohamed Atrees on 24/07/2024.
//

import UIKit

class ViewController: UIViewController {
    
    var leaguesArray: Leagues?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
                //self.leaguesArray = leagues
                
                for league in leagues.result{   //iterative loop on leagues because it is an array of dictionary(object)
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

