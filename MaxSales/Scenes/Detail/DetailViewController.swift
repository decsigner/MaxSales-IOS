//
//  DetailViewController.swift
//  MaxSales
//
//  Created by Fabio Miciano on 20/03/23.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    private let model: DetailBinding
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 20
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var whatsappLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private lazy var whatsappButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.32, alpha: 1.00), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(showWhatsAppPage), for: .touchUpInside)
        return button
    }()
    
    private lazy var whatsappContent: UIView = {
        let view = UIView()
        view.addSubview(whatsappLabel)
        view.addSubview(whatsappButton)
        return view
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private lazy var phoneButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.32, alpha: 1.00), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(showCallPhone), for: .touchUpInside)
        return button
    }()
    
    private lazy var phoneContent: UIView = {
        let view = UIView()
        view.addSubview(phoneLabel)
        view.addSubview(phoneButton)
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.addSubview(containerView)
        return scroll
    }()
    
    init(model: DetailBinding) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        buildLayout()
        setup()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private
extension DetailViewController {
    func setup() {
        title = model.title
        
        let text = model.text
        guard
            let data = text.data(using: .unicode, allowLossyConversion: true),
            let attribute = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        else { return }
        textLabel.attributedText = attribute
        textLabel.numberOfLines = 0
        
//        textLabel.text = model.text
        whatsappLabel.text = model.whatsappLabel
        whatsappButton.setTitle(model.whastappContent, for: .normal)
        phoneLabel.text = model.phoneLabel
        phoneButton.setTitle(model.phoneContent, for:.normal)
        
        guard let image = model.image else { return }
        logoView.image = UIImage(named: image)
    }
    
    func clearWhatsApp() -> String {
        return model.whastappContent
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
    }
    
    func clearPhone() -> String {
        return model.phoneContent.replacingOccurrences(of: " ", with: "")
    }
}

@objc
private extension DetailViewController {
    func showCallPhone() {
        guard let url = URL(string: "tel://\(clearPhone())") else { return }
        UIApplication.shared.open(url)
    }
    
    func showWhatsAppPage() {
        guard let appURL = URL(string: "https://api.whatsapp.com/send?phone=55\(clearWhatsApp())") else { return }
        UIApplication.shared.open(appURL)
    }
}

extension DetailViewController: ViewConfiguration {
    func createHyerarchy() {
        view.addSubview(scrollView)
        
        containerView.addSubview(logoView)
        containerView.addSubview(textLabel)
        containerView.addSubview(whatsappContent)
        containerView.addSubview(phoneContent)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.snp.edges)
            $0.width.equalTo(view.snp.width)
            $0.height.greaterThanOrEqualTo(1000)
        }
        
        logoView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Spacing.base01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(model.image == nil ? 0 : 180)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom).offset(Spacing.base02)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.greaterThanOrEqualTo(Sizing.base01)
        }
        
        whatsappContent.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(Spacing.base02)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base05)
        }
        
        phoneContent.snp.makeConstraints {
            $0.top.equalTo(whatsappContent.snp.bottom).offset(Spacing.base01)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base05)
        }
        
        whatsappLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(236)
        }
        
        whatsappButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(whatsappLabel.snp.trailing).offset(Spacing.base01)
        }
        
        phoneLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(236)
        }
        
        phoneButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(phoneLabel.snp.trailing).offset(Spacing.base01)
        }
    }
}
