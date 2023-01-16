//
//  HomeViewController.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 14/01/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, RatingViewDelegate {
    func updateRatingFormatValue(_ value: Int) {
        print("")
    }
    
    private var viewModel = StaffViewModel()
    private var viewModelBookMark = BookmarkViewModel()

    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var CollectionReloadStatus : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SearchButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func configuration() {
        productTableView.register(StaffTableCell.nib, forCellReuseIdentifier: StaffTableCell.identifier)
        initViewModel()
        observeEvent()
        collectionViewSetup()
    }

    func initViewModel() {
        viewModelBookMark.getDataBookmark()
        viewModel.fetchStaffAPI()
    }
    
    // Data binding event observe karega - communication
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }

            switch event {
            case .loading:
                /// Indicator show
                print("Product loading....")
            case .stopLoading:
                // Indicator hide kardo
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    // UI Main works well
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
        viewModel.dataHandler = {
            [weak self] datas in
            guard let self else { return }

            DispatchQueue.main.async {
                self.productTableView.reloadData()
            }
        }
        viewModelBookMark.dataHandlerBookmark = {
            [weak self] datas in
            guard let self else { return }

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    //MARK: CollectionViewSetup
    func collectionViewSetup(){
        let flowLayout = UICollectionViewFlowLayout()
              flowLayout.scrollDirection = .horizontal
              flowLayout.itemSize = CGSize(width: 150, height: 180)
              flowLayout.minimumLineSpacing = 2.0
              flowLayout.minimumInteritemSpacing = 5.0
              self.collectionView.collectionViewLayout = flowLayout
              self.collectionView.showsHorizontalScrollIndicator = false
        
        self.collectionView.dataSource = self
               self.collectionView.delegate = self
               
               // Register the xib for collection view cell
               let cellNib = UINib(nibName: "MovieCell", bundle: nil)
               self.collectionView.register(cellNib, forCellWithReuseIdentifier: "MovieCell")
    }

}

extension HomeViewController: UITableViewDataSource,UITableViewDelegate {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            viewModel.staff_Picked.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StaffTableCell") as? StaffTableCell else {
                return UITableViewCell()
            }
            var product = viewModel.staff_Picked[indexPath.row]
            cell.product = product

            cell.actionBlock = {
                var bookmarkData = product
                if bookmarkData.bookmark == nil || bookmarkData.bookmark == false{
                    product.bookmark = true
                    self.viewModel.staff_Picked[indexPath.row].bookmark = true
                    self.viewModel.processAddBookMarkMovies(datas: product)
                    
                    let bookmark = self.viewModel.convertModel(currentModel: product)
                    self.CollectionReloadStatus = self.viewModelBookMark.processFectchedBookmark_One(datas: bookmark,isBoomark: true)
                    
                }else{
                    product.bookmark = false
                    self.viewModel.staff_Picked[indexPath.row].bookmark = false

                    self.viewModel.processAddBookMarkMovies(datas: product)
                    let bookmark = self.viewModel.convertModel(currentModel: product)
                    self.CollectionReloadStatus =  self.viewModelBookMark.processDeleteBookmark_One(datas: bookmark)
                   
                }
                self.productTableView.reloadData()
                if self.CollectionReloadStatus{
                    self.collectionView.reloadData()
                    self.CollectionReloadStatus = false
                }
                   //Do whatever you want to do when the button is tapped here
                }
//            cell.movieRatingImage.delegate = self
            return cell
        }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataviewModel = viewModel.staff_Picked[indexPath.row]
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
          let destVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        destVC.movie_Model_one =   dataviewModel
        destVC.modalPresentationStyle = .formSheet

//        destVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//          destVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

          self.present(destVC, animated: true, completion: nil)
    }
    }


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // The data we passed from the TableView send them to the CollectionView Model
//    func updateCellWith(row: [CollectionViewCellModel]) {
//        self.rowWithColors = row
//        self.collectionView.reloadData()
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModelBookMark.movie_Model.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Set the data for each cell (color and color name)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell {
//            cell.moviePosterImageView.layer.cornerRadius = 10.0
//               cell.moviePosterImageView.layer.masksToBounds = true
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.masksToBounds = true

            cell.moviePoster = self.viewModelBookMark.movie_Model[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
    
    // Add spaces at the beginning and the end of the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}
