require 'serialport'
class Lights
  LIGHTS = [
      {
          id: 1,
          name: 'small room',
          type: 'livolo',
          id1: 120,
          id2: 0,
          status: false
      },
      {
          id: 2,
          name: 'kitchen',
          type: 'itead',
          id1: 31,
          id2: 82,
          status: false
      }
  ]

  def initialize
    #@controller = SerialPort.new('/dev/ttyACM0', 115200)
    @controller = SerialPort.new('/dev/tty.usbmodem1411', 115200)
  end

  def update(light, status)
    type = light[:type] == 'itead' ? 1 : 2
    action = status == 'on' ? 1 : 2
    puts "sending: #{type},#{action},#{light[:id1]},#{light[:id2]};"
    @controller.write_nonblock "#{type},#{action},#{light[:id1]},#{light[:id2]};"
  end

end