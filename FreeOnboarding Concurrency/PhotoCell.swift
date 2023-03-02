//
//  PhotoCell.swift
//  FreeOnboarding Concurrency
//
//  Created by Jeff on 2023/02/18.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    static let identifier = String(describing: PhotoCell.self)
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var progress: UIProgressView!
    @IBOutlet private weak var loadButton: UIButton!
    
    var imageUrl: String?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageUrl = nil
        imageView.image = nil
    }
    
    func configure(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        imageUrl = urlString
        fetchImageData(from: url)
    }
    
    private func fetchImageData(from url: URL) {
        imageView.image = UIImage(systemName: "photo")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    @IBAction private func loadButtonTouchUpInside(_ sender: UIButton) {
        guard let url = URL(string: imageUrl ?? "") else { return }
        
        fetchImageData(from: url)
    }
}

