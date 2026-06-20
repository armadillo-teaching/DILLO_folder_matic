# DILLO_folder_matic
Script per la generazione di un sistema di cartelle che ospiterà gli strumenti di sviluppo ARM

# **Guida alla Creazione dell'Ambiente Embedded Portatile su USB**

Questa guida illustra come preparare una chiavetta USB (o una qualunque cartella nel PC) per ospitare un ambiente di sviluppo C/C++ ARM bare-metal e di debugging (GigaDevice Embedded Builder, GCC, MSYS2, Geany, OpenOCD, Ozone, GDB e Comandi CLI di Gigadevice) totalmente indipendente dal PC host Windows\.

## **1\. Preparazione del File System**

Formatta la partizione della chiavetta USB in **exFAT**. A differenza di NTFS, exFAT non gestisce i permessi di sicurezza utente di Windows. Questo garantisce che qualsiasi utente su qualsiasi PC possa leggere/scrivere i file senza incorrere in errori di "Accesso Negato".

## **2\. Architettura delle Directory**

Lo script Setup\_USB.bat creerà questa struttura nella root della chiavetta:  
X:\\ (Root USB)  
├── Apps\\  
│   ├── EmbeddedBuilder\\  (IDE GigaDevice)  
│   ├── gcc-arm\\          (Toolchain ARM GCC \- include GDB)  
│   ├── Geany\\            (Editor Geany)  
│   ├── msys64\\           (Ambiente MSYS2)  
│   ├── OpenOCD\\          (Server di Debug)  
│   ├── Ozone\\            (Debugger SEGGER)  
│   ├── SimplySerial\\     (Simple Uart communication consolle)  
│   └── GD32_ISP_CLI\\     (Shell Commands GIGADEVICE)
├── Configs\\  
│   ├── Geany\_Config\\     (Impostazioni Geany)  
│   ├── MSYS2\_Home\\       (Cartella Home condivisa)  
│   └── Ozone\_Config\\     (Impostazioni e Layout J-Link/Ozone)  
├── Workspace\\            (I tuoi progetti codice)  
├── Lancia\_EmbeddedBuilder.bat  
├── Lancia\_Geany.bat  
├── Lancia\_MSYS2.bat  
├── Lancia\_Cmd.bat  
└── Lancia\_Ozone.bat

## **3\. Popolamento delle Applicazioni (Fase Manuale)**

Prima di usare i launcher, devi scaricare ed estrarre i software nelle rispettive cartelle all'interno di Apps\\. Usa **7-Zip** per tutte le estrazioni.

### **A. Toolchain ARM GCC & GDB (Apps\\gcc-arm)**

1. Scarica la toolchain *Arm GNU Toolchain per Windows* (es. arm-gnu-toolchain-x.x.x-mingw-w64-i686-arm-none-eabi.zip) in formato **ZIP**.  
2. Estrai il contenuto dentro Apps\\gcc-arm.  
3. Il file eseguibile arm-none-eabi-gcc.exe e il debugger arm-none-eabi-gdb.exe si troveranno in Apps\\gcc-arm\\bin. **GDB è già configurato nel PATH globale di tutti i launcher.**

### **B. MSYS2 (Apps\\msys64)**

1. Scarica l'archivio base standalone .tar.xz dal sito MSYS2 (no installer).  
2. Estrai l'archivio dentro Apps\\msys64.  
3. **Inizializzazione (Solo la prima volta):** Avvia Apps\\msys64\\msys2\_shell.cmd, poi digita:  
   pacman \-Syu  
   pacman \-S make nano
   pacman \-S mingw-w64-ucrt-x86_64-putty

4. Chiudi la finestra.

### **C. Geany (Apps\\Geany)**

1. Scarica la versione **Binary (ZIP)** di Geany per Windows.  
2. Estrai tutto in Apps\\Geany.

### **D. GigaDevice Embedded Builder (Apps\\EmbeddedBuilder)**

1. Scarica lo zip di Embedded Builder e estrai il contenuto in Apps\\EmbeddedBuilder.

### **E. OpenOCD (Apps\\OpenOCD)**

1. Scarica una release precompilata di OpenOCD per Windows (ad esempio da *xPack OpenOCD* via GitHub) in formato zip.  
2. Estrai i file all'interno di Apps\\OpenOCD.  
3. Assicurati che l'eseguibile risieda nel percorso Apps\\OpenOCD\\bin\\openocd.exe. *OpenOCD verrà iniettato automaticamente nel PATH di Geany e MSYS2 per poterlo richiamare da riga di comando o dai Makefile.*

### **F. SEGGER Ozone (Apps\\Ozone)**

1. Scarica il pacchetto Windows dal sito ufficiale SEGGER. Spesso viene fornito come installer (.exe).  
2. Puoi estrarre i file dall'installer direttamente usando **7-Zip** e copiarli in Apps\\Ozone. In alternativa, installalo temporaneamente sul tuo PC host e copia il contenuto della cartella C:\\Program Files\\SEGGER\\Ozone dentro Apps\\Ozone.  
3. Assicurati di avere l'eseguibile in Apps\\Ozone\\Ozone.exe.

### **G. SimplySerial (Apps\\SimplySerial)**

1. Scarica il pacchetto Windows di 'SimplySerial_x.x.x_standalone.zip' dal sito Github (**https://github.com/fasteddy516/SimplySerial/releases**).  
2. Puoi estrarre i file dal pacchetto usando **7-Zip** e copiarli in Apps\\SimplySerial.  
3. Assicurati di avere l'eseguibile in Apps\\SimplySerial\\ss.exe.

### **H. Gigadevice Command Line Tools (Apps\\GD32_ISP_CLI)**
1. Scarica il pacchetto **GD32_ISP_CLI(Windows)_V5.1.0.39034.7z** dal sito ufficiale Gigadevice
2. Puoi estrarre i file dal pacchetto usando **7-Zip**
3. Assicurati di avere i comandi batch e l'eseguibile "GD32_ISP_CLI.exe" in Apps\\GD32_ISP_CLI

## **4\. Come usare i Launcher**

Usa **sempre** i file .bat presenti nella root per avviare i programmi in modo che siano portatili e non "sporchino" il PC:

* **Lancia\_MSYS2.bat**: Apre una console MINGW64. Le applicazioni gcc, gdb, openocd, simplyserial e geany sono disponibili da qualsiasi posizione.  
* **Lancia\_Cmd.bat**: Apre una console CMD di Windows. Le applicazioni gcc, gdb, openocd, simplyserial e geany sono disponibili da qualsiasi posizione.  
* **Lancia\_Geany.bat**: Apre Geany con configurazione in Configs\\Geany\_Config. Dai tool di build vedrà nativamente GCC, GDB, Make e OpenOCD.  
* **Lancia\_EmbeddedBuilder.bat**: Avvia l'IDE Eclipse-based forzando il Workspace sulla chiavetta e ignorando %APPDATA%.  
* **Lancia\_Ozone.bat**: Avvia il debugger Ozone. Questo script intercetta e sovrascrive le variabili Windows (USERPROFILE, APPDATA, LOCALAPPDATA) facendole puntare a Configs\\Ozone\_Config. Così facendo, le licenze, i layout di visualizzazione e i recent project file J-Link verranno salvati tutti sulla chiavetta\!
