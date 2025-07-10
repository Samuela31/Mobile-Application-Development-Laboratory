class IoTDevice {

  String name;

  bool status;

 

  IoTDevice(this.name, this.status);

 

  @override

  String toString() => 'Device: $name | Status: ${status ? "ON" : "OFF"}';

}

 

class IoTDeviceController {

  List<IoTDevice> devices = [];

 

  void addDevice(String deviceName, {bool status = false}) {

    devices.add(IoTDevice(deviceName, status));

  }

 

  void removeDevice(String deviceName) {

    devices.removeWhere((device) => device.name == deviceName);

  }

 

  void listDevices() {

    print('List of IoT Devices:');

    devices.forEach((device) => print(device));

  }

 

  void toggleDevice(String deviceName) {

    var device = devices.firstWhere(

      (device) => device.name == deviceName,

      orElse: () => IoTDevice(deviceName, false), // Return a default IoTDevice

    );

    device.status = !device.status;

    print("Device '$deviceName' toggled. Status changed to: ${device.status ? "ON" : "OFF"}");

  }

 

  void listDevicesOn() {

    print('List of IoT Devices (ON):');

    devices.where((device) => device.status).forEach((device) => print(device));

  }

}

 

void main() {

  var controller = IoTDeviceController();

 

  controller.addDevice('Light');

  controller.addDevice('Thermostat', status: true);

  controller.addDevice('Speaker');

  controller.listDevices();

  controller.toggleDevice('Light');

  controller.listDevicesOn();

  controller.removeDevice('Speaker');

}