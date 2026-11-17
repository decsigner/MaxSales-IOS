//
//  AboutViewController.swift
//  MaxSales
//
//  Created by Fabio Miciano on 27/02/23.
//

import Foundation
import UIKit
import SwiftUI

extension AboutViewController.Layout {
    enum Sizing {
        static let imageHeight = 100
    }
}

final class AboutViewController: UIViewController {
    fileprivate enum Layout {}
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logoMaxSales"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var aboutUsContentLabel: UILabel = {
        let label = UILabel()
        label.text = "Somos uma empresa inovadora em serviços e benefícios.\n Acreditamos que podemos oferecer serviços de qualidade e com economia."
        label.textAlignment = .center
        label.numberOfLines = 40
        label.textColor = UIColor(red: 0.30, green: 0.30, blue: 0.30, alpha: 1.00)
        return label
    }()
    
    private lazy var aboutPlansTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "PLANOS SOB MEDIDA"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var aboutPlansContentLabel: UILabel = {
        let label = UILabel()
        label.text = "Criamos 5 planos sob medida para você e sua família. \n Mas se preferir podemos personalizar os serviços conforme suas necessidades. Visamos atender variados públicos, promovendo acessibilidade à saúde, educação, cultura e segurança com mais facilidade através do nosso aplicativo de benefícios. Otimizando o seu tempo, oferecendo rapidez e economia sem sair de casa."
        label.textAlignment = .center
        label.numberOfLines = 40
        label.textColor = UIColor(red: 0.30, green: 0.30, blue: 0.30, alpha: 1.00)
        return label
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.contentInset = .zero
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "QUEM SOMOS"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buildLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension AboutViewController: ViewConfiguration {
    func createHyerarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImage)
        contentView.addSubview(aboutUsContentLabel)
        contentView.addSubview(aboutPlansTitleLabel)
        contentView.addSubview(aboutPlansContentLabel)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
            $0.height.greaterThanOrEqualTo(view.frame.height)
        }
        
        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Layout.Sizing.imageHeight)
        }
        
        aboutUsContentLabel.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
        }
        
        aboutPlansTitleLabel.snp.makeConstraints {
            $0.top.equalTo(aboutUsContentLabel.snp.bottom).offset(Spacing.base04)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
        }
        
        aboutPlansContentLabel.snp.makeConstraints {
            $0.top.equalTo(aboutPlansTitleLabel.snp.bottom).offset(Spacing.base02)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base02)
        }
    }
}

#if DEBUG
struct AboutViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let controller = AboutViewController()
            let navigation = UINavigationController(rootViewController: controller)
            return navigation
        }
    }
}
#endif
