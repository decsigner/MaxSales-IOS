//
//  LoginViewModel.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation
import Security
import UIKit

protocol LoginViewModeling: AnyObject {
    var delegate: LoginViewModelDelegate? { get set }
    func login(cpf: String?, password: String?)
    func autoLogin() -> Bool
    func contactSac()
    func session()
}

protocol LoginViewModelDelegate: AnyObject {
    func loginSuccess()
    func createSession(session: Session)
    func loginError(error: String)
}

final class LoginViewModel: LoginViewModeling {
    weak var delegate: LoginViewModelDelegate?
    private let service: Requester
    private let keychain = KeychainManager()
    
    init(service: Requester) {
        self.service = service
    }
    
    func session() {
        service.requestWith(endPoint: API.session) { [weak self] result in
            switch result {
            case let .success(model):
                do {
                    let decoder = JSONDecoder()
                    let session = try decoder.decode(Session.self, from: model)
                    self?.delegate?.createSession(session: session)
                } catch {}
            case let .failure(error):
                self?.delegate?.loginError(error: error.localizedDescription)
            }
        }
    }
    
    func autoLogin() -> Bool {
        guard let values = keychain.getAutoLogin() else {
            return false
        }
        login(cpf: values.first, password: values.last)
        return false
    }
    
    func login(cpf: String?, password: String?) {
        if let cpf = cpf, cpf.isEmpty {
            self.delegate?.loginError(error: "Preencha o CPF")
            return
        }
        
        if let password = password, password.isEmpty {
            self.delegate?.loginError(error: "Preencha a senha")
            return
        }
        
        guard let cpf = cpf, let password = password else {
            self.delegate?.loginError(error: "CPF e Senha são campos obrigatórios")
            return
        }
        
        service.requestWith(endPoint: API.login(cpf: cpf, password: password)) { [weak self] result in
            switch result {
            case .success(let model):
                guard let model = self?.decodableLogin(data: model) else { return }
                AuthUser.shared.set(token: model.token)
                self?.keychain.saveAutoLogin(cpf: cpf, password: password)
                self?.delegate?.loginSuccess()
            case .failure(let error):
                self?.delegate?.loginError(error: error.localizedDescription)
            }
        }
    }
    
    func contactSac() {
        guard let appURL = URL(string: "https://api.whatsapp.com/send?phone=5511939466858") else { return }
        UIApplication.shared.open(appURL)
    }
    
    private func decodableLogin(data: Data) -> Login? {
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(Login.self, from: data)
            return model
        } catch {
            return nil
        }
    }
}
