import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // デバイス状態の操作
    let deviceStatusController = DeviceStatusController()
    router.get("deviceStatus", use: deviceStatusController.index)
    router.get("deviceStatus", DeviceStatus.parameter, use: deviceStatusController.detail)
    router.post("deviceStatus", use: deviceStatusController.create)
    router.put("deviceStatus", DeviceStatus.parameter, use: deviceStatusController.update)
    router.delete("deviceStatus", DeviceStatus.parameter, use: deviceStatusController.delete)
}
