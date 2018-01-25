//
//  DetailView.swift
//  Fellows
//
//  Created by Alex Paul on 1/5/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit
import SnapKit

class DetailView: UIView {
    
    lazy var safariLinkButton: UIButton = {
        let button = UIButton()
        button.setImage( #imageLiteral(resourceName: "apple-logo-rainbow"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    lazy var webViewLinkButton: UIButton = {
        let button = UIButton()
        button.setImage( #imageLiteral(resourceName: "c4q-logo"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    lazy var gitHubLinkButton: UIButton = {
        let button = UIButton()
        button.setTitle("Github - come see my work", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var bioTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.init(red: 0.961, green: 0.961, blue: 0.961, alpha: 1.0)
        tv.isEditable = false
        tv.isSelectable = false
        tv.layer.cornerRadius = 20
        tv.layer.masksToBounds = true
        tv.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        // here you get the actual frame size of the elements before getting
        // laid out on screen
        super.layoutSubviews()
        
        // make profile image a circle
        profileImage.layer.cornerRadius = profileImage.bounds.width/2.0
        profileImage.layer.masksToBounds = true
    }

    public func configureDetailView(fellow: Fellow, image: UIImage) {
        profileImage.image = image
        bioTextView.text = fellow.bio
        print("gihub: \(fellow.githubURL)")
    }
}

// MARK:- Setup Views
extension DetailView {
    private func setupViews() {
        backgroundColor = .white
        setupProfileImage()
        setupGitHubLinkButton()
        setupSafariLinkButton()
        setupWebViewLinkButton()
        setupBioTextView()
    }
    
    private func setupSafariLinkButton() {
        addSubview(safariLinkButton)
        safariLinkButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileImage.snp.centerY)
            make.trailing.equalTo(profileImage.snp.leading).offset(-20)
            make.width.height.equalTo(60)
        }
    }
    
    private func setupWebViewLinkButton() {
        addSubview(webViewLinkButton)
        webViewLinkButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileImage.snp.centerY)
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
            make.width.height.equalTo(60)
        }
    }
    
    private func setupGitHubLinkButton() {
        addSubview(gitHubLinkButton)
        gitHubLinkButton.snp.makeConstraints { (make) in
            make.top.equalTo(profileImage.snp.bottom).offset(40)
            make.leading.trailing.equalTo(self)
            //make.height.equalTo(40)
        }
    }
    
    private func setupProfileImage() {
        addSubview(profileImage)
        // TODO: layout using SnapKit
        profileImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(40)
            make.width.equalTo(snp.width).multipliedBy(0.30)
            make.height.equalTo(profileImage.snp.width)
        }
    }
    
    private func setupBioTextView() {
        let padding: CGFloat = 16
        addSubview(bioTextView)
        // TODO: layout using SnapKit
        bioTextView.snp.makeConstraints { (make) in
            make.top.equalTo(gitHubLinkButton.snp.bottom).offset(padding)
            make.leading.equalTo(snp.leading).offset(padding)
            make.trailing.equalTo(snp.trailing).offset(-padding)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-padding)
        }
    }
    
    // TODO: add a Github link which segues to a WebView
}
