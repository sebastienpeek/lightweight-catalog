//
//  MediaCell.swift
//  lightweight
//
//  Created by Sebastien Audeon on 4/8/20.
//  Copyright © 2020 Sebastien Audeon. All rights reserved.
//

import UIKit

import apple_data_package


class MediaCell: UITableViewCell {
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var favoritedImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setup(with media: Media) {
        // Provide ability to grab the media information.
        
        self.nameLabel.text = media.name
        self.linkLabel.text = media.url
        self.genreLabel.text = media.genre?.rawValue
        
        if !media.favorited {
            favoritedImageView.image = UIImage(systemName: "heart")
        } else {
            favoritedImageView.image = UIImage(systemName: "heart.fill")
        }
        
        guard let mediaUrl = media.artwork, let url = URL(string: mediaUrl) else { return }
        
        // We need to load images in.
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.artworkImageView.image = image
                    }
                }
            }
        }
        
        if self.linkLabel.text != nil {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkTapped(_:)))
            tapGesture.numberOfTouchesRequired = 1
            tapGesture.numberOfTapsRequired = 1
            self.linkLabel.addGestureRecognizer(tapGesture)
        }
        
    }
    
    @objc func linkTapped(_ sender: Any) {
        if let string = self.linkLabel.text, let url = URL(string: string) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
