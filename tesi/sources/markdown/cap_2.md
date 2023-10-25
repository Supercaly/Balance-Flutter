# Analisi stabilometriche

## Sull'analisi posturografica
In questo capitolo tratteremo i concetti base dell'analisi posturografica ponendo particolare attenzione al modello biomeccanico del singolo pendolo inverso utilizzato per estrarre informazioni utili dal movimento e a come, tradizionalmente, tale analisi viene svolta.

L'analisi posturografica (o stabilometrica) permette di valutare la stabilità del paziente in posizione eretta studiando la posizione e la dinamica del baricentro, o per meglio dire, della proiezione del baricentro su un piano parallelo al terreno. L'analisi stabilometrica non misura l'equilibrio in senso letterale, ma la capacità del paziente nel mantenere una posizione eretta equilibrata.

I metodi utilizzati per l'analisi posturografica solitamente possono essere raggruppati in due categorie: ***statici*** oppure ***dinamici***. Nei test statici il paziente è posto in piedi su una superficie di misurazione piana orizzontale (spesso una pedana stabilometrica) con gli occhi aperti oppure chiusi, senza la presenza di alcuna perturbazione esterna; in questo modo si è in grado di stabilire la postura a riposo del paziente. Nei test dinamici la postura è perturbata da stimoli esterni imprevedibili dal paziente in modo da valutare la sua capacità di riprendere la postura iniziale.

Queste tecniche studiano differenti aspetti del sistema di controllo della postura umana e ci permettono di ottenere delle informazioni indipendenti le une dalle altre. La principale differenza è che nel paradigma statico la maggior parte del sistema sensoriale umano è attiva sotto ad una soglia limite (lo si puo considerare quindi a riposo) [konradson96] [fitzpatrick93] fatta eccezione dei recettori cutanei plantari [kavounoudias98] [wu97], mentre nel paradigma dinamico tutti i recettori sono attivi sopra la soglia limite. Un'altra differenza fra questi due sistemi è che nel caso statico l'unica fonte di instabilità nella postura è interna quindi il corpo è in grado di anticipare e correggere i disturbi, mentre nel caso dinamico il disturbo è esterno e non prevedibile.

## La pedana di forza
Per svolgere l'esame stabilometrico esistono vari strumenti, il più popolare è la **pedana di forza**.

Il corpo si muove grazie alla combinazione di forze interne, determinate dall'azione dei muscoli, e di forze esterne, scambiate dal corpo con l'ambiente esterno. La pedana 
è in grado di rilevare le forze esterne scambiate con il suolo misurando la deformazione che esse applicano su dei trasduttori di forza. Il punto di applicazione della forza è detto ***centro di pressione*** ($COP$) poiché è il centro della distribuzione della pressione sulla superficie di appoggio del piede.

Durante la prova il soggetto è posto in piedi, al centro della pedana, in posizione neutra con le braccia lungo i fianchi. Esistono vari protocolli di acquisizione posturale, i più comuni sono: test monopodalico (il paziente esegue il test stando su una sola gamba), test di Romberg (il paziente esegue il test sia ad occhi aperti che ad occhi chiusi per vedere l'influenza del sistema visivo sulla postura), interferenza cervicale (il paziente esegue il test tenendo il capo eretto e tenendo il capo flesso per valutare le influenze cervicali sulla postura).

## Il modello del singolo pendolo inverso
L'assunzione principale che si fa quando si esegue l'analisi posturografica è quella di rappresentare il corpo umano in piedi come un pendolo inverso. Il sistema in [Figura 1], composto dalla caviglia, il piede e il resto del corpo è modellato da un pendolo singolo inverso ancorato attorno all'articolazione della caviglia; in questo sistema il movimento oscillatorio avanti e indietro è rappresentato come l'azione di due forze opposte:
* la forza di gravità che destabilizza il sistema
* la forza dei muscoli della caviglia che stabilizza il sistema

Secondo la meccanica classica di Newton-Eulero è possibile descrivere la dinamica del sistema utilizzando la seguente equazione:

$d^2COG_v / dt^2 == mgh/I(COG_v-COP)$

dove: 
* $COG_v$ è la proiezione del centro di gravità sul piano parallelo al terreno 
* $COP$ è la proiezione del centro di pressione sul piano parallelo al terreno
* $h$ è la distanza tra la caviglia e il baricentro 
* $I$ è il momento d'inerzia del corpo attorno alla caviglia

Possiamo riscrivere l'equazione 1 anche come:

$COG_v(\omega)/COP(\omega) = \omega_0^2/\omega^2+\omega_0^2$

dove $\omega$ rappresenta la frequenza angolare e $w_0 = sqrt(mgh/I)$ è la frequenza naturale del pendolo inverso. Si noti che all'aumentare della frequenza l'output del sistema diminuisce gradualmente seguendo il comportamento di un filtro passa basso; la proiezione del centro di gravità nel dominio della frequenza può essere considerata come una versione filtrata del centro di pressione.

*Infine è importante ricordare che il processo di modellizzazione del corpo umano come un singolo pendolo inverso è tutt'altro che completo, specialmente per quanto riguarda la coordinazione e i modelli di controllo; fra i tentativi di miglioramento dell'accuratezza dei modelli troviamo il doppio pendolo inverso.*

## Dati ottenuti dall'analisi stabilometrica
Tipicamente dall'esame stabilometrico si producono due tipi di grafico (esempio in [Figura 2]):
* lo **statokinesigramma**, detto anche sway-path, raffigura lo spostamento del $COP$ nel piano $xy$
* lo **stabilogramma** mostra la variazione del $COP$ nel tempo

Il $COP$ è espresso sotto forma di vettore in due dimensioni: ***Antero-Posteriore*** (*AP*) e ***Medio-Laterale*** (*ML*).

Dallo statokinesigramma possiamo estrarre diversi parametri utili, questi possono essere classificati in due categorie: ***parametri globali*** e ***parametri strutturali***; i primi studiano lo sway-pattern nella sua totalità, mentre i secondi si concentrano nel suddividere le traiettorie in pezzetti più piccoli ed estrarre da essi dati utili.

Prima di tutto è importante ricordare che lo scopo di questa tesi è lo sviluppo di un'applicazione per smartphone in grado di determinare la postura e per fare ciò i dati del COP sono ricavati partendo dai valori dell'accelerometro presente nel dispositivo; ci concentreremo solo su alcuni parametri delineando le features da calcolare come:
1. Features nel dominio del tempo
2. Features nel dominio della frequenza
3. Features strutturali
4. Features giroscopiche

Le *features nel dominio del tempo* contengono tutti i parametri ricavati dallo studio del comportamento dello sway-path nel tempo: 
* Sway path -> lunghezza della traiettoria del $COP$ nel tempo
* Mean distance -> distanza media dal centro del $COP$
* Standard deviation of the displacement -> deviazione standard del displacement totale del $COP$
* Range -> massima distanza tra due punti del $COP$

Le *features nel dominio della frequenza* si ricavano dalla frequenza dello sway-path, il loro scopo principale è quello di avere una stima dell'energia dello sway-path e di come essa è concentrata nelle varie frequenze:
* Frequency at 80% -> banda di frequenza che contiene l'80% della frequenza nello spettro AP e ML
* Mean frequency -> media della frequenza nello spettro AP e ML
* Frequency peak -> i picchi della frequenza nello spettro AP e ML

Le *features strutturali* studiano la sway density curve (SDC) definita come la curva, tempo-indipendente, che per ogni istante temporale conta il numero di campioni consecutivi dello statokinesigramma all'interno di un cerchio di dato raggio. Gli indicatori ricavati sono i seguenti:
* np -> numero medio di picchi nella SDC
* mean time -> media della distanza temporale fra due picchi della SDC
* std time -> deviazione standard di mean time
* mean peak -> durata media dei picchi della SDC
* sdt peak -> deviazione standard dei mean peak
* mean distance -> media della distanza spaziale fra due picchi della SDC
* std distance -> deviazione standard di mean distance

A differenza delle precedenti le *features giroscopiche* studiano diversi parametri partendo dai dati del giroscopio
* gyroscope mean -> valore medio del segnale del gyroscope negli assi x,y,z
* gyroscope range -> range del segnale del gyroscope negli assi x,y,z
* gyroscope variance -> varianza del segnale del gyroscope negli assi x,y,z
* gyroscope kurtosis -> indice di curtosi del segnale del gyroscope negli assi x,y,z
* gyroscope skewness -> indice d'asimmetria del segnale del gyroscope negli assi x,y,z