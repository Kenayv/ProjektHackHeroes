zadania = []

# Funkcja do dodawania zadania do listy
def Dodaj_zadanie():
    zadanie = input("Wprowadź zadanie, które chcesz zrealizować: ")
    zadania.append(zadanie)
    print("Zadanie dodane!")

# Funkcja do wyświetlania listy zadań
def Pokaz_zadania():
    if not zadania:
        print("Brak zadań do zrobienia.")
    else:
        print("Lista zadań do zrobienia:")
        for i, zadanie in enumerate(zadania, 1):
            print(f"{i}. {zadanie}")

# Funkcja do usuwania zadania z listy
def Usun_zadania():
    Pokaz_zadania()
    try:
        numer_zadania = int(input("Wprowadź numer zadania do usunięcia: ")) - 1
        if 0 <= numer_zadania < len(zadania):
            usuniete_zadanie = zadania.pop(numer_zadania)
            print(f"Usunięto zadanie: {usuniete_zadanie}")
        else:
            print("Nieprawidłowy numer zadania.")
    except ValueError:
        print("Nieprawidłowa wartość. Wprowadź numer zadania do usunięcia.")

# Główna pętla programu
while True:
    print("\nCo chcesz zrobić?")
    print("1. Dodaj nowe zadanie")
    print("2. Wyświetl listę zadań")
    print("3. Usuń zadanie")
    print("4. Wyjdź")

    wybor = input("Wybierz opcję: ")

    if wybor == "1":
        Dodaj_zadanie()
    elif wybor == "2":
        Pokaz_zadania()
    elif wybor == "3":
        Usun_zadania()
    elif wybor == "4":
        print("Dziękuję! Do widzenia.")
        break
    else:
        print("Nieprawidłowa opcja. Wybierz 1, 2, 3 lub 4.")
    
     