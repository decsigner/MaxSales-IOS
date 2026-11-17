//
//  DetailFactory.swift
//  MaxSales
//
//  Created by Fabio Miciano on 20/03/23.
//

import Foundation
import UIKit

enum DetailFactory: String {
    case consulta
    case exames
    case dentista
    case personalfitness
    case nutricional
    case checkup
    case sorteio
    case automoto
    case residencial
    case inspecao
    case funeral
    case morteAcidental
    case pet
    case medicamentoGratis
    case telaQuebrada
    
    func make() -> UIViewController {
        switch self {
        case .consulta:
            let model = DetailBinding(
                title: "Consultas",
                image: "produtoSaude",
                text: NSLocalizedString("consultaText", comment: ""),
                whatsappLabel: NSLocalizedString("capitais", comment: ""),
                whastappContent: "(11) 93946-6858",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 191 2486"
            )
            return DetailViewController(model: model)
        case .exames:
            let model = DetailBinding(
                title: "Exames",
                image: "produtoSaude",
                text: NSLocalizedString("examesText", comment: ""),
                whatsappLabel: NSLocalizedString("capitais", comment: ""),
                whastappContent: "(11) 93946-6858",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 191 2486"
            )
            return DetailViewController(model: model)
        case .dentista:
            let model = DetailBinding(
                title: "Dentista",
                image: "produtoSaude",
                text: NSLocalizedString("dentistaText", comment: ""),
                whatsappLabel: NSLocalizedString("capitais", comment: ""),
                whastappContent: "(11) 93946-6858",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 191 2486"
            )
            return DetailViewController(model: model)
        case .personalfitness:
            let model = DetailBinding(
                title: "Personal",
                image: "previsul",
                text: NSLocalizedString("assistenciaPersonalText", comment: ""),
                whatsappLabel: NSLocalizedString("capitais", comment: ""),
                whastappContent: "(11) 3003-6773",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 709 8059"
            )
            return DetailViewController(model: model)
        case .nutricional:
            let model = DetailBinding(
                title: "Nutricional",
                image: "previsul",
                text: NSLocalizedString("assistenciaNutricionalText", comment: ""),
                whatsappLabel: NSLocalizedString("capitais", comment: ""),
                whastappContent: "(11) 3003-6773",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 709 8059"
            )
            return DetailViewController(model: model)
        case .checkup:
            let model = DetailBinding(
                title: "Check-Up",
                image: "previsul",
                text: NSLocalizedString("checkupText", comment: ""),
                whatsappLabel: NSLocalizedString("capitais", comment: ""),
                whastappContent: "(11) 3003-6773",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 709 8059"
            )
            return DetailViewController(model: model)
        case .sorteio:
            let model = DetailBinding(
                title: "Sorteio",
                image: "previsul",
                text: NSLocalizedString("sorteioText", comment: ""),
                whatsappLabel: NSLocalizedString("capitais", comment: ""),
                whastappContent: "(11) 3003-6773",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 709 8059"
            )
            return DetailViewController(model: model)
        case .automoto:
            let model = DetailBinding(
                title: "Auto & Moto",
                image: "previsul",
                text: NSLocalizedString("autoMotoText", comment: ""),
                whatsappLabel: NSLocalizedString("capitais", comment: ""),
                whastappContent: "(11) 3003-6773",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 709 8059"
            )
            return DetailViewController(model: model)
        case .residencial:
            let model = DetailBinding(
                title: "Residencial",
                image: "previsul",
                text: NSLocalizedString("residencialText", comment: ""),
                whatsappLabel: NSLocalizedString("capitais", comment: ""),
                whastappContent: "(11) 3003-6773",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 709 8059"
            )
            return DetailViewController(model: model)
        case .inspecao:
            let model = DetailBinding(
                title: "Inspeção Domiciliar",
                image: "previsul",
                text: NSLocalizedString("inspecaoText", comment: ""),
                whatsappLabel: NSLocalizedString("capitais", comment: ""),
                whastappContent: "(11) 3003-6773",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 709 8059"
            )
            return DetailViewController(model: model)
        case .funeral:
            let model = DetailBinding(
                title: "Funerária",
                image: "previsul",
                text: NSLocalizedString("funeralText", comment: ""),
                whatsappLabel: NSLocalizedString("capitais", comment: ""),
                whastappContent: "(11) 3003-6773",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 709 8059"
            )
            return DetailViewController(model: model)
        case .morteAcidental:
            let model = DetailBinding(
                title: "Morte Acidental",
                image: "previsul",
                text: NSLocalizedString("morteAcidentalText", comment: ""),
                whatsappLabel: NSLocalizedString("capitais", comment: ""),
                whastappContent: "(11) 3003-6773",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 709 8059"
            )
            return DetailViewController(model: model)
        case .pet:
            let model = DetailBinding(
                title: "Assistência PET",
                image: "previsul",
                text: NSLocalizedString("assistenciaPetText", comment: ""),
                whatsappLabel: "WhatsApp",
                whastappContent: "(51) 99528 0140",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 880 1900"
            )
            return DetailViewController(model: model)
        case .medicamentoGratis:
            let model = DetailBinding(
                title: "Assistência Medicamentos",
                image: "sabemi",
                text:  NSLocalizedString("medicamentoGratuito", comment: ""),
                whatsappLabel: "WhatsApp",
                whastappContent: "(51) 99528 0140",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 880 1900")
            
            return DetailViewController(model: model)
        case .telaQuebrada:
            let model = DetailBinding(
                title: "Quebra de tela",
                image: "sabemi",
                text:   NSLocalizedString("telaQuebrada", comment: ""),
                whatsappLabel: "",
                whastappContent: "",
                phoneLabel: NSLocalizedString("outrasLocalidades", comment: ""),
                phoneContent: "0800 721 3874")
            return DetailViewController(model: model)
        }
    }
}
