//
//  ViewController.swift
//  MutualMobileOnSIte
//
//  Created by Satyam Sehgal on 02/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//


import UIKit
import SwiftyJSON

class LandingViewController: UIViewController {

    @IBOutlet weak private var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak private var segmentControl: UISegmentedControl!
    @IBOutlet weak private var photoCollectionView: UICollectionView!
    @IBOutlet weak var noDataAvailableLabel: UILabel!

    var totalPhotos: Int = 0 {
        didSet {
            self.noDataAvailableLabel?.text = totalPhotos > 0 ? "\(totalPhotos) \(StringConstants.totalPhotosAvailable)" : StringConstants.noPhotosAvailable
        }
    }
    var dataSource = [PhotoCellModel]()
    let fetchPhotoService = FetchPhotoService()

    let itemsPerRow: CGFloat = 3.0
    let sectionInsets = UIEdgeInsets.init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        screenSetup()
        fetchAllPhotos()
    }

    override func viewWillAppear(_ animated: Bool) {
        activityIndicatorView.startAnimating()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        photoCollectionView?.collectionViewLayout.invalidateLayout()
    }

    func screenSetup() {
       segmentControl.selectedSegmentIndex = 0 // intially gridlayout is selected
       navigationController?.navigationBar.topItem?.title = StringConstants.landingNavigationBarTitle
       photoCollectionView.isHidden = true
    }

    fileprivate func fetchAllPhotos() {
        guard let url = K.Url.feedURL else {
            return
        }

        fetchPhotoService.fetchPhoto(withURL: url) { (result) in
            switch (result) {
            case .failure(let error):
                AppUtility.showAlert(message: error.errorMessage, onController: self)

            case .success(let json):
                var landingModels: [LandingViewModel] = []
                let photos = json.arrayValue
                for photo in photos {
                    if let model =  LandingViewModel(json: photo) {
                        landingModels.append(model)
                        self.dataSource.append(PhotoCellModel.init(viewModel: model))
                    }
                }
            }

            self.totalPhotos = self.dataSource.count
            DispatchQueue.main.async {
                self.photoCollectionView.isHidden = false
                self.photoCollectionView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StringConstants.imageDetailSegue {
            let destinationVC = segue.destination as? ImageDetailViewController
            if let indexPath = sender as? IndexPath {
                destinationVC?.imageURL = self.dataSource[indexPath.row].imageURL
                destinationVC?.imageLabelText = self.dataSource[indexPath.row].title
            }
        }
    }

    @IBAction func segmentControlAction(_ sender: Any) {
        photoCollectionView.reloadData()
    }
}

// MARK: collection view datasource and delegates methods
extension LandingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.photoCellIdentifier, for: indexPath)
        if let cell = collectionCell as? PhotoCollectionViewCell {
           cell.updateCell(with: self.dataSource[indexPath.row])
        }
        return collectionCell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: StringConstants.MainStoryBoard, bundle: nil)
        if let detailVC = storyBoard.instantiateViewController(withIdentifier: StringConstants.imageVC ) as? ImageDetailViewController {
            detailVC.imageURL = dataSource[indexPath.row].imageURL
            detailVC.imageLabelText = dataSource[indexPath.row].title
        }
        self.performSegue(withIdentifier: StringConstants.imageDetailSegue , sender: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var widthPerItem  = CGSize.init(width: view.frame.width, height: 50)

        switch segmentControl.selectedSegmentIndex {
        case 0:
            //set size accoridng to the list
            let sizeOfCell = view.frame.width - sectionInsets.left
            widthPerItem =  CGSize.init(width: sizeOfCell, height: sizeOfCell)
        case 1 :
            // set size according to the grid
            let paddingSpace = sectionInsets.left * (itemsPerRow * 2)
            let availbleWidth = view.frame.width - paddingSpace
            let height = (availbleWidth/itemsPerRow)
            widthPerItem = CGSize.init(width: availbleWidth/itemsPerRow, height: height)


        default: break
        }
        return widthPerItem
    }
}
