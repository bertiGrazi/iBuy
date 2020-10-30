//
//  ProductCell.swift
//  iBuy
//
//  Created by Grazi Berti on 30/10/20.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(item: Product){
        self.clearFields()
        
        labelName?.text = item.name
    }
    
    private func clearFields() {
        self.labelName.text = "Product"
    }

}
