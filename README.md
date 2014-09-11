Evil Hangman
============

Dit project is een implementatie van het spel "Evil Hangman". Dit is een variant van het bekende spel 'galgje' maar in een vorm waarin de computer bij elke gok probeert vals te spelen door het woord dat geraden moet worden te veranderen.

**Features**

- Zodra de applicatie opstart zal het spel worden gestart.
- Op het startscherm zal de titel van de app en het logo te zien zijn.
- Op het startscherm zijn een knop voor het infoscherm en een knop voor het starten van een nieuw spel aanwezig.
- Het scherm waarin het spel gespeeld wordt bevat placeholders voor de letters waaruit het te raden woord bestaat.
- Het scherm waarin het spel gespeeld wordt bevat een tekening waarbij steeds een extra onderdeel getekend zal worden op het moment dat er een incorrecte gok gemaakt wordt. Op het moment dat deze tekening "compleet" is heeft de speler het spel verloren.
- De letters die goed geraden worden zullen op de juiste plek in de placeholders verschijnen, letters die fout geraden zijn zullen aan de zijkant van het speelveld geplaatst worden zodat de gebruiker weet welke letters hij al heeft gehad.
- Een custom on-screen keyboard zal altijd te zien zijn tijdens het spelen van het spel waarbij een letter die al geraden is op inactief gezet zal worden waardoor dezelfde letter niet 2x gebruikt kan worden.
- Als het spel afgelopen is (ofwel door het woord te raden, ofwel door alle kansen te gebruiken zonder het woord te raden) zal er een scherm te voorschijn komen waar de speler ziet of hij gewonnen of verloren heeft, wat zijn "score" (het aantal gebruikte kansen) is en een mogelijkheid hebben om het spel nogmaals te spelen.
- In het instellingenscherm (flipside) zijn voorkeuren in te stellen zoals de lengte van de woorden, en het maximale aantal kansen (deze instellingen zijn van toepassing op het volgende spel).


**Implementatie**
- Het startscherm en het instellingenscherm zijn instanties van de UIViewController klasse.
- Binnen het startscherm bevind zich het speelveld, dit is een instantie van UIView.
- Het speelveld bevat een tekening die zichzelf inkleurt naarmate er foute letters geraden worden. Deze tekening zal gemaakt worden door middel van Apple's Sprite Kit framework.
- Het textveld voor het te raden woord is een UITextField waarbij de nog niet geraden letters vervangen zijn door een "_". Op het moment dat er een letter geraden wordt zal deze vervangen worden door de juiste letter op de juiste positie.
- Op het moment dat het spel gewonnen of verloren wordt zal er de UIView van het speelveld vervangen worden door een UIView met daarin de resultaten. Hierdoor zijn de knoppen voor de instellingen en het herstarten van het spel nogsteeds zichtbaar.
- Het toetsenbord zal bestaan uit een verzameling van UIButtons. Het standaard toetsenbord wordt in dit geval niet gebruikt aangezien de letters die al gekozen zijn op inactief gezet moeten worden en er geen leestekens, letters met accenten of cijfers gebruikt mogen worden.
