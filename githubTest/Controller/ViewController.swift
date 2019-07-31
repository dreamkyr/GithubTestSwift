//
//  ViewController.swift
//  githubTest
//
//  Created by dreams on 7/31/19.
//  Copyright © 2019 Dreams. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UITableViewController {
    
    var webservice: GithubService!
    var contributors : [Contributor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        self.webservice = self
        webservice.fetchContributers()
    }
    
    @objc func onClickMap(sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.username = self.contributors[sender.tag].name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contributors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contributor = self.contributors[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contributorCell") as? ContributorCell
        cell?.imageProfile.sd_setImage(with: URL(string: contributor.avatar), placeholderImage: UIImage(named: "placeholder.png"))
        cell?.labelName.text =  contributor.name
        cell?.labelContribution.text = "\(contributor.contributions) contributions"
        cell?.btnMap.tag = indexPath.row
        cell?.btnMap.addTarget(self, action: #selector(onClickMap(sender:)), for: .touchUpInside)
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ViewController: GithubService {
    func webServiceGetError(_ error: NetworkError) {
        print(error.localizedDescription)
    }
    
    func webServiceGetResponse(data: [Contributor]) {
        self.contributors = data.sorted(by: { $0.contributions > $1.contributions })
        self.tableView.reloadData()
    }
    
    func webServiceGetLocation(location: String) {
        
    }
}
