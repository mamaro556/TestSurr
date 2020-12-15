//
//  ViewController.swift
//  TestSurr
//
//  Created by Marvin Amaro on 12/14/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ListTableView: UITableView!
 
    let CPLatitude: Double = 40.782483
    let CPLongitude: Double = -73.963540
    
    var venues: [Venue] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ListTableView.delegate = self
        ListTableView.dataSource = self
        ListTableView.separatorStyle = .none
        ListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CustomCell")
        
        retrieveVenues(latitude: CPLatitude, longitude: CPLongitude, category: "gyms",
                       limit: 20, sortBy: "distance", locale: "en_US") { (response, error) in
                        
                        if let response = response {
                             self.venues = response
                            DispatchQueue.main.async {
                                self.ListTableView.reloadData()
                            }
                        }
        }
    }
    }

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.nameLabel.text = venues[indexPath.row].name
        cell.addressLabel.text = String(venues[indexPath.row].rating ?? 0.0)
        cell.distanceLabel.text = venues[indexPath.row].price ?? "-"
        return cell
    }

/*
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "This is row \(indexPath.row)"

        return cell
    }
 */
}

