//
//  ViewController.swift
//  PlannerApp
//
//  Created by Selin Şeker on 15.05.2024.
//

import UIKit


class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func presentAlert (title: String?,
                       message: String?,
                       preferredStyle: UIAlertController.Style = .alert,
                       cancelButtonTitle: String?,
                       isTextFieldAvailable: Bool = false,
                       defaultButtonTitle : String? = nil,
                       defaultButtonHandler : ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: preferredStyle)
        
        if defaultButtonTitle != nil{
            
            let defaultButton = UIAlertAction(title: defaultButtonTitle,
                                              style: .default,
                                              handler: defaultButtonHandler)
            alertController.addAction(defaultButton)
        }
        
        let cancelButton = UIAlertAction(title: cancelButtonTitle,
                                         style: .cancel)
        if isTextFieldAvailable {
            alertController.addTextField()
        }
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true)
        
    }
    
    func presentWarningAlert(){
        presentAlert(title: "Uyarı",
                     message: "Lütfen bir metin giriniz",
                     cancelButtonTitle: "Tamam")
    }
    
    func presentAddAlert(){
        let alertController = UIAlertController(title: "Yeni eleman ekle",
                                                message: nil,
                                                preferredStyle: .alert)
        let defaultButton = UIAlertAction(title: "Ekle", style: .default) { _ in
            let text = alertController.textFields?.first?.text
            if text != ""{
                self.data.append((text)!)
                self.tableView.reloadData()
            }else{
                self.presentWarningAlert()
            }
        }
        
        let cancelButton = UIAlertAction(title: "Vazgeç",
                                         style: .cancel)
        alertController.addTextField()
        
        alertController.addAction(defaultButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    
    @IBAction func addBarButton(_ sender: Any) {
            presentAddAlert()
    }
    
    @IBAction func trashBarButton(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal,
                                              title: "Sil") { _, _, _ in
            self.data.remove(at: indexPath.row)
            tableView.reloadData()
        }
        deleteAction.backgroundColor = .systemRed
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
    
}
