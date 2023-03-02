//
//  ViewController.swift
//  FreeOnboarding Concurrency
//
//  Created by tumblbug on 2023/02/18.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var photoCollectionView: UICollectionView!
    
    private var dataSource = photoUrls
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateLayout()
        photoCollectionView.reloadData()
    }
    
    private func generateLayout() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(110.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(110))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        photoCollectionView.collectionViewLayout = layout
    }
    
    
    @IBAction func loadAllImagesButtonTouchUpInside(_ sender: UIButton) {
        dataSource = Array(repeating: "", count: dataSource.count)
        photoCollectionView.reloadData()
        
        dataSource = photoUrls
        photoCollectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        cell.configure(dataSource[indexPath.item])
        return cell
    }
}

let photoUrls = ["https://images.pexels.com/photos/572897/pexels-photo-572897.jpeg?auto=compress&cs=tinysrgb&w=1600",
                      "https://images.pexels.com/photos/2113566/pexels-photo-2113566.jpeg?auto=compress&cs=tinysrgb&w=1600g",
                      "https://images.pexels.com/photos/3075993/pexels-photo-3075993.jpeg?auto=compress&cs=tinysrgb&w=1600",
                      "https://images.pexels.com/photos/671658/pexels-photo-671658.jpeg?auto=compress&cs=tinysrgb&w=1600",
                      "https://images.pexels.com/photos/279329/pexels-photo-279329.jpeg?auto=compress&cs=tinysrgb&w=1600",
]
