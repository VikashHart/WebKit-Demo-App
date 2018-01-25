//
//  FellowsViewController.swift
//  Fellows
//
//  Created by Alex Paul on 1/5/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit
import GameplayKit

class FellowsViewController: UIViewController {
    
    let fellowView = FellowView()
    
    // data model
    var fellows = [Fellow]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(fellowView)
        
        // setup delegate and datasource
        fellowView.tableView.dataSource = self
        fellowView.tableView.delegate = self
        
        if let results = JSONParsingService.parseJSONFile(filename: "fellows", type: "json") {
            fellows = results.sorted{ $0.name < $1.name }
        }
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Fellows"
        
        // setup UIBarButtonItem
        let shuffleFellowsBarItem = UIBarButtonItem(title: "Shuffle", style: .plain, target: self, action: #selector(shuffleFellows))
        navigationItem.rightBarButtonItem = shuffleFellowsBarItem
    }
    
    @objc func shuffleFellows() {
        fellows = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: fellows) as! [Fellow]
        fellowView.tableView.reloadData()
    }
}

extension FellowsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fellows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FellowCell", for: indexPath) as! FellowCell        
        let fellow = fellows[indexPath.row]
        cell.configureCell(fellow: fellow)
        return cell
    }
}

extension FellowsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fellow = fellows[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! FellowCell
        
        var cellImage: UIImage!
        if let image = cell.profileImageView.image {
            cellImage = image
        } else {
            cellImage = UIImage(named: "placeholder-image")
        }
        
        // using dependency injection to pass Fellow Model Object to DetailVC
        let detailViewController = DetailViewController(fellow: fellow, image: cellImage)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}



