//
//  ViewController.swift
//  iBuy
//
//  Created by Grazi Berti on 30/10/20.
//

import UIKit

class ViewController: UIViewController {
    var arrayProducts = [[
                            Product(name: "Maça"),
                            Product(name: "Pera"),
                            Product(name: "Uva"),
                            Product(name: "Carne"),
                            Product(name: "Suco"),
                            Product(name: "Açucar"),
                            Product(name: "Arroz"),
                            Product(name: "Feijão")],
                         [
                            Product(name: "Feijão")
                         ]]

    @IBOutlet weak var tableViewList: UITableView!
    
    @IBAction func actionCreateProduct(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewList.delegate = self
        tableViewList.dataSource = self
        
    }

}
//MARK: - ViewController
extension ViewController {
    func updateUIInterface() {
        self.tableViewList.reloadData()
    }
    
    func changeProduct(item: Product, newValue: String){
        var foundIndex = arrayProducts[0].firstIndex { (product) -> Bool in
            return product.name == item.name
        }
        
        if let index = foundIndex {
            arrayProducts[0][index].name = newValue
            self.updateUIInterface()
        } else {
            foundIndex = arrayProducts[1].firstIndex { (product) -> Bool in
                return product.name == item.name
            }
            
            if let index = foundIndex {
                arrayProducts[1][index].name = newValue
                self.updateUIInterface()
            }
        }
    }
    
    func deleteProduct(item: Product) {
        var foundIndex = self.arrayProducts[0].firstIndex { $0.name == item.name }
        
        if let index = foundIndex {
            self.arrayProducts[0].remove(at: index)
            self.updateUIInterface()
        } else {
            foundIndex = self.arrayProducts[1].firstIndex { $0.name == item.name }
            
            guard let index = foundIndex else { return }
            
            self.arrayProducts[1].remove(at: index)
            self.updateUIInterface()
        }
    }
    
    func showEditAlert(item: Product) {
        var newTextValue: String = ""
        var textFieldInput = UITextField()
        let alert = UIAlertController(title: "Editar", message: "Edite seu produto", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default) { (action) in
            print("Cancelar")
            
        }
        let saveAction = UIAlertAction(title: "Salvar", style: .default) { (action) in
            print("Salvar")
            print(textFieldInput.text)
            self.changeProduct(item: item, newValue: textFieldInput.text ?? item.name)
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Ex: Maçã"
            textFieldInput = textField
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }
    func createProduct (item: String) {
        let alertAddProduct = UIAlertController(title: "Criar", message: "Digite o nome do item", preferredStyle: .alert)
        
        alertAddProduct.addTextField(configurationHandler: { textField in
            textField.placeholder = "Ex: Maça"
            textFieldInput = textField
        })
    }
}

//MARK: - ViewController: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = arrayProducts[indexPath.section][indexPath.row]
        
        showEditAlert(item: product)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let product = arrayProducts[indexPath.section][indexPath.row]
        switch editingStyle {
        case .delete: deleteProduct(item: product)
        default: return
        }
    }
}
//MARK: - ViewController: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "ABERTOS"
        } else if section == 1 {
            return "CONCLUIDOS"
        }
        return nil
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayProducts[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        var product: Product
        
        product = arrayProducts[indexPath.section][indexPath.row]
        cell.setup(item: product)
        
        return cell
    }
    
    
}
