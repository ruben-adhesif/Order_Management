# Order Management Model
Ruben LEON DIA1 CDOF4   
Ntsoa RANDRIA DIA? CDOF4
ESILV A4-S7 2023-2024  
Advence Database Management

Project sur SQL*Plus via Oracle  
Les fichiers .csv téléchargé depuis DVL sont stocké dans `data/raw`
Le fichier `data\clean.py` nettoie ces fichiers puis les stocke dans `data`

Pour initialiser sur cmd (ou PowerShell): `call init.bat`
Fichier `table_creation.sql` crée les tables
Fichers SQL*Loader dans `sqlldr` import les data clean dans ces tables
Les fichier .log et .bad crées au passage sont sotcké dans `sqlldr/log`

Fichier `table_drop.sql` supprime toutes les données  pour simplifier le debuggage
Il n'est pas voué à être executé dans le processus normal d'utilisation

Lien GitHub : 
- @ruben_adhesif
- @RandriaNtsoa28