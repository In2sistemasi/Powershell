# Kolekcija Windows 10 skripta

## Overview

Kolekcija za outomatsko čišćenje Windows 10 Pro 64bit nakon instalacije.

### Disable *Cortana*

    > cortana_disable.bat
	
Onemogući cortanu.

### Remove *OneDrive*

	> onedrive_remove.bat

Onemogući i makne (preinstalled) *OneDrive*. 

### List packages

    > pckg_list.bat
	
Pregled svih instaliranih Windows (modern app) packages.

    > pckg_list.bat name
	
Pregled svih instaliranih Windows (modern app) packages, pretraga po imenu (case-insensitive).

### Remove packages

    > pckg_remove.bat name
	
Makne sve aplikacije. Može se koristit Multiple name.
Aplikacije se više ne pojavljuju kod kreiranja novog usera.

### Clean up *This PC* folders

    remove_This_PC_folders_64bit.reg
	
Briše sve shorcut u *This PC* u Windows exploreru. - VRLO KORISNO :)

### Install a fully working *winhlp32* program on Win10

    fix_winhlp32.cmd

Instalira Widows Help program

