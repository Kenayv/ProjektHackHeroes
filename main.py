from kivy.app import App
from kivy.lang import Builder
from kivy.uix.screenmanager import ScreenManager, Screen
from kivy.uix.layout import Layout
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.button import Button
# Create both screens. Please note the root.manager.current: this is how
# you can control the ScreenManager from kv. Each screen has by default a
# property manager that gives you the instance of the ScreenManager used.

sm = ScreenManager()
#screens = [Screen(name='Title {}'.format(i)) for i in range(4)]
screens=[]
screens[0]=(Screen(name="first"))
screens[1]=(Screen(name="second"))
sm.switch_to(screens[0])


# Declare both screens
class MenuScreen(Screen):
    pass

class SettingsScreen(Screen):
    pass

class TestApp(App):
    
    
        
        
    def callback(self,instance):
        sm.current="second"
        print("XD")
        layout=BoxLayout(orientation="vertical")
        
        
        button1=Button(text="dosc")
        
        layout.add_widget(button1)
        
        return layout



    def build(self):
        
        
        layout=BoxLayout(orientation="vertical")
        
        
        button1=Button(text="xd?")
        button1.bind(on_press=self.callback)
        layout.add_widget(button1)
        

        return layout
    
    
    
   
    
    
    
    
    
    
    
    

if __name__ == '__main__':
    TestApp().run()