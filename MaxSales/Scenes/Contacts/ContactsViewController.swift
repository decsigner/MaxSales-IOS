//
//  ContactsViewController.swift
//  MaxSales
//
//  Created by Fabio Miciano on 16/02/23.
//

import Foundation
import UIKit
import SwiftUI

final class ContatcsViewController: UIViewController {
    private lazy var sacView: CardView = {
        let configuration = CardViewConfiguration(title: "SAC", info: "0800 191 2486", type: .phoneNumber)
        let card = CardView(configuration: configuration)
        return card
    }()
    
    private lazy var mailView: CardView = {
        let configuration = CardViewConfiguration(title: "EMAIL", info: "contato@salesmax.com.br", type: .mail)
        let card = CardView(configuration: configuration)
        return card
    }()
    
    private lazy var siteView: CardView = {
        let configuration = CardViewConfiguration(title: "SITE", info: "salesmax.com.br", type: .webpage)
        let card = CardView(configuration: configuration)
        return card
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sacView, mailView, siteView])
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    let viewModel: ContactsViewModeling
    
    init(viewModel: ContactsViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        buildLayout()
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        navigationController?.isNavigationBarHidden = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContatcsViewController: ViewConfiguration {
    func createHyerarchy() {
        view.addSubview(sacView)
        view.addSubview(mailView)
        view.addSubview(siteView)
    }
    
    func setupConstraints() {
        sacView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base12)
        }
        
        mailView.snp.makeConstraints {
            $0.top.equalTo(sacView.snp.bottom).offset(Spacing.base03)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base12)
        }
        
        siteView.snp.makeConstraints {
            $0.top.equalTo(mailView.snp.bottom).offset(Spacing.base03)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Sizing.base12)
        }
    }
}

#if DEBUG
struct ContactsViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let viewModel = ContactsViewModel()
            let controller = ContatcsViewController(viewModel: viewModel)
            let navigation = UINavigationController(rootViewController: controller)
            return navigation
        }
    }
}
#endif
