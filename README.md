# Dokumentation - Flashcards

# 1 Starten der App

Die Flashcards-App wird in Xcode gestartet und läuft dann auf einem iPhone-Simulator. Hierbei sollte das iPhone 13 als Device eingestellt werden, um die App auf dem “neusten Stand” der Technik zu benutzen.

# 2 Features

Die Flashcards-App verfügt über mehrere Features, die das Lernen von Vokabeln, Sachtexten und ähnlichen Inhalten möglich machen.

## 2.1 Neues Deck erstellen

Ein neues Deck wird auf der **Add-Content-View** erstellt. Hierzu drückt man den + - Button am unteren mittleren Bildschirmrand, soweit man sich nicht in einem schon vorhandenen Deck befindet. Daraufhin öffnet sich die **Add-Content-View**, in der man dem neuen Deck einen Titel und eine Farbe hinzufügen kann. Zudem ist es auch direkt möglich, eine oder mehrere Flashcards für dieses Deck anzulegen, wobei das auch später noch geht.

## 2.2 Vorhandenes Deck anschauen

Vorhandene Decks werden in der **Deck-View** angezeigt. Um auf die **Deck-View** zu gelangen, drückt man den Home-Button am unteren linken Bildschirmrand. Falls Decks vorhanden sind, gibt es in der **Deck-View** schon einen Counter zur Anzahl der Flashcards, die ein Deck enthält. Auch gibt es einen Progress-Balken, welcher einen Eindruck dafür liefert, wie viele Flashcards aus einem Deck man schon gelernt hat. 

Um ein bestimmtes Deck anzuschauen, drückt man einfach auf das gewählte Deck und wird in die **Deck-Menu-View** weitergeleitet. Hier bekommt man einen Überblick über die schon erwähnten Statistiken (Anzahl der Flashcards, Progress-Bar). Auch werden hier alle Flashcards in einer **Scroll-View** angezeigt, damit man auch Flashcards individuell betrachten kann. Neu ist hier der Statistiken-Button, der noch mehr Einsicht über den aktuellen Lernstand gibt.

## 2.3 Vorhandenes Deck anpassen

Um ein vorhandenes Deck anzupassen, drückt man auf den + - Button am unteren mittleren Bildschirmrand, während man sich in der **Deck-Menu-View** befindet. Jetzt öffnet sich die schon bekannte **Add-Content-View**, mit dem Unterschied, dass hier der Deck-Titel und die Deck-Farbe schon gegeben sind und auch vorhandene Flashcards angezeigt werden. 

Das ändern des Deck-Titels, der Deck-Farbe oder den Inhalten einer einzelnen Flashcard ist trivial: Man drückt einfach auf das jeweilige Textfeld (bei der Farbe auf das Farb-Select-Feld) und editiert den Inhalt.

Hier kann man jetzt auch Flashcards löschen, indem man eine Flashcard mit einem Finger-Swipe nach links zieht, sodass ein roter Mülleimer-Button zum Vorschein kommt. Mit einem Druck darauf wird die Flashcard aus dem Deck gelöscht und verschwindet somit aus der Ansicht.

## 2.4 Flashcards individuell

Flashcards können auch ohne das Aufrufen des noch folgenden **Lern-Modus** angeschaut werden. Hierzu begibt man sich in die zuvor erwähnte **Deck-Menu-View** und wählt die Flashcard aus, die man sich anschauen möchte. Mit einem Druck auf die ausgewählte Flashcard gelangt man auf die **Card-View**, die zunächst die Vorderseite der Flashcard und einen Flip-Card-Button anzeigt. Drückt man auf den Flip-Card-Button, so wird die Rückseite der Flashcard angezeigt.

So können Flashcards gelernt oder wiederholt werden, ohne dass man sich im **Lern-Modus** befindet. Das kann hilfreich sein, wenn man auf die Schnelle etwas herausfinden möchte.

Es gibt auch noch die Möglichkeit des Lernens im **Free-Learn Modus**, der im nächsten Abschnitt beschrieben wird. Dabei wird am aktuellen Lernstand auch keine Änderung vorgenommen.

## 2.5 Lern-Modus

Der **Lern-Modus** bringt den Benutzer dazu, die vorhandenen Flashcards zu lernen. Um in den Lern-Modus zu gelangen, öffnet man zunächst die **Lern-Start-View** mit einem Druck auf den Buch-Button am unteren rechten Bildschirmrand. Hier kann nun ausgewählt werden, aus welchen Decks die zu lernenden Flashcards angezeigt werden. Das hilft dem Benutzer, falls er nicht nur Flashcards aus einem bestimmten Deck lernen möchte, sodass auch etwas Abwechslung beim Lernen aufkommt.

### 2.5.1 Spaced-Repetition Modus

Standardmäßig befindet sich der Benutzer der Flashcards-App im **Spaced-Repetition Modus**. Jetzt werden alle Decks angezeigt, die Flashcards enthalten, die heute oder an vorherigen Tagen fällig sind oder waren. Nach der Auswahl der zu lernenden Decks gelangt man mit einem Druck auf den Ausgewählte-Lernen-Button in den **Lern-Modus**. Jetzt werden die Flashcards nacheinander wie schon in der beschriebenen **Card-View** angezeigt. Der Unterschied ist jetzt, dass man nach dem flippen der Flashcard vier Buttons angezeigt bekommt, mit denen man beurteilen kann, ob man die Flashcard wiederholen möchte, sie schwer, mittel oder einfach fand. Nachdem man sich für eine Option entschieden hat, folgt die nächste Flashcard, bis keine Flashcards mehr zum Lernen übrig sind.

### 2.5.2 Free-Learn Modus

Um in den **Free-Learn Modus** zu wechseln, betätigt man einfach den Free-Learn-Toggle der über der Liste der Decks zu finden ist. Hier können jetzt alle Flashcards eines Decks gelernt werden. Ab jetzt verhält sich die Flashcards-App genauso wie beim **Spaced-Repetition Modus** mit dem Unterschied, dass das Lernen keinen Einfluss auf den gegebenen Lernstand nimmt.

## 2.6 Spaced-Repetition

Das Prinzip **Spaced-Repetition** baut auf dem Konzept von 8 Boxen auf, wobei diese Zahl variabel ist. Anfangs befinden sich neue Flashcards, aber auch Flashcards, die an irgendeinem Zeitpunkt beim Lernen als **failed** markiert wurden (→ Im **Lern-Modus** wurde die Option Wiederholen verwendet), in der Box 0.

In der Flashcards-App gibt es vier Stufen, in denen man im Lern-Modus eine Flashcard bewerten kann:

- *Negativ* (Wiederholen) → Flashcard wird in Box 0 gelegt und taucht im Lern-Modus später wieder auf
- *Hart* → Flashcard wird von der jetzigen Box in die darunter gelegt
- *Gut* → Flashcard wird von der jetzigen Box in die darüber gelegt
- *Einfach* → Flashcard wird mit einem Faktor 1.5 von der jetzigen Box in die darüber gelegt. Hier wird abgerundet, sodass sich dieses Verhalten erst bei zweifachem *Einfach* bemerkbar macht, weil dann eine Box übersprungen wird.

Die Intervalle zum Lernen werden mit dem **Lern-Intervall-Multiplikator** von **2.05** bereitgestellt. Das **Lern-Intervall** bei der ersten Box liegt immer bei 3 Tagen. Danach kommt der Multiplikator zum Einsatz, wobei das Ergebnis immer aufgerundet, in der Rechnung aber mit dem ungerundeten Ergebnis gearbeitet wird:

| Box 2 | 3 * 2.05 =  7 |
| --- | --- |
| Box 3 | 6.15 * 2.05 = 13 |
| Box 4 | 12.61 * 2.05 = 26 |
| … | … |

Daraus ergeben sich die Lern-Intervalle von **3, 7, 13, 26, 53, 109 und 223 Tagen**. Es gibt zwar nur acht Boxen (einschließlich der Box 0), das Intervall einer Flashcard wird ab der siebten Box dennoch erhöht, sie ist aber trotzdem der Box 8 zugehörig.

Durch diese wissenschaftlich bewiesene Lernmethode ist das Lernen strukturierter und führt **schneller zum Erfolg**.

# 3 Benutzte Frameworks

### 3.1 SwiftUI

SwiftUI wurde in der Flashcards-App ausgiebig verwendet. Besonders wichtig ist SwiftUI dafür, die App und das App-Aussehen zu einer iOS-Experience zu machen. Zudem war es das Framework, was uns in der Veranstaltung nahegelegt wurde.

SwiftUI hat beim Bauen der App sehr geholfen, da man verschiedene, einem selbst schon bekannte iOS-Features leicht in die Flashcards-App einbauen konnte. Hierzu zählen z.B. Views, Buttons und Textfelder. Auch war es sehr einfach, die gegebenen Komponenten zu Stylen, sodass man schnell eine ansprechende Oberfläche aufbauen konnte.

### 3.2 Foundation

Foundation wurde bei uns öfter bei FetchRequests und beim Benutzen von NS-Types benutzt. Somit wurde es ermöglicht, mit den Daten zu arbeiten, die man mit purem Swift und SwiftUI nicht interpretieren und auswerten kann.

# 4 Datenstruktur

Die Datenstruktur der Flashcards-App wurde bei uns in Core-Data umgesetzt. Es war anfänglich sehr einfach die von uns erdachte Datenstruktur anzulegen: Es gibt Decks und es gibt Flashcards, die einem Deck zugehörig sind, es herrscht hier eine 1-n-Beziehung.

- Deck
    
    Ein Deck ist wie in der folgenden Tabelle aufgebaut:
    
    | Attribut | Datentyp | Nutzen |
    | --- | --- | --- |
    | id | UUID | ID des Decks |
    | color | Transformable | Die Farbe, die dem Deck zugewiesen ist |
    | title | String | Der Titel des Decks |
    | ////////////////// | ////////////////// | //////////////////////////////////////////////////////////////////////// |
    | Relationship | Beziehung | Nutzen |
    | deckToCard | n - 1 | Gibt an, dass ein Deck mehrere Flashcards enthalten kann |
- Flashcard
    
    Eine Flashcard ist wie in der folgenden Tabelle aufgebaut:
    
    | Attribut | Datentyp | Nutzen |
    | --- | --- | --- |
    | id | UUID | ID der Flashcard |
    | createdAt | Date | Erstelldatum der Flashcard |
    | lastReviewed | Date | Aufrufdatum des letzten Aufrufs der Flashcard |
    | failedCount | Integer | Anzahl der Fehlschläge beim Lernen einer Flashcard |
    | passedCount | Integer | Anzahl der Erfolge beim Lernen einer Flashcard |
    | box | Float | Gibt die Box an, in der sich die Flashcard derzeitig befindet |
    | front | String | Text der Vorderseite der Flashcard abzuspeichern |
    | back | String | Text der Rückseite der Flashcard abspeichern |
    | ////////////////// | ////////////////// | //////////////////////////////////////////////////////////////////////// |
    | Relationship | Beziehung | Nutzen |
    | cardToDeck | 1 - n | Gibt an, dass sich eine Flashcard nur in einem Deck befindet |