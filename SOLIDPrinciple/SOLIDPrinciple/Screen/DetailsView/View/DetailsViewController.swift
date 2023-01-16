//
//  DetailsViewController.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 15/01/23.
//

import UIKit

class DetailsViewController: UIViewController {
    var movie_Model_one = Staff_PickedModel()
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieBackgroundView: UIView!
    @IBOutlet weak var movieRatingImage: StarRateView!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieRunTimeLabel: UILabel!
    @IBOutlet weak var moviegenresStack: UIStackView!

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    
    @IBOutlet weak var FavorButton: UIButton!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var budgetBackgroundView: UIView!
    @IBOutlet weak var revenueBackgroundView: UIView!
    @IBOutlet weak var languageBackgroundView: UIView!
    @IBOutlet weak var ratingBackgroundView: UIView!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configInitial()
        // Do any additional setup after loading the view.
    }
    
    func configInitial(){
        movieImageView.loadFrom(URLAddress: movie_Model_one.posterUrl ?? "")
        let rating = Int(movie_Model_one.rating ?? 0)
        movieRatingImage.layer.cornerRadius = 10

        movieRatingImage.ratingValue =  rating
        movieDateLabel.text = movie_Model_one.releaseDate
        movieRunTimeLabel.text = movie_Model_one.runtime?.description
        movieTitleLabel.text = movie_Model_one.title
        let year = movie_Model_one.releaseDate?.before(first: "-") ?? ""
        let yearStr =
        movieYearLabel.text = "(" + year + ")"
        self.getGeneres(arra: movie_Model_one.genres ?? [])
        movieOverviewLabel.text = movie_Model_one.overview
        let bookmark = movie_Model_one.bookmark
        if bookmark == true{
            FavorButton.setImage(UIImage(named: "Favorite_fill.png"), for: .normal)

        }else
        {
            FavorButton.setImage(UIImage(named: "Favorite.png"), for: .normal)
        }
        Utility.setViewCornerRadius(budgetBackgroundView, 10)
        Utility.setViewCornerRadius(revenueBackgroundView, 10)
        Utility.setViewCornerRadius(languageBackgroundView, 10)
        Utility.setViewCornerRadius(ratingBackgroundView, 10)
        budgetLabel.text = "$ " + (movie_Model_one.budget?.description ?? "0")
        revenueLabel.text = "$ " + (movie_Model_one.revenue?.description ?? "0")
        languageLabel.text = movie_Model_one.language
        let rating2Digit = movie_Model_one.rating
        if let distanceDb = movie_Model_one.rating {
            ratingLabel.text = "\(distanceDb.round(to:2))"
        }
    }
    
        //MARK: Geners
    func getGeneres(arra:[String]){
        var stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 5.0
        var viewArray = [UIView]()

        if arra.count > 0{
            for item in arra{
                var labbel = UILabel()
                labbel.text = " \(item) "
                viewArray.append(labbel)

            }
            stackView = UIStackView(arrangedSubviews: viewArray)

            stackView.translatesAutoresizingMaskIntoConstraints = false
        }
        moviegenresStack.addArrangedSubview(stackView)
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

    }
}
