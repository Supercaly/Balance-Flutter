# Discorso da fare

## Introduzione generale
La postura instabile e le cadute sono seri problemi di salute che affliggono una grande percentuale della popolazione sopratutto con età superiore ai 65 anni. Anche se molte non sono gravi, alcune sono seguite da complicazioni e richiedono trattamenti medici e l'ospedalizzazione portando una diminuzione della mobilità del paziente.

Ricerche svolte in precedenza hanno rivelato che le cadute e le lesioni correlate possono essere prevenute studiando specifici fattori di rischio tramite l'analisi clinica della postura. 

L'applicazione sviluppata in questa tesi ha lo scopo di creare un metodo semplice, accessibile e rapido per analizzare la postura di un paziente.

## le pedane di forza
Tradizionalmente l'esame stabilometrico è eseguito tramite le pedane di forza. La pedana è dotata di celle di carico; il paziente esegue il test stando in piedi al centro della pedana in posizione neutra e con le braccia lungo i fianchi. La pedana misura la variazione del centro di pressione del paziente che è rappresentato sotto forma di vettore bidimensionale nelle dimensioni AP e ML.

Tipicamente dall'esame stabilometrico si producono due tipi di grafico: **stabilogramma** e **statokinesigramma**, il primo rappresenta la variazione del COP nel tempo, il secondo lo spostamento del COP del piano xy.

## il pendolo inverso
Quando si esegue l'analisi posturografica l'assunzione principale che si fa è quella di rappresentare il corpo umano in piedi come un singolo pendolo inverso. In questo sistema il movimento oscillatorio è rappresentato dall'azione di due forze:

* la forza di gravità che destabilizza il sistema
* la forza dei muscoli della caviglia che stabilizza il sistema

## le features
Da un test vengono ricavate diverse features:

 * features nel dominio del tempo -> ottenuti studiando lo sway path nel tempo
 * features nel dominio della frequenza -> ottenuti studiando la frequenza dello sway path per ottenere una stima delle frequenze in cui è concentrata l'energia
 * features strutturali -> studiano la sway density curve, la curva che per ogni istante di tempo conta il numero di campioni consecutivi dello statokinesigramma all'interno di un cerchio di dato raggio
 * features giroscopiche -> a differenza delle precedenti features queste studiano diversi parametri partendo dai dati del giroscopio

## i sensori degli smartphone
Per offrire agli utenti un numero sempre crescente di funzionalità i moderni smartphone integrano un gran numero di sensori diversi, tra questi abbiamo: 

* accelerometro
* giroscopio
* gps

Che sono i 3 sensori più popolari

* sensori di prossimità
* lettore di impronte digitali

Alcuni produttori di smartphone si spingono oltre inserendo sensori dei tipi più disparati, fra i quali:

* sensore d'umidità
* termometro
* cardiofrequenzimetro

### accelerometro e giroscopio
Nell'applicazione sviluppata ci concentreremo solamente su accelerometro e giroscopio poiché le features legate alla postura possono essere estratte dai loro valori.

Gli accelerometri e i giroscopi più moderni spesso sono di tipo MEMS ovvero sono prodotti con la stessa tecnologia utilizzata per creare i chip, per questo hanno dimensioni molto ridotte ed integrano nello stesso chip sia le componenti elettriche che meccaniche.

## Precedente sviluppo in Android
Inizialmente la tesi prevedeva lo sviluppo di un'applicazione solamente per la piattaforma Android utilizzando Kotlin e Java per programmare la logica. Arrivati ad un buon punto nello sviluppo del prototipo Android si è deciso di scartarlo e realizzarne uno nuovo ripartendo da zero utilizzando il framework Flutter; questo perché si è vista la disponibilità di più tempo per la consegna della tesi e perché si è valutata l'assenza di un corrispettivo per IOS che non richiedesse lo sviluppo di un'applicazione completa.

## Prototipo con Figma
Prima di passare direttamente all'implementazione dell'applicazione si è speso un pò di tempo per creare un prototipo dell'intera interfaccia utente in modo da delineare più facilmente tutte le funzionalità richieste e ridurre il tempo di sviluppo della UI, sapendo già prima come doveva essere.

Il prototipo è stato realizzato utilizzando il popolare strumento di design Figma. Figma è un'applicazione di UI/UX design basata sul browser che permette di creare prototipi di design in maniera facile e veloce.

## Flutter
Flutter è un framework open-source creato da Google per lo sviluppo di applicazioni native per IOS, Android, web e desktop partendo da un'unica codebase scritta nel linguaggio di programmazione Dart.

Ciò che differenzia flutter dagli altri strumenti comunemente usati per lo sviluppo nativo (Kotlin, Swift, ecc) è l'uso della Reactive Programming la quale si basa sugli stream di dati e sulla propagazione dei cambiamenti. 

Per la grafica Flutter utilizza un approccio dichiarativo, l'idea chiave è che la UI è una funzione dello stato, e con funzione si intende una funzione matematica. L'intera interfaccia utente è ricostruita ad ogni cambiamento di stato basandosi sul codice definito nei Widget. Un Widget ha il compito di ricreare la UI partendo dalla configurazione attuale e dal nuovo stato. In Flutter i Widget sono elementi componibili che spesso contengono solo una piccola funzionalità, ma vengono assemblati assieme per creare un Widget Tree che rappresenta l'intera applicazione. In Flutter tutto è un Widget.

## Il test della postura
Lo scopo principale dell'applicazione è eseguire i test della postura, l'idea è che ogni test sia fattibile in pochi secondi e possa essere eseguito quante volte si vuole. 

1. Prima di eseguire un test occorre settare se lo si eseguirà ad occhi aperti o chiusi. 
2. Premendo il bottone start test si darà inizio al test con un timer di 5 secondi per dare all'utente il tempo di sistemarsi. 
3. La misurazione vera e propria dura 32 secondi, i primi due secondi sono scartati perché possono contenere rumore prodotto dall'utente non ancora in posizione. Lasciandoci con un campione di 30 secondi, molto simile a quello ottenuto dalle pedane di forza

La postura corretta è in piedi, stando più dritti possibile, guardando avanti e tenendo il dispositivo con due mani ad altezza ombelico.

## Plugin per la lettura dei sensori
Un plugin in Flutter è una libreria di codice in grado di chiamare API specifiche della piattaforma, per questo esso contiene non solo codice scritto in Dart, ma anche parti di codice "nativo", scritto nel linguaggio di sviluppo della piattaforma (Kotlin/Java per Android, Swift/ObjectiveC per IOS), in questo modo è possibile ottenere più prestazioni, e utilizzare funzionalità specifiche per la piattaforma.

Per quest'applicazione in particolare, si ha il bisogno di leggere i risultati prodotti dai sensori con alcuni requisiti: 

1. configurare il tempo di lettura a priori
2. annullare la lettura prima del termine
3. ottenere una sequenza con frequenza di campionamento attorno a 100Hz

Con queste specifiche in mente si è pensato di utilizzare sensors, un plugin nativo di Flutter appositamente creato per ricevere tutti i dati dei sensori, purtroppo dai test effettuati al momento dello sviluppo il plugin non era in grado di produrre sequenze con sample rate maggiore di 8-10Hz, molto al disotto del target, per questo motivo si è scelto di creare da zero un plugin che risolvesse tutti i problemi.

## Calcolo delle features e il Flutter Isolate
Dart è un sistema single thread, per ottenere asincronia si utilizza un Event Loop che consente di eseguire più funzioni contemporaneamente. Nel caso occorra eseguire operazioni molto lente o calcoli pesanti Flutter consente di ottenere un diverso Event Loop nel quale eseguire il codice. Il `Flutter Isolate`, come dice il nome, è uno spazio di memoria isolato, con il quale è possibile scambiare dati solo tramite messaggi.

L'algoritmo per il calcolo delle features è composto da svariate operazioni, alcune anche fra matrici, le quali possono richiedere diverso tempo per essere calcolate; per questo motivo l'intero calcolo delle features è inserite all'interno di un Flutter Isolate separato.

## Dati ottenuti dall'analisi
Nell'applicazione i dati ottenuti da una misurazione sono mostrati all'utente sotto forma di lista.

## Dati d'anamnesi
L'applicazione è progettata per garantire all'utente l'anonimato; in questa tesi si è deliberatamente scelto di non utilizzare un database esterno, ne la connettività ad internet.

Seppure in anonimato vengono comunque richieste alcune informazioni personali: la principale è l'altezza dell'utente, fondamentale per la stima della postura poiché serve per calcolare il centro di gravità dell'utente, i restanti dati d'anamnesi sono:

* età
* genere
* peso
* problemi di postura
* problemi di postura in famiglia
* uso di farmaci che interferiscono con la postura
* altri traumi
* difetti visivi
* difetti uditivi

## Sviluppi futuri
Vari aspetti dell'applicazione sono stati lasciati come sviluppi per il futuro:

* L'implementazione e il testing delle funzionalità native in IOS; fra queste l'implementazione del codice nativo in Swift del plugin per la lettura dei sensori
* L'implementazione di un database remoto e di un sistema di API in grado di garantire le nuove norme della privacy e il GDPR rappresentando i dati in maniera anonima oppure spezzettandoli e tokenizzandoli
* Il miglioramento della richiesta dei dati d'anamnesi approfondendo quali dati vanno richiesti, consultando anche degli specialisti, in modo da studiare le correlazioni fra i dati e i risultati dei test