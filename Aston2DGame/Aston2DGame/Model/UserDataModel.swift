//
//  GameModel.swift
//  Aston2DGame
//
//  Created by Александра Тимонова on 21.09.2023.
//

import Foundation

extension UserDefaults {
    func saveData<T: Encodable>(someData: T, key: String) {
        let data = try? JSONEncoder().encode(someData)
        set(data, forKey: key)
        
    }
    
    func readData<T: Decodable>(type: T.Type, key: String) -> T? {
        guard let data = value(forKey: key) as? Data else { return nil }
        let newData = try? JSONDecoder().decode(type, from: data)
        return newData
    }
}

final class UserDataModel: Codable {

    private var key = "UserData"
    private(set) var speed: CGFloat
    private(set) var playerName: String
    private(set) var shipImageName: String
    private(set) var playersRecords: [PlayerRecord]
    
    static let shared = UserDataModel()
    
    private init() {
        if let data = UserDefaults.standard.readData(type: UserDataModel.self, key: key) {
            self.speed = data.speed
            self.playerName = data.playerName
            self.shipImageName = data.shipImageName
            self.playersRecords = data.playersRecords
        } else {
            self.speed = 30
            self.playerName = "Player"
            self.shipImageName = "firstPlane"
            self.playersRecords = []
        }
        
    }

    func setSpeed(speed: CGFloat) {
        self.speed = speed
    }
    func setPalyerName(playerName: String) {
        self.playerName = playerName
    }
    func setShipImageName(shipImageName: String) {
        self.shipImageName = shipImageName
    }
    func saveData() {
        UserDefaults.standard.saveData(someData: self, key: key)
    }
    func addNewRecord(score: Int) {
        if let index = playersRecords.firstIndex(where: {
            $0.name == playerName
        }) {
            playersRecords[index].record = max(playersRecords[index].record, score)
        } else {
            playersRecords.append(PlayerRecord(name: playerName, record: score))
        }
        playersRecords = playersRecords.sorted { $0.record > $1.record }
    }

}

struct PlayerRecord: Codable {
     let name: String
    var record: Int
}
