from kivy.app import App

from kivy.uix.screenmanager import ScreenManager, Screen
from kivy.uix.image import Image
from kivy.uix.widget import Widget


class LogoImg(Widget):
    pass


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
