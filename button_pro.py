from gpiozero import Button
from signal import pause
import led
import subprocess

button = Button(18)

def click():
    print('on')
    led.light("green", 10)
    subprocess.call(['./burst.sh'])
    led.light("green", 10)
button.when_pressed = click

pause()
