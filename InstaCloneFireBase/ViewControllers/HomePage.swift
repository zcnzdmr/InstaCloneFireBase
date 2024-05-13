//
//  ViewController.swift
//  InstaCloneFireBase
//
//  Created by Özcan on 6.05.2024.
//

import UIKit
import FirebaseFirestore

class HomePage: UIViewController {
    
    var tableView = UITableView()
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        barButton()
        getDataFromFireStore()
      }
    
    func barButton() {
        let add = UIBarButtonItem(image: UIImage(systemName: "message"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(goToProfile))
//        self.navigationItem.rightBarButtonItems = add
        add.tintColor = .orange
//        let another1 = UIBarButtonItem(image: UIImage(systemName: "heart"), style: UIBarButtonItem.Style.done, target: self, action: #selector(goToProfile))
        self.navigationItem.rightBarButtonItems = [add]
    }
    

      func setupUI(){
//        view.backgroundColor = .white
          navigationItem.title = "Instagram Clone"
          tableView.frame = view.bounds
          tableView.rowHeight = CGFloat(350)
          tableView.delegate = self
          tableView.dataSource = self
          tableView.register(Cell.self, forCellReuseIdentifier: "hucrem")
          view.addSubview(tableView)

      }

      @objc func goToProfile(){
//          self.navigationController?.pushViewController(SignPage(), animated: false)
        tabBarController?.selectedIndex = 3
      }
    
    func getDataFromFireStore() {
        
        let db = Firestore.firestore()
        db.collection("Posts").addSnapshotListener { snapShot, error in
            if error != nil {
                print(error?.localizedDescription ?? "record pulling error")
            }else{
                if snapShot?.isEmpty != true {
                    
                    for document in snapShot!.documents {
                        let documentID = document.documentID
                        
                        if let postedBy = document.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        if let comment = document.get("comment") as? String {
                            self.userCommentArray.append(comment)
                        }
//                        if let date = document.get("date") as? String {
//                            self.d.append(date)
//                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.userImageArray.append(imageUrl)
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }

    }
}

extension HomePage : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hucrem", for: indexPath) as! Cell
        
        cell.imageViewm.image = UIImage(named: "aa")
//        cell.label3.text = self.likeArray[indexPath.row]
        cell.label1.text = userEmailArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
