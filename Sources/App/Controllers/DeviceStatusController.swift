import Vapor

/// デバイス状態のCRUD操作
final class DeviceStatusController {
    /// デバイス状態のリストを返す
    func index(_ req: Request) throws -> Future<[DeviceStatus]> {
        return DeviceStatus.query(on: req).all()
    }

    /// パラメータで指定されたデバイス状態を返す
    func detail(_ req: Request) throws -> Future<DeviceStatus> {
        return try req.parameters.next(DeviceStatus.self)
    }

    /// デコードされたデバイス状態をDBに保存する
    func create(_ req: Request) throws -> Future<DeviceStatus> {
        return try req.content.decode(DeviceStatus.self).flatMap { deviceStatus in
            return deviceStatus.save(on: req)
        }
    }

    /// パラメータで指定されたデバイス状態を更新する
    func update(_ req: Request) throws -> Future<DeviceStatus> {
        return try req.parameters.next(DeviceStatus.self).flatMap { oldDeviceStatus in
            return try req.content.decode(DeviceStatus.self).flatMap { newDeviceStatus in
                oldDeviceStatus.led = newDeviceStatus.led
                return oldDeviceStatus.update(on: req)
            }
        }
    }

    /// パラメータで指定されたデバイス状態を削除する
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(DeviceStatus.self).flatMap { deviceStatus in
            return deviceStatus.delete(on: req)
            }.transform(to: .ok)
    }
}
