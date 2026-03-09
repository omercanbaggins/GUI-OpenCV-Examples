import serial
import time


class SerialHandler:
    numberofSerialComm = 0
    SerialComs = []
    def addSerialCom(SerialCom):
        SerialHandler.SerialComs.append(SerialCom)
        SerialHandler.numberofSerialComm+=1
    def removeSerialCom(SerialCom):
        SerialHandler.SerialComs.remove(SerialCom)
    

class serialCommunicator():

    def __init__(self,protocolName="",COM="COM3",Sbaudrate=9600,timeout=1.0):
        self.serRef = serial.Serial(COM,baudrate=Sbaudrate)
        self.currentData = 0
        SerialHandler.addSerialCom(self)
        self.protocolName = protocolName
        self.dataDelegateBindings = []
    def getData(self):
            time.sleep(0.1)
            s =self.serRef.read_until()
            self.currentData = s
            
            for object,function in self.dataDelegateBindings:
                function()


