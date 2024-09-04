#include <iostream>
#include <string>

// Klasa Miejscowość - pusta klasa w tym przypadku
class Miejscowość {
public:
    // Można dodać później pola i metody, jeśli zajdzie taka potrzeba
};

// Klasa Budynek
class Budynek {
private:
    double metraż;         // Pole do przechowywania metrażu w metrach kwadratowych
    std::string typ;       // Pole do przechowywania typu budynku (prywatny/publiczny)
    Miejscowość* miejscowość; // Wskaźnik do miejscowości (można używać wskaźników lub referencji)

    // Statyczne liczniki dla każdego typu budynku
    static int licznikPrywatnych;
    static int licznikPublicznych;

public:
    // Konstruktor argumentowy
    Budynek(double metraż, const std::string& typ, Miejscowość* miejscowość)
        : miejscowość(miejscowość) {
        setMetraż(metraż); // Używamy setera dla metrażu
        setTyp(typ);      // Używamy setera dla typu budynku
    }

    // Destruktor
    virtual ~Budynek() {
        // Aktualizacja liczników przy usuwaniu instancji
        if (typ == "prywatny") {
            --licznikPrywatnych;
        } else if (typ == "publiczny") {
            --licznikPublicznych;
        }
    }

    // Getter metrażu
    double getMetraż() const {
        return metraż;
    }

    // Setter metrażu (z walidacją)
    void setMetraż(double metraż) {
        if (metraż >= 10.0) {
            this->metraż = metraż;
        } else {
            std::cerr << "Błąd: Metraż nie może być mniejszy niż 10 m²." << std::endl;
        }
    }

    // Getter typu
    std::string getTyp() const {
        return typ;
    }

    // Setter typu (wpływający na liczniki instancji)
    void setTyp(const std::string& typ) {
        // Aktualizacja liczników przy zmianie typu budynku
        if (this->typ == "prywatny") {
            --licznikPrywatnych;
        } else if (this->typ == "publiczny") {
            --licznikPublicznych;
        }

        // Ustawienie nowego typu
        this->typ = typ;

        if (typ == "prywatny") {
            ++licznikPrywatnych;
        } else if (typ == "publiczny") {
            ++licznikPublicznych;
        }
    }

    // Getter miejscowości
    Miejscowość* getMiejscowość() const {
        return miejscowość;
    }

    // Setter miejscowości
    void setMiejscowość(Miejscowość* miejscowość) {
        this->miejscowość = miejscowość;
    }

    // Statyczne metody dostępu do liczników
    static int getLicznikPrywatnych() {
        return licznikPrywatnych;
    }

    static int getLicznikPublicznych() {
        return licznikPublicznych;
    }

    // Operator porównania ==
    bool operator==(const Budynek& inny) const {
        // Porównanie miejscowości - zakładamy, że porównujemy wskaźniki
        bool miejscowośćRówne = (miejscowość == inny.miejscowość);

        // Porównanie typu
        bool typRówny = (typ == inny.typ);

        // Porównanie metrażu z dokładnością do 1 m²
        bool metrażRówny = (std::abs(metraż - inny.metraż) < 1.0);

        return miejscowośćRówne && typRówny && metrażRówny;
    }
};

// Inicjalizacja statycznych liczników
int Budynek::licznikPrywatnych = 0;
int Budynek::licznikPublicznych = 0;

