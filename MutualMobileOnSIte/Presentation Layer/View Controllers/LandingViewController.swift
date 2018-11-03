//
//  ViewController.swift
//  MutualMobileOnSIte
//
//  Created by Satyam Sehgal on 02/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//


import UIKit

class LandingViewController: UIViewController {

    let itemsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets.init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    let landingViewModel = LandingViewModel()
    var dataSource = [PhotoCellModel]()
//private outlest
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var photoCollectionView: UICollectionView!

    @IBAction func segmentControlAction(_ sender: Any) {
        photoCollectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = false
        fetchAllPhotos()
        screenSetup()
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
    }

    func fetchAllPhotos() {
        landingViewModel.fetchPhotos(completion: { (dataSourceArray, error) in
            guard let data = dataSourceArray else {
                AppUtility.showAlert(message: error?.message ?? StringConstants.emptyString, onController: self)
                self.activityIndicatorView.stopAnimating()
                return
            }
            self.dataSource = data
            DispatchQueue.main.async {
                self.photoCollectionView.reloadData()
            }
        })

        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StringConstants.imageDetailSegue {
            let destinationVC = segue.destination as? ImageDetailViewController
            if let indexPath = sender as? IndexPath {
                destinationVC?.imageURL = self.dataSource[indexPath.row].imageURL
            }
        }
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
            // code to configure the cell
           cell.updateCell(with: self.dataSource[indexPath.row])
        }
        return collectionCell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // perform segue here
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let detailVC = storyBoard.instantiateViewController(withIdentifier: "ImageDetailViewController") as? ImageDetailViewController {
            detailVC.imageURL = dataSource[indexPath.row].imageURL
        }
        self.performSegue(withIdentifier: StringConstants.imageDetailSegue , sender: indexPath)
    }

    // MARK: Paging support
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var widthPerItem  = CGSize.init(width: view.frame.width, height: 50)

        switch segmentControl.selectedSegmentIndex {
        case 0 :
            // set size according to the grid
            let paddingSpace = sectionInsets.left * (itemsPerRow * 2.5)
            let availbleWidth = view.frame.width - paddingSpace
            widthPerItem = CGSize.init(width: availbleWidth/itemsPerRow, height: availbleWidth/itemsPerRow)

        case 1:
            //set size accoridng to the list
            let sizeOfCell = view.frame.width - sectionInsets.left
            widthPerItem =  CGSize.init(width: sizeOfCell, height: sizeOfCell)
        default : break
        }
        return widthPerItem
    }

}

//extension LandingViewController : AlertPresentable {
//
//}

