import sys
import time
import RPi.GPIO as GPIO

def light(color = "red", flashing = 1, onTime = 0.3, offTime = 0.1):
	try:
		led = 22
		if (color == "green"):
                        led = 27

		GPIO.setup(led,GPIO.OUT)

		for i in range(0, flashing):
			print("Light on")
			GPIO.output(led,GPIO.HIGH)
			time.sleep(onTime)
			print("Light off")
			GPIO.output(led,GPIO.LOW)
			time.sleep(offTime)
	except:
		GPIO.cleanup()
