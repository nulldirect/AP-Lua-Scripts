import pynput
#from time import sleep
mouse = pynput.mouse.Controller()
with pynput.mouse.Events() as events:
    while True:
        event = events.get(1)
        if event!=None:
            try:
                if event.button==pynput.mouse.Button.right:
                    if event.pressed:
                        #pressed=True
                        pos=mouse.position
                        #print(pos)
                    else:
                        #sleep(0.01)
                        #pressed=False
                        #print(pos)
                        mouse.position=(pos[0],pos[1])


            except:
                pass



