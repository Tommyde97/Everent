//
//  FeedPostTableViewCell.swift
//  Everent
//
//  Created by Tomas D. De Andrade Gomes on 2/8/24.
//

import AVFoundation
import SDWebImage
import UIKit

/// Cell for primary post content
final class FeedPostTableViewCell: UITableViewCell {

    static let identifier  = "FeedPostTableViewCell"
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost) {
        postImageView.image = UIImage(named: "test")
        
        return
        
 //      switch post.postType {
 //      case .photo:
 //          //Show image
 //          postImageView.sd_setImage(with: post.postURL, completed: nil)
 //      case .video:
 //          //Load and play video
 //          player = AVPlayer(url: post.postURL)
 //          playerLayer.player = player
 //          playerLayer.player?.volume = 0
 //          playerLayer.player?.play()
 //      }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
}
