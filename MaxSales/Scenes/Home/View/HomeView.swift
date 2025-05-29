//
//  HomeView.swift
//  MaxSales
//
//  Created by Fabio Miciano on 15/02/23.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

// MARK: -- HOME VIEW DELEGATE PROTOCOL --
protocol HomeViewDelegate: AnyObject {
    func selectedController(title: String, type: HomeCellType, id: String)
    func selectedSac(url: String)
    func showWarningSnackBar()
}

// MARK: -- LAYOUT CONSTATS --
extension HomeView.Layout {
    enum Size {
        static let logoCellHeight: CGFloat = 100
        static let helpCellHeight: CGFloat = 130
        static let productCellHeight: CGFloat = 80
        static let collectionSectionInsets = UIEdgeInsets(top: 8, left: 4, bottom: 0, right: 4)
    }
}

// MARK: -- ABSOLUT CLASS --
final class HomeView: UIView {
    fileprivate enum Layout {}
    
    weak var delegate: HomeViewDelegate?
    
    private var dataSource: [Product] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = Layout.Size.collectionSectionInsets
        let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        collection.register(HomeLogoViewCell.self, forCellWithReuseIdentifier: String(describing: HomeLogoViewCell.self))
        collection.register(HomeHelpViewCell.self, forCellWithReuseIdentifier: String(describing: HomeHelpViewCell.self))
        collection.register(HomeProductViewCell.self, forCellWithReuseIdentifier: String(describing: HomeProductViewCell.self))
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(dataSource: [Product]) {
        self.dataSource = dataSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
}

// MARK: -- VIEW CONFIGURATION --
extension HomeView: ViewConfiguration{
    func createHyerarchy() {
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: -- PRIVATE FUNCS --
private extension HomeView {
    func createCell(configuration: Product, indexPath: IndexPath) -> UICollectionViewCell {
        var identify = ""
        
        switch configuration.type {
        case .logo:
            identify = String(describing: HomeLogoViewCell.self)
        case .help:
            identify = String(describing: HomeHelpViewCell.self)
        case .product:
            identify = String(describing: HomeProductViewCell.self)
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identify, for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(model: configuration, viewModel: configuration.type == .product ? createCellViewModel() : nil)
        
        return cell
    }
    
    func createCellViewModel() -> HomeCellViewModeling {
        let service = ServerRequester()
        let viewModel = HomeProductCellViewModel(service: service)
        
        return viewModel
    }
}

// MARK: -- COLLECTION DATA SOURCE --
extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = dataSource[indexPath.row]
        
        return createCell(configuration: product, indexPath: indexPath)
    }
}

// MARK: -- COLLECTION FLOW LAYOUT DELEGATE --
extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let configuration = dataSource[indexPath.row]
        var height: CGFloat = 0
        var width: CGFloat = frame.size.width - Spacing.base01
        
        switch configuration.type {
        case .logo:
            height = Layout.Size.logoCellHeight
        case .help:
            width = (width/2) - Spacing.base01
            height = Layout.Size.helpCellHeight
        case .product:
            height = Layout.Size.productCellHeight
        }
        
        return CGSize(width: width, height: height)
    }
}

// MARK: -- COLLECTION DELEGATE --
extension HomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = dataSource[indexPath.row]
        
        print("Item selecionado: \(selected)")
        
        if !selected.available {
            delegate?.showWarningSnackBar()
            return
        }
        
        switch selected.linkType {
        case .controller:
            delegate?.selectedController(title: selected.title, type: selected.type, id: selected.id)
        case .phone:
            delegate?.selectedSac(url: selected.linkAction)
        default:
            break;
        }
    }
}
