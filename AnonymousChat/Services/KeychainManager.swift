
import Foundation
import Security

struct Credentials: Codable {
    let login: String
    let password: String
}

class KeychainManager {
    
    static let shared = KeychainManager()
    
    private init() {}
    
    func save<T: Codable>(key: String, value: T) -> Bool {
        
        guard let data = try? JSONEncoder().encode(value) else { return false }
        
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }
    
    func load<T: Codable>(key: String) -> T? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            print("KeychainManager.load - Error decoding JSON")
            return nil
        }
        return decoded
    }
    
    func delete(key: String) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key
            ]
            
            SecItemDelete(query as CFDictionary)
        }
    
    func saveCredentials(login: String, password: String) -> Bool {
            let creds = Credentials(login: login, password: password)
            let id = login
            let success = save(key: "creds.\(id)", value: creds)
            if success {
                _ = save(key: "creds.active", value: id)
            }
            return success
        }
        
        func loadActiveCredentials() -> Credentials? {
            guard let id: String = load(key: "creds.active") else { return nil }
            return load(key: "creds.\(id)")
        }
        
        func loadCredentials(for login: String) -> Credentials? {
            return load(key: "creds.\(login)")
        }
        
        func deleteCredentials(for login: String) {
            delete(key: "creds.\(login)")
        }
        
        func clearActiveCredentials() {
            delete(key: "creds.active")
        }
}
