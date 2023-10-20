from kivy.app import App

from kivy.uix.label import Label
from kivy.uix.screenmanager import ScreenManager, Screen, FadeTransition
from kivy.uix.button import Button
from kivy.uix.boxlayout import BoxLayout


#
#
#WOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
#
#




sm = ScreenManager(transition=FadeTransition())

class SwitchToApp(App):
    #cos pod tym jest zle, napraw wracanie albo zrob to inaczej idk
    def do_switch_to_settings(self, *instance):
        scr2 = Screen(name='settings')
        
        layout=BoxLayout(orientation="horizontal")
        button1=Button(text="menu")
        button1.bind(on_press=self.build)
        button2=Button(text="ustawienia")
        
        
        layout.add_widget(button1)
        layout.add_widget(button2)
        
        
        
        
        scr2.add_widget(layout)
        sm.switch_to(scr2)
        
        
        
        
        return sm
    
    
    
    def build(self,*instance):
        scr1 = Screen(name='menu')
        button1=Button(text="change")
        button1.bind(on_press=self.do_switch_to_settings)
        button2=Button(text="JAZDAAAA")
        layout=BoxLayout(orientation="vertical")
        #   RZECZY TU
        layout.add_widget(button1)
        layout.add_widget(button2)
        
        
        
        #
        scr1.add_widget(layout)
        
        
        sm.add_widget(scr1)
        
        
        return sm

    
        


if __name__ == '__main__':
    
    SwitchToApp().run()