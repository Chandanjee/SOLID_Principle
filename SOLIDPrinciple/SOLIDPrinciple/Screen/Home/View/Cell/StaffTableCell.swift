//
//  StaffTableCell.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 14/01/23.
//

import UIKit

class StaffTableCell: UITableViewCell {
//    func updateRatingFormatValue(_ value: Int) {
//        print("Rating : = ", value)
//
//    }
    var actionBlock: (() -> Void)? = nil


    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productYearLabel: UILabel!
    @IBOutlet weak var FavorButton: UIButton!
    @IBOutlet weak var movieRatingImage: StarRateView!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productImageView.layer.cornerRadius = 10

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var product: Staff_PickedModel? {
        didSet { // Property Observer
            detailConfiguration()
        }
    }
    
    func detailConfiguration() {
        guard let product else { return }
        productTitleLabel.text = product.title
        productYearLabel.text = product.releaseDate
        productImageView.loadFrom(URLAddress: product.posterUrl ?? "")
        let rating = Int(product.rating ?? 0)
        print("rating",rating)
//        movieRatingImage.delegate = self

        movieRatingImage.ratingValue = rating
        if product.bookmark == true{
//            FavorButton.clipsToBounds = true
            FavorButton.setImage(UIImage(named: "Favorite_fill.png"), for: .normal)
        }else{
//            FavorButton.clipsToBounds = true
            FavorButton.setImage(UIImage(named: "Favorite.png"), for: .normal)
        }
    }
    
    @IBAction func didTapButton(sender: UIButton) {
          actionBlock?()
      }
    
   
}


