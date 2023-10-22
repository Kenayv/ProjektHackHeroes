from kivy.app import App

from kivy.uix.label import Label
from kivy.uix.screenmanager import ScreenManager, Screen, FadeTransition
from kivy.uix.button import Button
from kivy.uix.boxlayout import BoxLayout
from kivy.graphics import Canvas


class PopUpScreen(Screen):
    pass


class MainMenuScreen(Screen):
    pass


class MainScreenManager(ScreenManager):
    pass


class MainMenuApp(App):
    def build(self):
        return MainScreenManager()


if __name__ == '__main__':
    MainMenuApp().run()
