# Order Management Model
ESILV A4-S7 2023-2024  
Advence Database Management  
Enseignante : Fatima Zahra KAGHAT 


Project sur SQL*Plus via Oracle  
Les fichiers .csv téléchargé depuis DVL sont stocké dans `data/raw`  
Le fichier `data\clean.py` nettoie ces fichiers puis les stocke dans `data`

Pour initialiser sur cmd (ou PowerShell): `call init.bat`  
Fichier `table_creation.sql` crée les tables
Fichers SQL*Loader dans `sqlldr` import les data clean dans ces tables  
Les fichier .log et .bad crées au passage sont sotcké dans `sqlldr/log`

Fichier `role_creation.sql` crée un user 'ruben' qui peut utiliser SQL*Loader  
Fichier `table_drop.sql` supprime toutes les données  pour simplifier le debuggage

[Lien GitHub](https://github.com/ruben-adhesif/Order_Management.git) : 
- Ruben LEON DIA1 CDOF4 @ruben_adhesif  
- Ntsoa RANDRIA DIA6 CDOF4 @RandriaNtsoa28  