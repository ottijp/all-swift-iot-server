import FluentPostgreSQL
import Vapor

/// デバイスごとの状態
final class DeviceStatus: PostgreSQLModel {
    /// デバイスID
    var id: Int?

    /// LED
    var led: Bool

    /// 新しいデバイス状態の作成
    init(id: Int? = nil, led: Bool) {
        self.id = id
        self.led = led
    }
}

/// Allows `DeviceStatus` to be used as a dynamic migration.
extension DeviceStatus: Migration { }

/// Allows `DeviceStatus` to be encoded to and decoded from HTTP messages.
extension DeviceStatus: Content { }

/// Allows `DeviceStatus` to be used as a dynamic parameter in route definitions.
extension DeviceStatus: Parameter { }
