class Todo:
    def __init__(parametr):
        parametr.zadania = []

    def dodaj_zadanie(parametr, zadanie):
        parametr.zadania.append(zadanie)
        print("Zadanie dodane!")

    def pokaz_zadania(parametr):
        if not parametr.zadania:
            print("Brak zadań do zrobienia.")
        else:
            print("Lista zadań do zrobienia:")
            for i, zadanie in enumerate(parametr.zadania, 1):
                print(f"{i}. {zadanie}")

    def usun_zadanie(parametr):
        parametr.pokaz_zadania()
        try:
            numer_zadania = int(input("Wprowadź numer zadania do usunięcia: ")) - 1
            if 0 <= numer_zadania < len(parametr.zadania):
                usuniete_zadanie = parametr.zadania.pop(numer_zadania)
                print(f"Usunięto zadanie: {usuniete_zadanie}")
            else:
                print("Nieprawidłowy numer zadania.")
        except ValueError:
            print("Nieprawidłowa wartość. Wprowadź numer zadania do usunięcia.")


def main():
    To_do = Todo()

    while True:
        print("\nCo chcesz zrobić?")
        print("1. Dodaj nowe zadanie")
        print("2. Wyświetl listę zadań")
        print("3. Usuń zadanie")
        print("4. Wyjdź")

        Wybor = input("Wybierz opcję: ")

        if Wybor == "1":
            zadanie = input("Wprowadź zadanie, które chcesz zrealizować: ")
            To_do.dodaj_zadanie(zadanie)
        elif Wybor == "2":
            To_do.pokaz_zadania()
        elif Wybor == "3":
            To_do.usun_zadanie()
        elif Wybor == "4":
            print("Dziękuję! Do widzenia.")
            break
        else:
            print("Nieprawidłowa opcja. Wybierz 1, 2, 3 lub 4.")


if __name__ == "__main__":
    main()
