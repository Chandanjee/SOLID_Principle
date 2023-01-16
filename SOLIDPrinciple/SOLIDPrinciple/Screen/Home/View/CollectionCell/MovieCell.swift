//
//  MovieCell.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 14/01/23.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var moviewBackgroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.moviePosterImageView.layer.masksToBounds = true
        self.moviePosterImageView.layer.cornerRadius = 12
        moviePosterImageView.layoutIfNeeded() //This is important line

//        self.contentView.layer.cornerRadius = 2.0
//        self.contentView.clipsToBounds = true
        
//        self.moviePosterImageView.clipsToBounds = false

//        self.moviePosterImageView.layer.cornerRadius = 10
//        self.moviePosterImageView.layer.masksToBounds = true

//            Utility.setViewCornerRadius(moviewBackgroundView, 10)

    }
    var moviePoster: Movie_Model? {
        didSet { // Property Observer
            moviePosterdetailConfig()
        }
    }
    
    
    func moviePosterdetailConfig() {
        guard let moviePoster else { return }
    
        moviePosterImageView.loadFrom(URLAddress: moviePoster.posterUrl ?? "")
//        moviePosterImageView.image.withRoundedCorners(radius: 10)
//        movieRatingImage.ratingValue = rating
//        if product.bookmark == true{
//            FavorButton.setImage(UIImage(named: "Favorite_fill.png"), for: .normal)
//        }else{
//            FavorButton.setImage(UIImage(named: "Favorite.png"), for: .normal)
//        }
    }
}
