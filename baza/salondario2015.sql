drop database if exists salondario;
create database salondario character set utf8 
collate utf8_general_ci;
use salondario;

create table zaposlenik(
sifra					int not null primary key auto_increment,
osoba					int not null,
nadredeni				int,
radnomjesto				varchar(50) not null,
datumunosa 				datetime not null,
datumpromjene           datetime not null,
operater 				int not null
)engine=innodb;

create table osoba(
sifra					int not null primary key auto_increment,
oib						char(11) not null,
ime						varchar(50) not null,
prezime					varchar(50) not null,
adresa					varchar(50),
mjesto					int,
telefon					varchar(50),
mobitel					varchar(50) not null,
email					varchar(255) not null,
slika					varchar(255)
)engine=innodb;

create table mjesto(
sifra					int not null primary key auto_increment,
naselje					varchar(50) not null,
postanskibroj			char(5) not null,
opcina					varchar(50) not null,
zupanija				varchar(50) not null,
datumunosa 				datetime not null,
datumpromjene           datetime not null,
operater 				int not null
)engine=innodb;

create table narudzba(
sifra					int not null primary key auto_increment,
zaposlenik				int,
klijent					int not null,
pas						int not null,
datumnarudzbe			date not null,
termin					varchar(50) not null,
dan						varchar(50) not null,
status					boolean not null,
napomena				varchar(50),
datumunosa 				datetime not null,
datumpromjene           datetime not null,
operater 				int not null
)engine=innodb;

create table usluga(
sifra					int not null primary key auto_increment,
naziv					varchar(50) not null,			
cijena					decimal(18,2),
datumunosa 				datetime not null,
datumpromjene           datetime not null,
operater 				int not null
)engine=innodb;

create table klijent(
sifra					int not null primary key auto_increment,
osoba					int not null,
datumunosa 				datetime not null,
datumpromjene           datetime not null,
operater 				int not null
)engine=innodb;

create table pas(
sifra					int not null primary key auto_increment,
ime						varchar(50) not null,
pasmina					int not null,
klijent					int not null,
slika					varchar(255),
datumunosa 				datetime not null,
datumpromjene           datetime not null,
operater 				int not null
)engine=innodb;

create table pasmina(
sifra					int not null primary key auto_increment,
naziv					varchar(50) not null,
slika					varchar(255),
datumunosa 				datetime not null,
datumpromjene           datetime not null,
operater 				int not null
)engine=innodb;

create table narudzba_usluga(
narudzba				int not null,
usluga					int not null,
cijena					decimal(18,2)
)engine=innodb;

create table operater(
sifra					int not null primary key auto_increment,
korisnickoime			varchar(20) not null,
lozinka					char(32) not null,
uloga 					varchar(50) not null,
aktivan 				boolean not null	
)engine=innodb;

-- VEZE
alter table zaposlenik add foreign key (nadredeni) references zaposlenik(sifra);
alter table zaposlenik add foreign key (osoba) references osoba(sifra);
alter table osoba add foreign key (mjesto) references mjesto(sifra);
alter table narudzba add foreign key (zaposlenik) references zaposlenik(sifra);
alter table narudzba add foreign key (klijent) references klijent(sifra);
alter table narudzba add foreign key (pas) references pas(sifra);
alter table narudzba_usluga add foreign key (narudzba) references narudzba(sifra);
alter table narudzba_usluga add foreign key (usluga) references usluga(sifra);
alter table klijent add foreign key (osoba) references osoba(sifra);
alter table pas add foreign key (klijent) references klijent(sifra);
alter table pas add foreign key (pasmina) references pasmina(sifra);

-- VANJSKI KLJUČEVI ZA OPERATERA
alter table zaposlenik add foreign key (operater) references operater(sifra);
alter table narudzba add foreign key (operater) references operater(sifra);
alter table usluga add foreign key (operater) references operater(sifra);
alter table klijent add foreign key (operater) references operater(sifra);
alter table pas add foreign key (operater) references operater(sifra);
alter table pasmina add foreign key (operater) references operater(sifra);

create unique index index_1 on operater(korisnickoime);
create unique index index_2 on osoba(oib);
create unique index index_3 on osoba(email);

-- OPERATER
#1
insert into operater (korisnickoime,lozinka,uloga,aktivan) values ('admin123',md5('admin123'),'administrator',true);
#2
insert into operater (korisnickoime,lozinka,uloga,aktivan) values ('admin',md5('admin'),'administrator',true);
#3
insert into operater (korisnickoime,lozinka,uloga,aktivan) values ('korisnik',md5('k'),'korisnik',true);
#4
insert into operater (korisnickoime,lozinka,uloga,aktivan) values ('tjakopec',md5('t'),'korisnik',true);


#(-- MJESTO
insert into mjesto(naselje,postanskibroj,opcina,zupanija,datumunosa,datumpromjene,operater) values
#1
('Ada',31214,'Laslovo','OSJEČKO-BARANJSKA',now(),now(),1),
#2
('Adamovec',10363,'Belovar','GRAD ZAGREB',now(),now(),1),
#3
('Adžamovci',35422,'Zapolje','BRODSKO-POSAVSKA',now(),now(),1),
#4
('Alaginci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5
('Alan',53271,'Krivi Put','LIČKO-SENJSKA',now(),now(),1),
#6
('Aleksinica',53212,'Klanac','LIČKO-SENJSKA',now(),now(),1),
#7
('Alilovci',34334,'Kaptol','POŽEŠKO-SLAVONSKA',now(),now(),1),
#8
('Aljmaš',31205,'Aljmaš','OSJEČKO-BARANJSKA',now(),now(),1),
#9
('Amatovci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#10
('Andigola',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#11
('Andraševec',49243,'Oroslavje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#12
('Andrijaševci',32271,'Rokovci Andrijaševci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#13
('Andrijevac',31224,'Koška','OSJEČKO-BARANJSKA',now(),now(),1),
#14
('Andrilovec',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#15
('Antenal',52466,'Novigrad (Cittanova)','ISTARSKA',now(),now(),1),
#16
('Antin',32214,'Tordinci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#17
('Antolovec',48317,'Legrad','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#18
('Antonci',52446,'Nova Vas','ISTARSKA',now(),now(),1),
#19
('Antonci',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#20
('Antovo',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#21
('Antunovac',31216,'Antunovac','OSJEČKO-BARANJSKA',now(),now(),1),
#22
('Antunovac',34330,'Velika','POŽEŠKO-SLAVONSKA',now(),now(),1),
#23
('Antunovac',34543,'Poljana','POŽEŠKO-SLAVONSKA',now(),now(),1),
#24
('Anžići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#25
('Apatija',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#26
('Apatovec',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#27
('Apševci',32246,'Lipovac','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#28
('Arapovac',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#29
('Arbanija',21224,'Slatine','SPLITSKO-DALMATINSKA',now(),now(),1),
#30
('Aržano',21246,'Aržano','SPLITSKO-DALMATINSKA',now(),now(),1),
#31
('Ašikovci',34312,'Sesvete (kod Požege)','POŽEŠKO-SLAVONSKA',now(),now(),1),
#32
('Auguštanovec',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#33
('Babići',52464,'Kaštelir (Castelliere)','ISTARSKA',now(),now(),1),
#34
('Babići',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#35
('Babina Greda',32276,'Babina Greda','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#36
('Babina Rijeka',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#37
('Babinac',43232,'Berek','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#38
('Babinac',43273,'Bulinac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#39
('Babindub',23000,'Zadar','ZADARSKA',now(),now(),1),
#40
('Babine Kuće',20226,'Goveđari','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#41
('Babinec',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#42
('Babino Polje',20225,'Babino Polje','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#43
('Babotok',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#44
('Babudri',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#45
('Bačevac',33411,'Gradina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#46
('Bačići',51242,'Drivenik','PRIMORSKO-GORANSKA',now(),now(),1),
#47
('Bačkovica',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#48
('Bačva',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#49
('Baćin',44450,'Hrvatska Dubica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#50
('Baćin Dol',35404,'Cernik','BRODSKO-POSAVSKA',now(),now(),1),
#51
('Baćina',20340,'Ploče','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#52
('Badanj',22320,'Drniš','ŠIBENSKO-KNINSKA',now(),now(),1),
#53
('Baderna',52445,'Baderna','ISTARSKA',now(),now(),1),
#54
('Badličan',40306,'Macinec','MEĐIMURSKA',now(),now(),1),
#55
('Badljevina',34552,'Badljevina','POŽEŠKO-SLAVONSKA',now(),now(),1),
#56
('Badovinci',47284,'Kašt','KARLOVAČKA',now(),now(),1),
#57
('Badžula',20353,'Mlinište','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#58
('Bađinec',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#59
('Bair',44330,'Novska','SISAČKO-MOSLAVAČKA',now(),now(),1),
#60
('Bajagić',21241,'Obrovac Sinjski','SPLITSKO-DALMATINSKA',now(),now(),1),
#61
('Bajčići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#62
('Bajići',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#63
('Bajkini',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#64
('Bakar',51222,'Bakar','PRIMORSKO-GORANSKA',now(),now(),1),
#65
('Bakarac',51261,'Bakarac','PRIMORSKO-GORANSKA',now(),now(),1),
#66
('Bakar-dio (Sveti Kuzam)',51223,'Škrljevo','PRIMORSKO-GORANSKA',now(),now(),1),
#67
('Bakić',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#68
('Bakovčice',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#69
('Baldaši',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#70
('Bale',52211,'Bale (Valle)','ISTARSKA',now(),now(),1),
#71
('Balići',52341,'Žminj','ISTARSKA',now(),now(),1),
#72
('Balići II',52207,'Barban','ISTARSKA',now(),now(),1),
#73
('Balinac',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#74
('Balinci',33517,'Mikleuš','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#75
('Baljci',22322,'Ružić','ŠIBENSKO-KNINSKA',now(),now(),1),
#76
('Bandino Selo',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#77
('Banfi',40312,'Štrigova','MEĐIMURSKA',now(),now(),1),
#78
('Baničevec',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#79
('Banićevac',35404,'Cernik','BRODSKO-POSAVSKA',now(),now(),1),
#80
('Banići',20232,'Slano','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#81
('Banki',52445,'Baderna','ISTARSKA',now(),now(),1),
#82
('Bankovci',33513,'Zdenci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#83
('Bankovci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#84
('Banova Jaruga',44321,'Banova Jaruga','SISAČKO-MOSLAVAČKA',now(),now(),1),
#85
('Banovci',35254,'Bebrina','BRODSKO-POSAVSKA',now(),now(),1),
#86
('Banovci',32247,'Banovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#87
('Banovina',51323,'Lič','PRIMORSKO-GORANSKA',now(),now(),1),
#88
('Banovo',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#89
('Banska Gorica',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#90
('Banska Selnica',47212,'Skakavac','KARLOVAČKA',now(),now(),1),
#91
('Banski Kovačevac',47206,'Lasinja','KARLOVAČKA',now(),now(),1),
#92
('Banski Moravci',47212,'Skakavac','KARLOVAČKA',now(),now(),1),
#93
('Banšćica',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#94
('Banj',23263,'Ždrelac','ZADARSKA',now(),now(),1),
#95
('Banja',20344,'Komin (Dalma)','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#96
('Banja',21276,'Vrgorac','SPLITSKO-DALMATINSKA',now(),now(),1),
#97
('Banje Selo',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#98
('Banjevci',23422,'Stankovci','ZADARSKA',now(),now(),1),
#99
('Banjol',51280,'Rab','PRIMORSKO-GORANSKA',now(),now(),1),
#100
('Banjole',52100,'Pula (Pola)','ISTARSKA',now(),now(),1),
#101
('Banjsko Selo',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#102
('Bapče',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#103
('Bapska',32235,'Bapska','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#104
('Baranjsko Petrovo Selo',31322,'Baranjsko Petrovo Selo','OSJEČKO-BARANJSKA',now(),now(),1),
#105
('Barat',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#106
('Barat',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#107
('Barban',52207,'Barban','ISTARSKA',now(),now(),1),
#108
('Barbarići Kravarski',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#109
('Barbat na Rabu',51280,'Rab','PRIMORSKO-GORANSKA',now(),now(),1),
#110
('Barbići',52220,'Labin','ISTARSKA',now(),now(),1),
#111
('Barci',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#112
('Baredine',52420,'Buzet','ISTARSKA',now(),now(),1),
#113
('Baredine',52460,'Buje (Buie)','ISTARSKA',now(),now(),1),
#114
('Baretići',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#115
('Barica',43541,'Sirač','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#116
('Barić Draga',53289,'Lukovo Šugarje','LIČKO-SENJSKA',now(),now(),1),
#117
('Barići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#118
('Barilović',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#119
('Barkovići',47201,'Draganići','KARLOVAČKA',now(),now(),1),
#120
('Barlabaševec',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#121
('Barlete',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#122
('Barotul',23262,'Pašman','ZADARSKA',now(),now(),1),
#123
('Barovka',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#124
('Bartići',52220,'Labin','ISTARSKA',now(),now(),1),
#125
('Bartolići',52427,'Livade (Levade)','ISTARSKA',now(),now(),1),
#126
('Bartolovci',35252,'Sibinj','BRODSKO-POSAVSKA',now(),now(),1),
#127
('Bartolovec',42202,'Trnovec Bartolovečki','VARAŽDINSKA',now(),now(),1),
#128
('Bartolovići',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#129
('Barušići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#130
('Barušići',52420,'Buzet','ISTARSKA',now(),now(),1),
#131
('Basara',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#132
('Bast',21320,'Baška Voda','SPLITSKO-DALMATINSKA',now(),now(),1),
#133
('Bastajski Brđani',43531,'Veliki Bastaji','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#134
('Bašana',23250,'Pag','ZADARSKA',now(),now(),1),
#135
('Bašanija',52475,'Savudrija (Salvore)','ISTARSKA',now(),now(),1),
#136
('Bašarinka',52449,'Červar Porat','ISTARSKA',now(),now(),1),
#137
('Baška',51523,'Baška','PRIMORSKO-GORANSKA',now(),now(),1),
#138
('Baška Voda',21320,'Baška Voda','SPLITSKO-DALMATINSKA',now(),now(),1),
#139
('Baške Oštarije',53206,'Brušane','LIČKO-SENJSKA',now(),now(),1),
#140
('Baškoti',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#141
('Baštijani',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#142
('Bašunje Male',51243,'Tribalj','PRIMORSKO-GORANSKA',now(),now(),1),
#143
('Bašunje Vele',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#144
('Bater',51251,'Ledenice','PRIMORSKO-GORANSKA',now(),now(),1),
#145
('Batina',31306,'Batina','OSJEČKO-BARANJSKA',now(),now(),1),
#146
('Batina',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#147
('Batinova Kosa',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#148
('Batinske',48361,'Kalinovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#149
('Batinjani',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#150
('Batinjani',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#151
('Batinjska Rijeka',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#152
('Batlug',52341,'Žminj','ISTARSKA',now(),now(),1),
#153
('Batnoga',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#154
('Batomalj',51523,'Baška','PRIMORSKO-GORANSKA',now(),now(),1),
#155
('Batrina',35410,'Nova Kapela','BRODSKO-POSAVSKA',now(),now(),1),
#156
('Baturi',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#157
('Bazgalji',52000,'Pazin','ISTARSKA',now(),now(),1),
#158
('Bazli',51307,'Prezid','PRIMORSKO-GORANSKA',now(),now(),1),
#159
('Bebrina',35254,'Bebrina','BRODSKO-POSAVSKA',now(),now(),1),
#160
('Beč',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#161
('Bečic',35250,'Oriovac','BRODSKO-POSAVSKA',now(),now(),1),
#162
('Bedekovčina',49221,'Bedekovčina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#163
('Bedenec',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#164
('Bedenica',10381,'Bedenica','ZAGREBAČKA',now(),now(),1),
#165
('Bedenička',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#166
('Bedenik',43273,'Bulinac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#167
('Beder',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#168
('Bednja',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#169
('Bednjica',42255,'Donja Višnjica','VARAŽDINSKA',now(),now(),1),
#170
('Begi',52450,'Vrsar (Orsera)','ISTARSKA',now(),now(),1),
#171
('Begluci',23445,'Srb','ZADARSKA',now(),now(),1),
#172
('Begovac Plaščanski',47306,'Saborsko','KARLOVAČKA',now(),now(),1),
#173
('Begovača',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#174
('Begovići',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#175
('Begovo Brdo',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#176
('Begovo Brdo Žumberačko',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#177
('Begovo Razdolje',51315,'Mrkopalj','PRIMORSKO-GORANSKA',now(),now(),1),
#178
('Beketinci',31403,'Vuka','OSJEČKO-BARANJSKA',now(),now(),1),
#179
('Beketinec',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#180
('Bektež',34343,'Bektež','POŽEŠKO-SLAVONSKA',now(),now(),1),
#181
('Bela',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#182
('Bela Gorica',10293,'Dubravica','ZAGREBAČKA',now(),now(),1),
#183
('Bela Vodica',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#184
('Belaj',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#185
('Belaj',52434,'Boljun','ISTARSKA',now(),now(),1),
#186
('Belajska Vinica',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#187
('Belajske Poljice',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#188
('Belajski Malinci',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#189
('Belanovo Selo',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#190
('Belavići',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#191
('Belavići',52207,'Barban','ISTARSKA',now(),now(),1),
#192
('Belčići',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#193
('Belec',49254,'Belec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#194
('Belej',51555,'Belej','PRIMORSKO-GORANSKA',now(),now(),1),
#195
('Beletinec',42214,'Sveti Ilija','VARAŽDINSKA',now(),now(),1),
#196
('Belgrad',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#197
('Beli',51559,'Beli','PRIMORSKO-GORANSKA',now(),now(),1),
#198
('Beli Manastir',31300,'Beli Manastir','OSJEČKO-BARANJSKA',now(),now(),1),
#199
('Belica',40319,'Belica','MEĐIMURSKA',now(),now(),1),
#200
('Belinsko Selo',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#201
('Belišće',31551,'Belišće','OSJEČKO-BARANJSKA',now(),now(),1),
#202
('Belo',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#203
('Belo Selo',51322,'Fužine','PRIMORSKO-GORANSKA',now(),now(),1),
#204
('Belobrajići',51243,'Tribalj','PRIMORSKO-GORANSKA',now(),now(),1),
#205
('Beloslavec',10381,'Bedenica','ZAGREBAČKA',now(),now(),1),
#206
('Belošići',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#207
('Belovar',10363,'Belovar','GRAD ZAGREB',now(),now(),1),
#208
('Belovar Zlatarski',49228,'Brestovec Orehovički','KRAPINSKO-ZAGORSKA',now(),now(),1),
#209
('Belski Ravan',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#210
('Beljevina',31511,'Đurđenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#211
('Bencani',52428,'Oprtalj (Portole)','ISTARSKA',now(),now(),1),
#212
('Bencetići',47201,'Draganići','KARLOVAČKA',now(),now(),1),
#213
('Benčani',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#214
('Benčići',52425,'Roč','ISTARSKA',now(),now(),1),
#215
('Benčići',52341,'Žminj','ISTARSKA',now(),now(),1),
#216
('Beničanci',31542,'Magadenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#217
('Benići',51260,'Crikvenica','PRIMORSKO-GORANSKA',now(),now(),1),
#218
('Benići Drivenički',51242,'Drivenik','PRIMORSKO-GORANSKA',now(),now(),1),
#219
('Benkovac',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#220
('Benkovac',23420,'Benkovac','ZADARSKA',now(),now(),1),
#221
('Benkovac Fužinski',51322,'Fužine','PRIMORSKO-GORANSKA',now(),now(),1),
#222
('Benkovačko Selo',23420,'Benkovac','ZADARSKA',now(),now(),1),
#223
('Benkovec',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#224
('Benkovec Petrovski',49234,'Petrovsko','KRAPINSKO-ZAGORSKA',now(),now(),1),
#225
('Benkovići',51242,'Drivenik','PRIMORSKO-GORANSKA',now(),now(),1),
#226
('Benkovo',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#227
('Berak',32243,'Orolik','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#228
('Beram',52000,'Pazin','ISTARSKA',now(),now(),1),
#229
('Beravci',35221,'Velika Kopanica','BRODSKO-POSAVSKA',now(),now(),1),
#230
('Berek',43232,'Berek','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#231
('Beretinec',42201,'Beretinec','VARAŽDINSKA',now(),now(),1),
#232
('Berislavec',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#233
('Bertelovci',34308,'Jakšić','POŽEŠKO-SLAVONSKA',now(),now(),1),
#234
('Bertoši',52000,'Pazin','ISTARSKA',now(),now(),1),
#235
('Bestovje',10437,'Bestovje','ZAGREBAČKA',now(),now(),1),
#236
('Bestrma',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#237
('Bešinci',34334,'Kaptol','POŽEŠKO-SLAVONSKA',now(),now(),1),
#238
('Bešlinec',10312,'Kloštar Ivanić','ZAGREBAČKA',now(),now(),1),
#239
('Beter',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#240
('Betina',22244,'Betina','ŠIBENSKO-KNINSKA',now(),now(),1),
#241
('Bezavina/dio/ (1-25)',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#242
('Bezavina/dio/ 26-dalje',49214,'Veliko Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#243
('Bibali',52460,'Buje (Buie)','ISTARSKA',now(),now(),1),
#244
('Bibići',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#245
('Bibinje',23205,'Bibinje','ZADARSKA',now(),now(),1),
#246
('Bicko Selo',35212,'Garčin','BRODSKO-POSAVSKA',now(),now(),1),
#247
('Bičići',52207,'Barban','ISTARSKA',now(),now(),1),
#248
('Bičine',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#249
('Bijela',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#250
('Bijela Loza',31433,'Podgorač','OSJEČKO-BARANJSKA',now(),now(),1),
#251
('Bijela Stijena',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#252
('Bijele Vode',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#253
('Bijele Zemlje',52429,'Grožnjan (Grisignana)','ISTARSKA',now(),now(),1),
#254
('Bijeli Klanac',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#255
('Bijeli Vir',20353,'Mlinište','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#256
('Bijelnik',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#257
('Bijelo Brdo',31204,'Bijelo Brdo','OSJEČKO-BARANJSKA',now(),now(),1),
#258
('Bijeljevina Orahovička',33515,'Orahovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#259
('Bikovec',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#260
('Bila Vlaka',23422,'Stankovci','ZADARSKA',now(),now(),1),
#261
('Bilaj',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#262
('Bile',51252,'Klenovica','PRIMORSKO-GORANSKA',now(),now(),1),
#263
('Bili Brig',35410,'Nova Kapela','BRODSKO-POSAVSKA',now(),now(),1),
#264
('Bilice',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#265
('Bilice',22000,'Šibenik','ŠIBENSKO-KNINSKA',now(),now(),1),
#266
('Bilišane',23450,'Obrovac','ZADARSKA',now(),now(),1),
#267
('Bilo',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#268
('Bilje',31327,'Bilje','OSJEČKO-BARANJSKA',now(),now(),1),
#269
('Biljevec',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#270
('Biljevina',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#271
('Biljevine',53284,'Sveti Juraj','LIČKO-SENJSKA',now(),now(),1),
#272
('Biočić',22321,'Siverić','ŠIBENSKO-KNINSKA',now(),now(),1),
#273
('Biograd na moru',23210,'Biograd na moru','ZADARSKA',now(),now(),1),
#274
('Biokovsko Selo',21270,'Zagvozd','SPLITSKO-DALMATINSKA',now(),now(),1),
#275
('Biorine',21244,'Cista Velika','SPLITSKO-DALMATINSKA',now(),now(),1),
#276
('Biovičino Selo',22305,'Kistanje','ŠIBENSKO-KNINSKA',now(),now(),1),
#277
('Birovača',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#278
('Bisag',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#279
('Bisko',21232,'Dicmo','SPLITSKO-DALMATINSKA',now(),now(),1),
#280
('Biskupija',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#281
('Bistrač',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#282
('Bistrica',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#283
('Bistrinci',31551,'Belišće','OSJEČKO-BARANJSKA',now(),now(),1),
#284
('Bišćanovo',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#285
('Biševo',21485,'Komiža','SPLITSKO-DALMATINSKA',now(),now(),1),
#286
('Biškupci',34330,'Velika','POŽEŠKO-SLAVONSKA',now(),now(),1),
#287
('Biškupec Zelinski',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#288
('Bitorajci',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#289
('Bizovac',31222,'Bizovac','OSJEČKO-BARANJSKA',now(),now(),1),
#290
('Bjelajci',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#291
('Bjelajci',34553,'Bučje','POŽEŠKO-SLAVONSKA',now(),now(),1),
#292
('Bjelanovac',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#293
('Bjelina',23420,'Benkovac','ZADARSKA',now(),now(),1),
#294
('Bjeliševac',34340,'Kutjevo','POŽEŠKO-SLAVONSKA',now(),now(),1),
#295
('Bjelkovac',33518,'Nova Bukovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#296
('Bjelopolje',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#297
('Bjelovar',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#298
('Blaca',21210,'Solin','SPLITSKO-DALMATINSKA',now(),now(),1),
#299
('Blace',20357,'Blace','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#300
('Blacko',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#301
('Blagaj',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#302
('Blagdanići',52446,'Nova Vas','ISTARSKA',now(),now(),1),
#303
('Blagorodovac',43507,'Uljanik','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#304
('Blaguša',10362,'Kašina','GRAD ZAGREB',now(),now(),1),
#305
('Blanje',31540,'Donji Miholjac','OSJEČKO-BARANJSKA',now(),now(),1),
#306
('Blaškovec',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#307
('Blaškovići',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#308
('Blaškovići',52232,'Kršan','ISTARSKA',now(),now(),1),
#309
('Blata',47306,'Saborsko','KARLOVAČKA',now(),now(),1),
#310
('Blatna Vas',52425,'Roč','ISTARSKA',now(),now(),1),
#311
('Blatnica',43246,'Štefanje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#312
('Blatnica Pokupska',47204,'Šišljavić','KARLOVAČKA',now(),now(),1),
#313
('Blato',20271,'Blato','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#314
('Blato',20225,'Babino Polje','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#315
('Blato na Cetini',21254,'Blato na Cetini','SPLITSKO-DALMATINSKA',now(),now(),1),
#316
('Blatuša',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#317
('Blaževci',51328,'Lukovdol','PRIMORSKO-GORANSKA',now(),now(),1),
#318
('Blaževdol',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#319
('Blažević Dol',35414,'Vrbova','BRODSKO-POSAVSKA',now(),now(),1),
#320
('Blažići',51243,'Tribalj','PRIMORSKO-GORANSKA',now(),now(),1),
#321
('Blinja',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#322
('Blinjska Greda',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#323
('Blinjski Kut',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#324
('Blizna Donja',21228,'Blizna Donja','SPLITSKO-DALMATINSKA',now(),now(),1),
#325
('Blizna Gornja',21228,'Blizna Donja','SPLITSKO-DALMATINSKA',now(),now(),1),
#326
('Bobare',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#327
('Bobodol',22303,'Oklaj','ŠIBENSKO-KNINSKA',now(),now(),1),
#328
('Bobota',32225,'Bobota','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#329
('Bobovac',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#330
('Bobovec Rozganski',10293,'Dubravica','ZAGREBAČKA',now(),now(),1),
#331
('Bobovec Tomaševečki',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#332
('Bobovica',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#333
('Bobovišća',21404,'Ložišća','SPLITSKO-DALMATINSKA',now(),now(),1),
#334
('Bobovje',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#335
('Bocanjevci',31550,'Valpovo','OSJEČKO-BARANJSKA',now(),now(),1),
#336
('Bockovac',31540,'Donji Miholjac','OSJEČKO-BARANJSKA',now(),now(),1),
#337
('Bočadir',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#338
('Bočaki',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#339
('Bočkinci',31552,'Podgajci Podravski','OSJEČKO-BARANJSKA',now(),now(),1),
#340
('Bočkovec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#341
('Bodegraj',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#342
('Bodovaljci',35422,'Zapolje','BRODSKO-POSAVSKA',now(),now(),1),
#343
('Bogačevo',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#344
('Bogačevo Riječko',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#345
('Bogatić',22324,'Drinovci','ŠIBENSKO-KNINSKA',now(),now(),1),
#346
('Bogatić Prominski',22303,'Oklaj','ŠIBENSKO-KNINSKA',now(),now(),1),
#347
('Bogatnik',23450,'Obrovac','ZADARSKA',now(),now(),1),
#348
('Bogdanovci',32000,'Vukovar','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#349
('Bogdanovec',40306,'Macinec','MEĐIMURSKA',now(),now(),1),
#350
('Bogdanovići',21227,'Primorski Dolac','SPLITSKO-DALMATINSKA',now(),now(),1),
#351
('Bogdašići',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#352
('Bogomolje',21467,'Gdinj','SPLITSKO-DALMATINSKA',now(),now(),1),
#353
('Bogovci',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#354
('Bogovići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#355
('Bogovolja',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#356
('Bojačno',49296,'Zagorska Sela','KRAPINSKO-ZAGORSKA',now(),now(),1),
#357
('Bojana',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#358
('Bojna',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#359
('Bojnikovec',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#360
('Bok Palanječki',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#361
('Bokane',33522,'Voćin','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#362
('Bokordići',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#363
('Bokšić',31511,'Đurđenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#364
('Bokšić',32238,'Čakovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#365
('Bokšić Lug',31511,'Đurđenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#366
('Bol',21420,'Bol','SPLITSKO-DALMATINSKA',now(),now(),1),
#367
('Bolč',10344,'Farkaševac','ZAGREBAČKA',now(),now(),1),
#368
('Bolfan',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#369
('Bolman',31323,'Bolman','OSJEČKO-BARANJSKA',now(),now(),1),
#370
('Bolomače',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#371
('Boljenovići',20230,'Ston','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#372
('Boljevići',52232,'Kršan','ISTARSKA',now(),now(),1),
#373
('Boljun',52434,'Boljun','ISTARSKA',now(),now(),1),
#374
('Boljunsko Polje',52434,'Boljun','ISTARSKA',now(),now(),1),
#375
('Bonaci',52445,'Baderna','ISTARSKA',now(),now(),1),
#376
('Boraja',22206,'Boraja','ŠIBENSKO-KNINSKA',now(),now(),1),
#377
('Borak',21310,'Omiš','SPLITSKO-DALMATINSKA',now(),now(),1),
#378
('Borenec',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#379
('Boričevci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#380
('Boričevec Toplički',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#381
('Borićevac',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#382
('Borik',33517,'Mikleuš','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#383
('Borinići',52207,'Barban','ISTARSKA',now(),now(),1),
#384
('Boriš',43505,'Končanica (Končenice)','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#385
('Borje',48269,'Kalnik','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#386
('Borkovec',49250,'Zlatar','KRAPINSKO-ZAGORSKA',now(),now(),1),
#387
('Borojevci',31416,'Levanjska Varoš','OSJEČKO-BARANJSKA',now(),now(),1),
#388
('Borojevići',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#389
('Borova',33410,'Suhopolje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#390
('Borova Kosa',43531,'Veliki Bastaji','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#391
('Borovac',44323,'Rajić','SISAČKO-MOSLAVAČKA',now(),now(),1),
#392
('Borovci',20278,'Nova Sela','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#393
('Borovik',31418,'Drenje','OSJEČKO-BARANJSKA',now(),now(),1),
#394
('Borovik',21483,'Podšpilje','SPLITSKO-DALMATINSKA',now(),now(),1),
#395
('Borovita',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#396
('Borovljani',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#397
('Borovo',32227,'Borovo','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#398
('Borut',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#399
('Bosanci',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#400
('Bosanka',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#401
('Bosiljevo',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#402
('Bosiljevo',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#403
('Bosna',10381,'Bedenica','ZAGREBAČKA',now(),now(),1),
#404
('Boševci',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#405
('Boškari',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#406
('Bošnjaci',32275,'Bošnjaci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#407
('Bošt',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#408
('Botinac',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#409
('Botinec',10020,'Zagreb-Novi Zagreb','GRAD ZAGREB',now(),now(),1),
#410
('Botinovec',48311,'Kunovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#411
('Botovo',48322,'Drnje','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#412
('Bović',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#413
('Božava',23286,'Božava','ZADARSKA',now(),now(),1),
#414
('Božjakovina',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#415
('Bračak',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#416
('Bračevci',31423,'Bračevci','OSJEČKO-BARANJSKA',now(),now(),1),
#417
('Bračević',21206,'Donje Ogorje','SPLITSKO-DALMATINSKA',now(),now(),1),
#418
('Bračević',21203,'Donji Muć','SPLITSKO-DALMATINSKA',now(),now(),1),
#419
('Bradišće',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#420
('Brajakovo Brdo',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#421
('Brajdić Selo',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#422
('Brajkovići',52000,'Pazin','ISTARSKA',now(),now(),1),
#423
('Brajkovići',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#424
('Bralići',52450,'Vrsar (Orsera)','ISTARSKA',now(),now(),1),
#425
('Branešci',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#426
('Branimirovac',31224,'Koška','OSJEČKO-BARANJSKA',now(),now(),1),
#427
('Branjin Vrh',31301,'Branjin Vrh','OSJEČKO-BARANJSKA',now(),now(),1),
#428
('Branjina',31303,'Popovac','OSJEČKO-BARANJSKA',now(),now(),1),
#429
('Braslovje',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#430
('Brašina',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#431
('Brašljevica',47284,'Kašt','KARLOVAČKA',now(),now(),1),
#432
('Bratelji',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#433
('Bratina',10451,'Pisarovina','ZAGREBAČKA',now(),now(),1),
#434
('Bratiškovci',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#435
('Bratkovec',49296,'Zagorska Sela','KRAPINSKO-ZAGORSKA',now(),now(),1),
#436
('Bratovanci',47282,'Kamanje','KARLOVAČKA',now(),now(),1),
#437
('Bratovići',52445,'Baderna','ISTARSKA',now(),now(),1),
#438
('Bratovski Vrh',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#439
('Bratulići',52207,'Barban','ISTARSKA',now(),now(),1),
#440
('Bratuljevci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#441
('Bratuš',21320,'Baška Voda','SPLITSKO-DALMATINSKA',now(),now(),1),
#442
('Brbinj',23285,'Brbinj','ZADARSKA',now(),now(),1),
#443
('Brcković Draga',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#444
('Brckovljani',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#445
('Brčevec',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#446
('Brčići',52444,'Tinjan','ISTARSKA',now(),now(),1),
#447
('Brčići',52446,'Nova Vas','ISTARSKA',now(),now(),1),
#448
('Brčino',35252,'Sibinj','BRODSKO-POSAVSKA',now(),now(),1),
#449
('Brdce',51214,'Šapjane','PRIMORSKO-GORANSKA',now(),now(),1),
#450
('Brdo',52462,'Momjan (Momiano)','ISTARSKA',now(),now(),1),
#451
('Brdo Cirkvensko',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#452
('Brdo Jesenjsko',49233,'Gornje Jesenje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#453
('Brdo Orehovečko',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#454
('Brdo Utinjsko',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#455
('Brdovec',10291,'Prigorje Brdovečko','ZAGREBAČKA',now(),now(),1),
#456
('Brđani',35252,'Sibinj','BRODSKO-POSAVSKA',now(),now(),1),
#457
('Brđani',35422,'Zapolje','BRODSKO-POSAVSKA',now(),now(),1),
#458
('Brđani Cesta',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#459
('Brđani Dapčevački',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#460
('Brđani Kosa',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#461
('Brđani Sokolovački',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#462
('Brebernica',10257,'Brezovica','GRAD ZAGREB',now(),now(),1),
#463
('Brebornica',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#464
('Brebrovac',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#465
('Brečevići',52444,'Tinjan','ISTARSKA',now(),now(),1),
#466
('Brečići',20278,'Nova Sela','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#467
('Breg',52220,'Labin','ISTARSKA',now(),now(),1),
#468
('Breg Mokrički',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#469
('Bregana',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#470
('Bregana Pisarovinska',10451,'Pisarovina','ZAGREBAČKA',now(),now(),1),
#471
('Breganica',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#472
('Bregi',51211,'Matulji','PRIMORSKO-GORANSKA',now(),now(),1),
#473
('Bregi Kostelski',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#474
('Bregi Radobojski',49232,'Radoboj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#475
('Bregi Zabočki',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#476
('Bregovljana',10294,'Donja Pušća','ZAGREBAČKA',now(),now(),1),
#477
('Brekinska',34543,'Poljana','POŽEŠKO-SLAVONSKA',now(),now(),1),
#478
('Brela',21322,'Brela','SPLITSKO-DALMATINSKA',now(),now(),1),
#479
('Bresnica',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#480
('Brest',52420,'Buzet','ISTARSKA',now(),now(),1),
#481
('Brest pod Učkom',52426,'Lupoglav','ISTARSKA',now(),now(),1),
#482
('Brest Pokupski',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#483
('Brestača',44330,'Novska','SISAČKO-MOSLAVAČKA',now(),now(),1),
#484
('Brestik',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#485
('Brestova Draga',51315,'Mrkopalj','PRIMORSKO-GORANSKA',now(),now(),1),
#486
('Brestovac',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#487
('Brestovac Daruvarski',43505,'Končanica (Končenice)','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#488
('Brestovac Ogulinski',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#489
('Brestovačka Brda',43505,'Končanica (Končenice)','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#490
('Brestovec Orehovički',49228,'Brestovec Orehovički','KRAPINSKO-ZAGORSKA',now(),now(),1),
#491
('Brešca',51213,'Jurdani','PRIMORSKO-GORANSKA',now(),now(),1),
#492
('Breštane',53234,'Udbina','LIČKO-SENJSKA',now(),now(),1),
#493
('Breštanovci',33507,'Crnac','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#494
('Breza',51217,'Klana','PRIMORSKO-GORANSKA',now(),now(),1),
#495
('Breza',43252,'Prgomelje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#496
('Brezakovec',49296,'Zagorska Sela','KRAPINSKO-ZAGORSKA',now(),now(),1),
#497
('Brezani',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#498
('Brezari',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#499
('Brezarić',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#500
('Breze',51251,'Ledenice','PRIMORSKO-GORANSKA',now(),now(),1),
#501
('Brezik',33406,'Lukač','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#502
('Brezik',33518,'Nova Bukovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#503
('Brezik Našički',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#504
('Brezine',10344,'Farkaševac','ZAGREBAČKA',now(),now(),1),
#505
('Brezine',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#506
('Brezje',40311,'Lopatinec','MEĐIMURSKA',now(),now(),1),
#507
('Brezje',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#508
('Brezje',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#509
('Brezje Dobransko',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#510
('Brezje Dravsko',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#511
('Brezje Miholečko',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#512
('Brezje Samoborsko',10431,'Sveta Nedjelja','ZAGREBAČKA',now(),now(),1),
#513
('Brezje Vivodinsko',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#514
('Breznica',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#515
('Breznica Đakovačka',31416,'Levanjska Varoš','OSJEČKO-BARANJSKA',now(),now(),1),
#516
('Breznica Našička',31225,'Breznica Našička','OSJEČKO-BARANJSKA',now(),now(),1),
#517
('Breznički Hum',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#518
('Breznik',47281,'Mali Erjavec','KARLOVAČKA',now(),now(),1),
#519
('Breznik',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#520
('Breznik Plešivički',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#521
('Breznik Žakanjski',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#522
('Brezno Drežničko',47313,'Drežnica','KARLOVAČKA',now(),now(),1),
#523
('Brezno Gora',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#524
('Brezova',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#525
('Brezova Glava',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#526
('Brezova Gora',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#527
('Brezovac',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#528
('Brezovac',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#529
('Brezovac Dobroselski',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#530
('Brezovac Subocki',44330,'Novska','SISAČKO-MOSLAVAČKA',now(),now(),1),
#531
('Brezovac Žumberački',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#532
('Brezovec',40313,'Sveti Martin na Muri','MEĐIMURSKA',now(),now(),1),
#533
('Brezovec Zelinski',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#534
('Brezovica',10257,'Brezovica','GRAD ZAGREB',now(),now(),1),
#535
('Brezovica',31542,'Magadenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#536
('Brezovica',33411,'Gradina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#537
('Brezovica Petrovska',49234,'Petrovsko','KRAPINSKO-ZAGORSKA',now(),now(),1),
#538
('Brezovljani',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#539
('Brezovljani Vojlovički',33514,'Čačinci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#540
('Brezovo Polje',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#541
('Brežane Lekeničke',44272,'Lekenik','SISAČKO-MOSLAVAČKA',now(),now(),1),
#542
('Brežani',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#543
('Brežani',47212,'Skakavac','KARLOVAČKA',now(),now(),1),
#544
('Brgat Donji',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#545
('Brgat Gornji',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#546
('Brgod',52224,'Trget','ISTARSKA',now(),now(),1),
#547
('Brgud',23420,'Benkovac','ZADARSKA',now(),now(),1),
#548
('Brgudac',52422,'Lanišće','ISTARSKA',now(),now(),1),
#549
('Brgujac',21480,'Vis','SPLITSKO-DALMATINSKA',now(),now(),1),
#550
('Brgulje',23292,'Molat','ZADARSKA',now(),now(),1),
#551
('Bribir',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#552
('Bribir',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#553
('Brič',52462,'Momjan (Momiano)','ISTARSKA',now(),now(),1),
#554
('Bričanci',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#555
('Brig',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#556
('Brihovo',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#557
('Brijest',31000,'Osijek','OSJEČKO-BARANJSKA',now(),now(),1),
#558
('Brijesta',20246,'Janjina','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#559
('Briješće',31000,'Osijek','OSJEČKO-BARANJSKA',now(),now(),1),
#560
('Brinjani',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#561
('Brinje',53260,'Brinje','LIČKO-SENJSKA',now(),now(),1),
#562
('Brinjeva Draga',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#563
('Brist',21335,'Podaca','SPLITSKO-DALMATINSKA',now(),now(),1),
#564
('Bristivica',21228,'Blizna Donja','SPLITSKO-DALMATINSKA',now(),now(),1),
#565
('Briševo',23000,'Zadar','ZADARSKA',now(),now(),1),
#566
('Brištane',22324,'Drinovci','ŠIBENSKO-KNINSKA',now(),now(),1),
#567
('Brkač',52424,'Motovun (Montana)','ISTARSKA',now(),now(),1),
#568
('Brkiševina',44273,'Sela','SISAČKO-MOSLAVAČKA',now(),now(),1),
#569
('Brlekovo',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#570
('Brlenić',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#571
('Brlog',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#572
('Brlog Ozaljski',47282,'Kamanje','KARLOVAČKA',now(),now(),1),
#573
('Brloška Dubrava',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#574
('Brnaze',21230,'Sinj','SPLITSKO-DALMATINSKA',now(),now(),1),
#575
('Brnčići',51215,'Kastav','PRIMORSKO-GORANSKA',now(),now(),1),
#576
('Brnelići',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#577
('Brnobići',52464,'Kaštelir (Castelliere)','ISTARSKA',now(),now(),1),
#578
('Brnobići',52425,'Roč','ISTARSKA',now(),now(),1),
#579
('Brnjavac',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#580
('Brnjeuška',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#581
('Brnjica',22221,'Lozovac','ŠIBENSKO-KNINSKA',now(),now(),1),
#582
('Broce',20230,'Ston','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#583
('Bročice',44330,'Novska','SISAČKO-MOSLAVAČKA',now(),now(),1),
#584
('Broćanac',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#585
('Brod Moravice',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#586
('Brod na Kupi',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#587
('Brodarovec',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#588
('Brodić',48363,'Podravske Sesvete','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#589
('Brodski Stupnik',35253,'Brodski Stupnik','BRODSKO-POSAVSKA',now(),now(),1),
#590
('Brodski Zdenci',35201,'Podcrkavlje','BRODSKO-POSAVSKA',now(),now(),1),
#591
('Brodsko Vinogorje',35105,'Slavonski Brod','BRODSKO-POSAVSKA',now(),now(),1),
#592
('Brođanci',31223,'Brođanci','OSJEČKO-BARANJSKA',now(),now(),1),
#593
('Brođani',47212,'Skakavac','KARLOVAČKA',now(),now(),1),
#594
('Broskvari',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#595
('Brotnice',20210,'Cavtat','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#596
('Brotnja',23445,'Srb','ZADARSKA',now(),now(),1),
#597
('Brovinje',52222,'Koromačno','ISTARSKA',now(),now(),1),
#598
('Brseč',51418,'Brseč','PRIMORSKO-GORANSKA',now(),now(),1),
#599
('Brsećine',20233,'Trsteno','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#600
('Bršadin',32222,'Bršadin','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#601
('Brščići',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#602
('Brštanovo',21202,'Lećevica','SPLITSKO-DALMATINSKA',now(),now(),1),
#603
('Brtonigla',52474,'Brtonigla (Verteneglio)','ISTARSKA',now(),now(),1),
#604
('Brubno',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#605
('Brusići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#606
('Brusje',21454,'Brusje','SPLITSKO-DALMATINSKA',now(),now(),1),
#607
('Brusnik',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#608
('Brušane',53206,'Brušane','LIČKO-SENJSKA',now(),now(),1),
#609
('Bruška',23420,'Benkovac','ZADARSKA',now(),now(),1),
#610
('Bruvno',23440,'Gračac','ZADARSKA',now(),now(),1),
#611
('Brzac',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#612
('Bubani',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#613
('Bubnjarci',47282,'Kamanje','KARLOVAČKA',now(),now(),1),
#614
('Bubnjarski Brod',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#615
('Bucalovići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#616
('Bučje',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#617
('Bučje',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#618
('Bučje Gorjansko',31423,'Bračevci','OSJEČKO-BARANJSKA',now(),now(),1),
#619
('Budačka Rijeka',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#620
('Budak',53201,'Lički Osik','LIČKO-SENJSKA',now(),now(),1),
#621
('Budak',23422,'Stankovci','ZADARSKA',now(),now(),1),
#622
('Budakovac',33411,'Gradina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#623
('Budančevica',48362,'Kloštar Podravski','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#624
('Budanica',33412,'Cabuna','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#625
('Budaševo',44202,'Topolovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#626
('Budenec',10360,'Sesvete','GRAD ZAGREB',now(),now(),1),
#627
('Budim Vivodinski',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#628
('Budimci',31432,'Budimci','OSJEČKO-BARANJSKA',now(),now(),1),
#629
('Budimiri',21243,'Ugljane','SPLITSKO-DALMATINSKA',now(),now(),1),
#630
('Budinščak',42245,'Donja Voća','VARAŽDINSKA',now(),now(),1),
#631
('Budinščina',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#632
('Budinjak',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#633
('Budislavec',42205,'Vidovec','VARAŽDINSKA',now(),now(),1),
#634
('Budrovac',48350,'Đurđevac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#635
('Budrovac Lukački',33406,'Lukač','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#636
('Budrovci',47201,'Draganići','KARLOVAČKA',now(),now(),1),
#637
('Budrovci',31400,'Đakovo','OSJEČKO-BARANJSKA',now(),now(),1),
#638
('Buhača',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#639
('Buići',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#640
('Buići',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#641
('Bujarići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#642
('Bujavica',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#643
('Buje',52460,'Buje (Buie)','ISTARSKA',now(),now(),1),
#644
('Bujinja',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#645
('Bujinjski Riječani',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#646
('Buk',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#647
('Buk Vlaka',20355,'Opuzen','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#648
('Bukevje',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#649
('Bukevje',10411,'Orle','ZAGREBAČKA',now(),now(),1),
#650
('Bukori',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#651
('Bukov Vrh',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#652
('Bukova',33410,'Suhopolje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#653
('Bukovac Perjasički',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#654
('Bukovac Perušićki',53202,'Perušić','LIČKO-SENJSKA',now(),now(),1),
#655
('Bukovac Podvrški',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#656
('Bukovac Svetojanski',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#657
('Bukovački Antunovac',33517,'Mikleuš','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#658
('Bukovčak',10253,'Donji Dragonožec','GRAD ZAGREB',now(),now(),1),
#659
('Bukovčani',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#660
('Bukovec',40314,'Selnica','MEĐIMURSKA',now(),now(),1),
#661
('Bukovec Zelinski',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#662
('Bukovica',35403,'Rešetari','BRODSKO-POSAVSKA',now(),now(),1),
#663
('Bukovica',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#664
('Bukovica Prekriška',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#665
('Bukovica Utinjska',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#666
('Buković',23420,'Benkovac','ZADARSKA',now(),now(),1),
#667
('Bukovje Bistransko',10298,'Donja Bistra','ZAGREBAČKA',now(),now(),1),
#668
('Bukovje Križevačko',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#669
('Bukovje Podvrško',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#670
('Bukovlje',35209,'Bukovlje','BRODSKO-POSAVSKA',now(),now(),1),
#671
('Bukovlje Netretičko',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#672
('Bukvik',33514,'Čačinci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#673
('Bulić',23420,'Benkovac','ZADARSKA',now(),now(),1),
#674
('Bulići',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#675
('Bulinac',43273,'Bulinac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#676
('Bunić',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#677
('Bunjak',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#678
('Bunjani',10314,'Križ','ZAGREBAČKA',now(),now(),1),
#679
('Bunjevci',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#680
('Burić Selo',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#681
('Burići',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#682
('Buroli',52474,'Brtonigla (Verteneglio)','ISTARSKA',now(),now(),1),
#683
('Busnovi',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#684
('Bušetina',33404,'Špišić Bukovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#685
('Buševec',10417,'Buševec','ZAGREBAČKA',now(),now(),1),
#686
('Bušević',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#687
('Bušin',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#688
('Butkovec',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#689
('Butkovići',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#690
('Butoniga',52000,'Pazin','ISTARSKA',now(),now(),1),
#691
('Buzadovac',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#692
('Buzdohanj',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#693
('Buzet',52420,'Buzet','ISTARSKA',now(),now(),1),
#694
('Buzeta',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#695
('Buzin',10010,'Zagreb-Sloboština','GRAD ZAGREB',now(),now(),1),
#696
('Buzin',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#697
('Bužim',53211,'Smiljan','LIČKO-SENJSKA',now(),now(),1),
#698
('Bužinija',52466,'Novigrad (Cittanova)','ISTARSKA',now(),now(),1),
#699
('Bzenica',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#700
('Cabuna',33412,'Cabuna','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#701
('Cage',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#702
('Caginec',10313,'Graberje Ivaničko','ZAGREBAČKA',now(),now(),1),
#703
('Cancini',52446,'Nova Vas','ISTARSKA',now(),now(),1),
#704
('Careva Draga',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#705
('Carevdar',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#706
('Carevići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#707
('Carevo Polje',47303,'Josipdol','KARLOVAČKA',now(),now(),1),
#708
('Carevo Selo',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#709
('Cargovec',42205,'Vidovec','VARAŽDINSKA',now(),now(),1),
#710
('Caska',53296,'Zubovići','LIČKO-SENJSKA',now(),now(),1),
#711
('Cavtat',20210,'Cavtat','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#712
('Cebovec',49253,'Lobor','KRAPINSKO-ZAGORSKA',now(),now(),1),
#713
('Celine',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#714
('Celine',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#715
('Celine',40317,'Podturen','MEĐIMURSKA',now(),now(),1),
#716
('Celine Pušćanske',10294,'Donja Pušća','ZAGREBAČKA',now(),now(),1),
#717
('Celine Samoborske',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#718
('Cepeliš',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#719
('Cepidlak',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#720
('Cera',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#721
('Cere',52220,'Labin','ISTARSKA',now(),now(),1),
#722
('Cere',52341,'Žminj','ISTARSKA',now(),now(),1),
#723
('Ceremošnjak',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#724
('Cerić',32221,'Nuštar','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#725
('Cerik',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#726
('Cerina',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#727
('Cerinski Breg',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#728
('Cerion',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#729
('Cerjani',52464,'Kaštelir (Castelliere)','ISTARSKA',now(),now(),1),
#730
('Cerje',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#731
('Cerje',10361,'Sesvete-Kraljevec','GRAD ZAGREB',now(),now(),1),
#732
('Cerje Jesenjsko',49233,'Gornje Jesenje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#733
('Cerje Letovanićko',44272,'Lekenik','SISAČKO-MOSLAVAČKA',now(),now(),1),
#734
('Cerje Nebojse',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#735
('Cerje Pokupsko',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#736
('Cerje Samoborsko',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#737
('Cerje Tužno',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#738
('Cerje Vivodinsko',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#739
('Cerna',32272,'Cerna','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#740
('Cernik',10457,'Sošice','ZAGREBAČKA',now(),now(),1),
#741
('Cernik',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#742
('Cernik',35404,'Cernik','BRODSKO-POSAVSKA',now(),now(),1),
#743
('Cerovac',23440,'Gračac','ZADARSKA',now(),now(),1),
#744
('Cerovac',34308,'Jakšić','POŽEŠKO-SLAVONSKA',now(),now(),1),
#745
('Cerovac',31222,'Bizovac','OSJEČKO-BARANJSKA',now(),now(),1),
#746
('Cerovac Barilovički',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#747
('Cerovac Vukmanički',47241,'Cerovac Vukmanički','KARLOVAČKA',now(),now(),1),
#748
('Cerovački Galovići',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#749
('Cerovica',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#750
('Cerovići',51242,'Drivenik','PRIMORSKO-GORANSKA',now(),now(),1),
#751
('Cerovlje',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#752
('Cerovnik',47303,'Josipdol','KARLOVAČKA',now(),now(),1),
#753
('Cerovski Vrh',10418,'Dubranec','ZAGREBAČKA',now(),now(),1),
#754
('Cesarica',53288,'Karlobag','LIČKO-SENJSKA',now(),now(),1),
#755
('Cesarska Ves',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#756
('Cestica',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#757
('Cetina',22310,'Kijevo','ŠIBENSKO-KNINSKA',now(),now(),1),
#758
('Cetingrad',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#759
('Cetinovec',49250,'Zlatar','KRAPINSKO-ZAGORSKA',now(),now(),1),
#760
('Cetinski Varoš',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#761
('Cicingaj',23452,'Karin','ZADARSKA',now(),now(),1),
#762
('Cicvare',34553,'Bučje','POŽEŠKO-SLAVONSKA',now(),now(),1),
#763
('Cicvare',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#764
('Cicvare',22214,'Čista Velika','ŠIBENSKO-KNINSKA',now(),now(),1),
#765
('Ciglena',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#766
('Ciglenica',43280,'Garešnica','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#767
('Ciglenica',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#768
('Ciglenica Zagorska',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#769
('Ciglenik',34343,'Bektež','POŽEŠKO-SLAVONSKA',now(),now(),1),
#770
('Ciglenik',35250,'Oriovac','BRODSKO-POSAVSKA',now(),now(),1),
#771
('Cigrovec',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#772
('Cikote',34553,'Bučje','POŽEŠKO-SLAVONSKA',now(),now(),1),
#773
('Cikote',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#774
('Cirka',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#775
('Cirkovljan',40323,'Prelog','MEĐIMURSKA',now(),now(),1),
#776
('Cirkvena',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#777
('Cista Provo',21256,'Cista Provo','SPLITSKO-DALMATINSKA',now(),now(),1),
#778
('Cista Velika',21244,'Cista Velika','SPLITSKO-DALMATINSKA',now(),now(),1),
#779
('Civljane',22310,'Kijevo','ŠIBENSKO-KNINSKA',now(),now(),1),
#780
('Cokuni',52208,'Krnica','ISTARSKA',now(),now(),1),
#781
('Colnari',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#782
('Cremušina',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#783
('Cres',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#784
('Cret Bizovački',31222,'Bizovac','OSJEČKO-BARANJSKA',now(),now(),1),
#785
('Cret Viljevski',31531,'Viljevo','OSJEČKO-BARANJSKA',now(),now(),1),
#786
('Crevarska Strana',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#787
('Crikvenica',51260,'Crikvenica','PRIMORSKO-GORANSKA',now(),now(),1),
#788
('Crivac',21229,'Crivac','SPLITSKO-DALMATINSKA',now(),now(),1),
#789
('Crklada',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#790
('Crkovec',42250,'Lepoglava','VARAŽDINSKA',now(),now(),1),
#791
('Crkvari',33515,'Orahovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#792
('Crkveni Bok',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#793
('Crkveni Vrhovci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#794
('Crljenci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#795
('Crljenik',23422,'Stankovci','ZADARSKA',now(),now(),1),
#796
('Crna Draga',47206,'Lasinja','KARLOVAČKA',now(),now(),1),
#797
('Crna Klada',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#798
('Crna Mlaka',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#799
('Crnac',33507,'Crnac','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#800
('Crnac',44010,'Sisak-Caprag','SISAČKO-MOSLAVAČKA',now(),now(),1),
#801
('Crni',52220,'Labin','ISTARSKA',now(),now(),1),
#802
('Crni Dabar',53206,'Brušane','LIČKO-SENJSKA',now(),now(),1),
#803
('Crni Kal',53273,'Vratnik','LIČKO-SENJSKA',now(),now(),1),
#804
('Crni Lazi',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#805
('Crni Lug',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#806
('Crni Potok',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#807
('Crni Potok',35201,'Podcrkavlje','BRODSKO-POSAVSKA',now(),now(),1),
#808
('Crno',23000,'Zadar','ZADARSKA',now(),now(),1),
#809
('Crno',51251,'Ledenice','PRIMORSKO-GORANSKA',now(),now(),1),
#810
('Crno Kamanje',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#811
('Crno Vrelo',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#812
('Crveni Vrh',52475,'Savudrija (Salvore)','ISTARSKA',now(),now(),1),
#813
('Cubinec',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#814
('Cugovec',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#815
('Cukrići',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#816
('Cunj',52420,'Buzet','ISTARSKA',now(),now(),1),
#817
('Curkovec',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#818
('Cvetkovec',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#819
('Cvetković',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#820
('Cvetković Brdo',10418,'Dubranec','ZAGREBAČKA',now(),now(),1),
#821
('Cvetlin',42254,'Trakošćan','VARAŽDINSKA',now(),now(),1),
#822
('Cvetnić Brdo',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#823
('Cvijanović Brdo',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#824
('Cvitani',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#825
('Cvitići',52341,'Žminj','ISTARSKA',now(),now(),1),
#826
('Cvitović',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#827
('Čabar',51306,'Čabar','PRIMORSKO-GORANSKA',now(),now(),1),
#828
('Čabdin',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#829
('Čabraji',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#830
('Čabrunići',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#831
('Čačinci',33514,'Čačinci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#832
('Čačvina',21240,'Trilj','SPLITSKO-DALMATINSKA',now(),now(),1),
#833
('Čađavac',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#834
('Čađavica',33523,'Čađavica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#835
('Čađavički Lug',33523,'Čađavica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#836
('Čaglin',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#837
('Čaire',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#838
('Čajkovci',35210,'Vrpolje','BRODSKO-POSAVSKA',now(),now(),1),
#839
('Čajkovica',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#840
('Čajkovići',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#841
('Čakanec',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#842
('Čakovci',32238,'Čakovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#843
('Čakovec',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#844
('Čalinec',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#845
('Čamagajevci',31543,'Miholjački Poreč','OSJEČKO-BARANJSKA',now(),now(),1),
#846
('Čambarelići',52232,'Kršan','ISTARSKA',now(),now(),1),
#847
('Čamerovac',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#848
('Čanak',53224,'Ličko Lešće','LIČKO-SENJSKA',now(),now(),1),
#849
('Čandrli',51242,'Drivenik','PRIMORSKO-GORANSKA',now(),now(),1),
#850
('Čanjevo',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#851
('Čapljani',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#852
('Čaporice',21240,'Trilj','SPLITSKO-DALMATINSKA',now(),now(),1),
#853
('Čaprginci',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#854
('Čara',20273,'Čara','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#855
('Čatrnja',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#856
('Čatrnja',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#857
('Čatrnja',47246,'Drežnik Grad','KARLOVAČKA',now(),now(),1),
#858
('Čavle',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#859
('Čavlovica',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#860
('Čavoglave',22322,'Ružić','ŠIBENSKO-KNINSKA',now(),now(),1),
#861
('Čazma',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#862
('Čečavac',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#863
('Čečevački Vučjak',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#864
('Čedanj',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#865
('Čeglje',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#866
('Čehići',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#867
('Čehovec',40323,'Prelog','MEĐIMURSKA',now(),now(),1),
#868
('Čelikovići',35252,'Sibinj','BRODSKO-POSAVSKA',now(),now(),1),
#869
('Čelina',21317,'Lokva Rogoznica','SPLITSKO-DALMATINSKA',now(),now(),1),
#870
('Čelopeci',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#871
('Čemernica',33000,'Virovitica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#872
('Čemernica Lonjska',10312,'Kloštar Ivanić','ZAGREBAČKA',now(),now(),1),
#873
('Čeminac',31325,'Čeminac','OSJEČKO-BARANJSKA',now(),now(),1),
#874
('Čenkovo',31416,'Levanjska Varoš','OSJEČKO-BARANJSKA',now(),now(),1),
#875
('Čepelovac',48350,'Đurđevac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#876
('Čepić',52428,'Oprtalj (Portole)','ISTARSKA',now(),now(),1),
#877
('Čepikuće',20231,'Doli','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#878
('Čepin',31431,'Čepin','OSJEČKO-BARANJSKA',now(),now(),1),
#879
('Čepinski Martinci',31431,'Čepin','OSJEČKO-BARANJSKA',now(),now(),1),
#880
('Čepljani',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#881
('Červar Porat',52449,'Červar Porat','ISTARSKA',now(),now(),1),
#882
('Červari',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#883
('Čestijanec',40313,'Sveti Martin na Muri','MEĐIMURSKA',now(),now(),1),
#884
('Česvinica',20230,'Ston','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#885
('Češljakovci',34334,'Kaptol','POŽEŠKO-SLAVONSKA',now(),now(),1),
#886
('Četekovac',33517,'Mikleuš','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#887
('Četvrtkovac',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#888
('Čibača',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#889
('Čičkovina',42232,'Donji Martijanec','VARAŽDINSKA',now(),now(),1),
#890
('Čigoč',44213,'Kratečko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#891
('Čilipi',20213,'Čilipi','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#892
('Čingi-lingi',48327,'Molve','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#893
('Čiritež',52425,'Roč','ISTARSKA',now(),now(),1),
#894
('Čisla',21253,'Gata','SPLITSKO-DALMATINSKA',now(),now(),1),
#895
('Čista Mala',22214,'Čista Velika','ŠIBENSKO-KNINSKA',now(),now(),1),
#896
('Čista Mlaka',10361,'Sesvete-Kraljevec','GRAD ZAGREB',now(),now(),1),
#897
('Čista Velika',22214,'Čista Velika','ŠIBENSKO-KNINSKA',now(),now(),1),
#898
('Čitluk',21230,'Sinj','SPLITSKO-DALMATINSKA',now(),now(),1),
#899
('Čitluk',22303,'Oklaj','ŠIBENSKO-KNINSKA',now(),now(),1),
#900
('Čižići',51514,'Dobrinj','PRIMORSKO-GORANSKA',now(),now(),1),
#901
('Čojlug',33517,'Mikleuš','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#902
('Čojluk',53234,'Udbina','LIČKO-SENJSKA',now(),now(),1),
#903
('Čokadinci',31431,'Čepin','OSJEČKO-BARANJSKA',now(),now(),1),
#904
('Čovac',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#905
('Čovići',53224,'Ličko Lešće','LIČKO-SENJSKA',now(),now(),1),
#906
('Črečan',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#907
('Črečan',40306,'Macinec','MEĐIMURSKA',now(),now(),1),
#908
('Čremušnica',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#909
('Črešnjevec',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#910
('Črešnjevo',42201,'Beretinec','VARAŽDINSKA',now(),now(),1),
#911
('Čret',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#912
('Čret Bisaški',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#913
('Čret Posavski',10411,'Orle','ZAGREBAČKA',now(),now(),1),
#914
('Črnčevec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#915
('Črnec Biškupečki',42204,'Turčin','VARAŽDINSKA',now(),now(),1),
#916
('Črnec Dugoselski',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#917
('Črnec Rugvički',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#918
('Črnica',52420,'Buzet','ISTARSKA',now(),now(),1),
#919
('Črnile',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#920
('Črnilovec',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#921
('Črnkovci',31553,'Črnkovci','OSJEČKO-BARANJSKA',now(),now(),1),
#922
('Črnkovec',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#923
('Črvar',52449,'Červar Porat','ISTARSKA',now(),now(),1),
#924
('Čučak',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#925
('Čučići',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#926
('Čuić Brdo',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#927
('Čujića Krčevina',53231,'Plitvička Jezera','LIČKO-SENJSKA',now(),now(),1),
#928
('Čuki',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#929
('Čukovec',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#930
('Čukovec',40325,'Draškovec','MEĐIMURSKA',now(),now(),1),
#931
('Čukur',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#932
('Čunkova Draga',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#933
('Čuntić',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#934
('Čurilovec',42222,'Ljubeščica','VARAŽDINSKA',now(),now(),1),
#935
('Čuši',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#936
('Čvrljevo',22221,'Lozovac','ŠIBENSKO-KNINSKA',now(),now(),1),
#937
('Čvrljevo',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#938
('Ćelija',32225,'Bobota','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#939
('Ćeralije',33517,'Mikleuš','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#940
('Ćetiše',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#941
('Ćikovići',51215,'Kastav','PRIMORSKO-GORANSKA',now(),now(),1),
#942
('Ćore',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#943
('Ćosinci',34312,'Sesvete (kod Požege)','POŽEŠKO-SLAVONSKA',now(),now(),1),
#944
('Ćosine Laze',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#945
('Ćulibrki',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#946
('Ćunski',51564,'Ćunski','PRIMORSKO-GORANSKA',now(),now(),1),
#947
('Ćurlovac',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#948
('Ćusi',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#949
('Dabar',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#950
('Dabar',21233,'Hrvace','SPLITSKO-DALMATINSKA',now(),now(),1),
#951
('Dabašnica',23445,'Srb','ZADARSKA',now(),now(),1),
#952
('Dabrina',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#953
('Dajla',52466,'Novigrad (Cittanova)','ISTARSKA',now(),now(),1),
#954
('Dalj',31226,'Dalj','OSJEČKO-BARANJSKA',now(),now(),1),
#955
('Damalj',51329,'Severin na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#956
('Danci',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#957
('Dančanje',20248,'Putniković','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#958
('Dančulovići',47284,'Kašt','KARLOVAČKA',now(),now(),1),
#959
('Dane',52420,'Buzet','ISTARSKA',now(),now(),1),
#960
('Dane',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#961
('Dani',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#962
('Danilo Biranj',22000,'Šibenik','ŠIBENSKO-KNINSKA',now(),now(),1),
#963
('Danilo Gornje',22205,'Perković','ŠIBENSKO-KNINSKA',now(),now(),1),
#964
('Danilo Kraljice',22205,'Perković','ŠIBENSKO-KNINSKA',now(),now(),1),
#965
('Dapci',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#966
('Daranovci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#967
('Darda',31326,'Darda','OSJEČKO-BARANJSKA',now(),now(),1),
#968
('Darići',47201,'Draganići','KARLOVAČKA',now(),now(),1),
#969
('Darkovac',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#970
('Daruvar',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#971
('Daruvarski Vinogradi',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#972
('Daskatica',43246,'Štefanje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#973
('Dautan',43272,'Nova Rača','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#974
('Davor',35425,'Davor','BRODSKO-POSAVSKA',now(),now(),1),
#975
('Dazlina',22240,'Tisno','ŠIBENSKO-KNINSKA',now(),now(),1),
#976
('Deanovec',10313,'Graberje Ivaničko','ZAGREBAČKA',now(),now(),1),
#977
('Deanovečko Brdo',10313,'Graberje Ivaničko','ZAGREBAČKA',now(),now(),1),
#978
('Deanovići',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#979
('Debelo Brdo',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#980
('Debelo Brdo I',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#981
('Debelo Brdo II',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#982
('Debeljak',23206,'Sukošan','ZADARSKA',now(),now(),1),
#983
('Debeljuhi',52341,'Žminj','ISTARSKA',now(),now(),1),
#984
('Dedin',51313,'Kupjak','PRIMORSKO-GORANSKA',now(),now(),1),
#985
('Dedina',48269,'Kalnik','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#986
('Dekanovec',40318,'Dekanovec','MEĐIMURSKA',now(),now(),1),
#987
('Deklešanec',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#988
('Deklevi',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#989
('Deklići',52464,'Kaštelir (Castelliere)','ISTARSKA',now(),now(),1),
#990
('Dekovići',52446,'Nova Vas','ISTARSKA',now(),now(),1),
#991
('Delači',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#992
('Delić Poljana',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#993
('Delići',52450,'Vrsar (Orsera)','ISTARSKA',now(),now(),1),
#994
('Delkovec',49251,'Mače','KRAPINSKO-ZAGORSKA',now(),now(),1),
#995
('Delnice',51300,'Delnice','PRIMORSKO-GORANSKA',now(),now(),1),
#996
('Delovi',48325,'Novigrad Podravski','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#997
('Demerje',10251,'Hrvatski Leskovac','GRAD ZAGREB',now(),now(),1),
#998
('Dereza',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#999
('Dereza',34552,'Badljevina','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1000
('Derežani',10313,'Graberje Ivaničko','ZAGREBAČKA',now(),now(),1),
#1001
('Deringaj',23440,'Gračac','ZADARSKA',now(),now(),1),
#1002
('Deringaj',23445,'Srb','ZADARSKA',now(),now(),1),
#1003
('Deringaj II',23440,'Gračac','ZADARSKA',now(),now(),1),
#1004
('Dervišaga',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1005
('Desinić',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1006
('Desinić Gora',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1007
('Desmerice',47307,'Gornje Zagorje','KARLOVAČKA',now(),now(),1),
#1008
('Desna Martinska Ves',44201,'Martinska Ves','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1009
('Desne',20344,'Komin (Dalma)','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1010
('Desni Degoj',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1011
('Desni Dubrovčak',44201,'Martinska Ves','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1012
('Desni Štefanki',47206,'Lasinja','KARLOVAČKA',now(),now(),1),
#1013
('Desno Sredičko',47206,'Lasinja','KARLOVAČKA',now(),now(),1),
#1014
('Desno Trebarjevo',44201,'Martinska Ves','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1015
('Desno Željezno',44201,'Martinska Ves','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1016
('Desprim',10257,'Brezovica','GRAD ZAGREB',now(),now(),1),
#1017
('Detkovac',33411,'Gradina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1018
('Dežanovac',43506,'Dežanovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1019
('Deževci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1020
('Dicmo',21232,'Dicmo','SPLITSKO-DALMATINSKA',now(),now(),1),
#1021
('Dijakovac',43531,'Veliki Bastaji','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1022
('Dijaneš',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#1023
('Dijankovec',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1024
('Dijebala',43211,'Predavac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1025
('Diklići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#1026
('Dinjevac',48362,'Kloštar Podravski','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1027
('Dinjiška',23249,'Povljana','ZADARSKA',now(),now(),1),
#1028
('Dioš',43505,'Končanica (Končenice)','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1029
('Dišnik',43280,'Garešnica','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1030
('Divjake',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#1031
('Divojevići',21202,'Lećevica','SPLITSKO-DALMATINSKA',now(),now(),1),
#1032
('Divoselo',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#1033
('Divoš',31215,'Ernestinovo','OSJEČKO-BARANJSKA',now(),now(),1),
#1034
('Divoševci',35214,'Donji Andrijevci','BRODSKO-POSAVSKA',now(),now(),1),
#1035
('Divšići',52206,'Marčana','ISTARSKA',now(),now(),1),
#1036
('Divulje',21220,'Trogir','SPLITSKO-DALMATINSKA',now(),now(),1),
#1037
('Divuša',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1038
('Djedina Rijeka',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1039
('Dnopolje',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#1040
('Dobra Kuća',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1041
('Dobra Voda',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1042
('Dobra Voda',23422,'Stankovci','ZADARSKA',now(),now(),1),
#1043
('Dobranje',20353,'Mlinište','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1044
('Dobranje',21244,'Cista Velika','SPLITSKO-DALMATINSKA',now(),now(),1),
#1045
('Dobreć',51415,'Lovran','PRIMORSKO-GORANSKA',now(),now(),1),
#1046
('Dobrenići',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#1047
('Dobri Zdenci',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1048
('Dobrići',33522,'Voćin','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1049
('Dobrinče',21263,'Krivodol','SPLITSKO-DALMATINSKA',now(),now(),1),
#1050
('Dobrinj',51514,'Dobrinj','PRIMORSKO-GORANSKA',now(),now(),1),
#1051
('Dobrodol',10360,'Sesvete','GRAD ZAGREB',now(),now(),1),
#1052
('Dobrogošće',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1053
('Dobropoljana',23264,'Neviđane','ZADARSKA',now(),now(),1),
#1054
('Dobropoljci',23420,'Benkovac','ZADARSKA',now(),now(),1),
#1055
('Dobroselo',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#1056
('Dobrovac',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1057
('Dobrović',33518,'Nova Bukovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1058
('Dodoši',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1059
('Dograde',21222,'Marina','SPLITSKO-DALMATINSKA',now(),now(),1),
#1060
('Dojutrovica',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#1061
('Dokmanovići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1062
('Dol',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#1063
('Dol',21460,'Stari Grad','SPLITSKO-DALMATINSKA',now(),now(),1),
#1064
('Dol',21410,'Postira','SPLITSKO-DALMATINSKA',now(),now(),1),
#1065
('Dol Klanječki',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1066
('Dolac',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1067
('Dolac Crikvenički',51260,'Crikvenica','PRIMORSKO-GORANSKA',now(),now(),1),
#1068
('Dolanjski Jarak',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#1069
('Dolci',33515,'Orahovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1070
('Dolec Podokićki',10435,'Sveti Martin pod Okićem','ZAGREBAČKA',now(),now(),1),
#1071
('Dolenci',51328,'Lukovdol','PRIMORSKO-GORANSKA',now(),now(),1),
#1072
('Dolenja Vas',52426,'Lupoglav','ISTARSKA',now(),now(),1),
#1073
('Doli',20231,'Doli','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1074
('Dolica',52341,'Žminj','ISTARSKA',now(),now(),1),
#1075
('Dolića Draga',21263,'Krivodol','SPLITSKO-DALMATINSKA',now(),now(),1),
#1076
('Dolići',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1077
('Dolina',35423,'Vrbje','BRODSKO-POSAVSKA',now(),now(),1),
#1078
('Dolinci',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#1079
('Dolnjaki',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1080
('Dolovo',51514,'Dobrinj','PRIMORSKO-GORANSKA',now(),now(),1),
#1081
('Doluš',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1082
('Doljan',42214,'Sveti Ilija','VARAŽDINSKA',now(),now(),1),
#1083
('Doljanci',34330,'Velika','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1084
('Doljanec',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1085
('Doljani',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1086
('Doljani',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#1087
('Doljani',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#1088
('Doljani Žumberački',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#1089
('Doljanovci',34334,'Kaptol','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1090
('Domagović',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#1091
('Domahovo',49214,'Veliko Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1092
('Domaji',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1093
('Domankuš',43212,'Rovišće','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1094
('Domaslovec',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#1095
('Domašinec',40318,'Dekanovec','MEĐIMURSKA',now(),now(),1),
#1096
('Domijanići',52341,'Žminj','ISTARSKA',now(),now(),1),
#1097
('Dominkovica',43226,'Veliko Trojstvo','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1098
('Domitrovec',42205,'Vidovec','VARAŽDINSKA',now(),now(),1),
#1099
('Domovec',49283,'Hraščina-Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1100
('Donja Bačuga',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1101
('Donja Banda',20242,'Oskorušno','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1102
('Donja Batina/dio/1-214',49250,'Zlatar','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1103
('Donja Batina/dio/215-dalje',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1104
('Donja Bebrina',35208,'Ruščica','BRODSKO-POSAVSKA',now(),now(),1),
#1105
('Donja Bistra',10298,'Donja Bistra','ZAGREBAČKA',now(),now(),1),
#1106
('Donja Brckovčina',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1107
('Donja Brusovača',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#1108
('Donja Bučica',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1109
('Donja Budičina',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1110
('Donja Bukovica',33518,'Nova Bukovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1111
('Donja Čemernica',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1112
('Donja Dobra',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1113
('Donja Drenova',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#1114
('Donja Dubrava',40328,'Donja Dubrava','MEĐIMURSKA',now(),now(),1),
#1115
('Donja Glina',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1116
('Donja Glogovnica',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1117
('Donja Gračenica',44318,'Voloder','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1118
('Donja Greda',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#1119
('Donja Jagodnja',23423,'Polača','ZADARSKA',now(),now(),1),
#1120
('Donja Jelenska',44317,'Popovača','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1121
('Donja Konjščina',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1122
('Donja Kovačica',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1123
('Donja Krašićevica',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#1124
('Donja Kupčina',10451,'Pisarovina','ZAGREBAČKA',now(),now(),1),
#1125
('Donja Lamana Draga',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1126
('Donja Letina',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1127
('Donja Lomnica',10412,'Donja Lomnica','ZAGREBAČKA',now(),now(),1),
#1128
('Donja Mlinoga',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1129
('Donja Motičina',31513,'Donja Motičina','OSJEČKO-BARANJSKA',now(),now(),1),
#1130
('Donja Obreška',10312,'Kloštar Ivanić','ZAGREBAČKA',now(),now(),1),
#1131
('Donja Obrijež',34552,'Badljevina','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1132
('Donja Oraovica',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1133
('Donja Pačetina',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1134
('Donja Pastuša',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1135
('Donja Perjasica',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#1136
('Donja Petrička',43232,'Berek','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1137
('Donja Pištana',33515,'Orahovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1138
('Donja Plemenšćina',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1139
('Donja Podgora',49240,'Donja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1140
('Donja Poljana',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#1141
('Donja Purgarija',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#1142
('Donja Pušća',10294,'Donja Pušća','ZAGREBAČKA',now(),now(),1),
#1143
('Donja Rašenica',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1144
('Donja Reka',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#1145
('Donja Rijeka',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1146
('Donja Selnica',49254,'Belec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1147
('Donja Stranica',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#1148
('Donja Stubica',49240,'Donja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1149
('Donja Stupnica',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1150
('Donja Šemnica',49224,'Lepajci','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1151
('Donja Šumetlica',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1152
('Donja Šušnjara',43246,'Štefanje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1153
('Donja Topličica',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#1154
('Donja Trebinja',47241,'Cerovac Vukmanički','KARLOVAČKA',now(),now(),1),
#1155
('Donja Trstenica',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1156
('Donja Velešnja',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1157
('Donja Velika',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#1158
('Donja Velika',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1159
('Donja Visočka',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1160
('Donja Višnjica',42255,'Donja Višnjica','VARAŽDINSKA',now(),now(),1),
#1161
('Donja Vlahinička',44317,'Popovača','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1162
('Donja Voća',42245,'Donja Voća','VARAŽDINSKA',now(),now(),1),
#1163
('Donja Vrba',35207,'Gornja Vrba','BRODSKO-POSAVSKA',now(),now(),1),
#1164
('Donja Vrijeska',43531,'Veliki Bastaji','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1165
('Donja Vrućica',20240,'Trpanj','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1166
('Donja Zdenčina',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#1167
('Donja Zelina',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#1168
('Donja Žrvnica',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#1169
('Donjara',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1170
('Donjara (dio)',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1171
('Donje Bazije',33523,'Čađavica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1172
('Donje Biljane',23420,'Benkovac','ZADARSKA',now(),now(),1),
#1173
('Donje Brezno',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1174
('Donje Bukovlje',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#1175
('Donje Ceranje',23420,'Benkovac','ZADARSKA',now(),now(),1),
#1176
('Donje Cjepidlake',43532,'Đulovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1177
('Donje Dubrave',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#1178
('Donje Dvorišće',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#1179
('Donje Gnojnice',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#1180
('Donje Jame',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1181
('Donje Jesenje',49233,'Gornje Jesenje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1182
('Donje Komarevo',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1183
('Donje Kusonje',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1184
('Donje Ladanje',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#1185
('Donje Makojišće',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#1186
('Donje Mekušje',47000,'Karlovac','KARLOVAČKA',now(),now(),1),
#1187
('Donje Mokrice',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1188
('Donje Mrzlo Polje Mrežničko',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#1189
('Donje Novo Selo',32245,'Nijemci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#1190
('Donje Obuljeno',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1191
('Donje Ogorje',21206,'Donje Ogorje','SPLITSKO-DALMATINSKA',now(),now(),1),
#1192
('Donje Orešje',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#1193
('Donje Pazarište',53213,'Donje Pazarište','LIČKO-SENJSKA',now(),now(),1),
#1194
('Donje Planjane',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#1195
('Donje Podotočje',10415,'Novo Čiče','ZAGREBAČKA',now(),now(),1),
#1196
('Donje Polje',22000,'Šibenik','ŠIBENSKO-KNINSKA',now(),now(),1),
#1197
('Donje Predrijevo',33513,'Zdenci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1198
('Donje Prekrižje',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#1199
('Donje Prilišće',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#1200
('Donje Primišlje',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1201
('Donje Psarjevo',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#1202
('Donje Pustinje',21203,'Donji Muć','SPLITSKO-DALMATINSKA',now(),now(),1),
#1203
('Donje Raštane',23207,'Sveti Filip i Jakov','ZADARSKA',now(),now(),1),
#1204
('Donje Selište',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1205
('Donje Selo',21430,'Grohote','SPLITSKO-DALMATINSKA',now(),now(),1),
#1206
('Donje Sitno',21251,'Žrnovnica','SPLITSKO-DALMATINSKA',now(),now(),1),
#1207
('Donje Stative',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#1208
('Donje Taborište',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1209
('Donje Taborište',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1210
('Donje Tihovo',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#1211
('Donje Utore',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#1212
('Donje Vino',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1213
('Donje Vinovo',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#1214
('Donje Zagorje',47307,'Gornje Zagorje','KARLOVAČKA',now(),now(),1),
#1215
('Donje Zdjelice',48326,'Virje','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1216
('Donji Andrijevci',35214,'Donji Andrijevci','BRODSKO-POSAVSKA',now(),now(),1),
#1217
('Donji Babin Potok',53223,'Vrhovine','LIČKO-SENJSKA',now(),now(),1),
#1218
('Donji Bitelić',21233,'Hrvace','SPLITSKO-DALMATINSKA',now(),now(),1),
#1219
('Donji Bjelovac',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1220
('Donji Bogićevci',35428,'Dragalić','BRODSKO-POSAVSKA',now(),now(),1),
#1221
('Donji Borki',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1222
('Donji Budački',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#1223
('Donji Bukovac Žakanjski',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#1224
('Donji Cerovac',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1225
('Donji Cerovljani',44450,'Hrvatska Dubica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1226
('Donji Crnogovci',35422,'Zapolje','BRODSKO-POSAVSKA',now(),now(),1),
#1227
('Donji Čaglić',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1228
('Donji Čehi',10020,'Zagreb-Novi Zagreb','GRAD ZAGREB',now(),now(),1),
#1229
('Donji Čemehovec',10293,'Dubravica','ZAGREBAČKA',now(),now(),1),
#1230
('Donji Daruvar',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1231
('Donji Desinec',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#1232
('Donji Dobretin',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1233
('Donji Dolac',21205,'Donji Dolac','SPLITSKO-DALMATINSKA',now(),now(),1),
#1234
('Donji Draganec',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1235
('Donji Dragičevci',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1236
('Donji Dragonožec',10253,'Donji Dragonožec','GRAD ZAGREB',now(),now(),1),
#1237
('Donji Dubovec',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1238
('Donji Emovci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1239
('Donji Fodrovec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1240
('Donji Furjan',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1241
('Donji Grahovljani',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1242
('Donji Gučani',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1243
('Donji Hrastovac',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1244
('Donji Hrašćan',40320,'Donji Kraljevec','MEĐIMURSKA',now(),now(),1),
#1245
('Donji Hruševec',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#1246
('Donji Humac',21423,'Nerežišća','SPLITSKO-DALMATINSKA',now(),now(),1),
#1247
('Donji Jalšovec',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1248
('Donji Javoranj',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1249
('Donji Karin',23452,'Karin','ZADARSKA',now(),now(),1),
#1250
('Donji Kašić',23420,'Benkovac','ZADARSKA',now(),now(),1),
#1251
('Donji Klasnić',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1252
('Donji Kneginec',42204,'Turčin','VARAŽDINSKA',now(),now(),1),
#1253
('Donji Koncovčak',40314,'Selnica','MEĐIMURSKA',now(),now(),1),
#1254
('Donji Kosinj',53203,'Kosinj','LIČKO-SENJSKA',now(),now(),1),
#1255
('Donji Kraj',51417,'Mošćenička Draga','PRIMORSKO-GORANSKA',now(),now(),1),
#1256
('Donji Kraljevec',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1257
('Donji Kraljevec',40320,'Donji Kraljevec','MEĐIMURSKA',now(),now(),1),
#1258
('Donji Kremen',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1259
('Donji Kućan',42000,'Varaždin','VARAŽDINSKA',now(),now(),1),
#1260
('Donji Kukuruzari',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1261
('Donji Laduč',10292,'Šenkovec','ZAGREBAČKA',now(),now(),1),
#1262
('Donji Lađevac',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1263
('Donji Lapac',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#1264
('Donji Lipovac',35410,'Nova Kapela','BRODSKO-POSAVSKA',now(),now(),1),
#1265
('Donji Lipovčani',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1266
('Donji Lović',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#1267
('Donji Ložac',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#1268
('Donji Macelj',49225,'Đurmanec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1269
('Donji Marinkovac',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#1270
('Donji Markovac',10344,'Farkaševac','ZAGREBAČKA',now(),now(),1),
#1271
('Donji Martijanec',42232,'Donji Martijanec','VARAŽDINSKA',now(),now(),1),
#1272
('Donji Maslarac',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1273
('Donji Mekinjar',53236,'Podlapača','LIČKO-SENJSKA',now(),now(),1),
#1274
('Donji Meljani',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1275
('Donji Mihaljevec',40326,'Sveta Marija','MEĐIMURSKA',now(),now(),1),
#1276
('Donji Miholjac',31540,'Donji Miholjac','OSJEČKO-BARANJSKA',now(),now(),1),
#1277
('Donji Miklouš',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1278
('Donji Mosti',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1279
('Donji Muć',21203,'Donji Muć','SPLITSKO-DALMATINSKA',now(),now(),1),
#1280
('Donji Nikšić',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1281
('Donji Okrug',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#1282
('Donji Oštrc',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#1283
('Donji Oštri Vrh Ozaljski',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#1284
('Donji Poloj',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1285
('Donji Popovac',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1286
('Donji Prnjarovec',10314,'Križ','ZAGREBAČKA',now(),now(),1),
#1287
('Donji Proložac',21264,'Donji Proložac','SPLITSKO-DALMATINSKA',now(),now(),1),
#1288
('Donji Pustakovec',40323,'Prelog','MEĐIMURSKA',now(),now(),1),
#1289
('Donji Rogolji',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#1290
('Donji Selkovac',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1291
('Donji Sjeničak',47212,'Skakavac','KARLOVAČKA',now(),now(),1),
#1292
('Donji Skrad',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#1293
('Donji Slatinik',35201,'Podcrkavlje','BRODSKO-POSAVSKA',now(),now(),1),
#1294
('Donji Sređani',43506,'Dežanovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1295
('Donji Stupnik',10255,'Gornji Stupnik','ZAGREBAČKA',now(),now(),1),
#1296
('Donji Šajn',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1297
('Donji Šarampov',10310,'Ivanić-Grad','ZAGREBAČKA',now(),now(),1),
#1298
('Donji Šehovac',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1299
('Donji Škrnik',49295,'Kumrovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1300
('Donji Štrbci',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#1301
('Donji Tkalec',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1302
('Donji Trpuci',10253,'Donji Dragonožec','GRAD ZAGREB',now(),now(),1),
#1303
('Donji Turni',51300,'Delnice','PRIMORSKO-GORANSKA',now(),now(),1),
#1304
('Donji Vaganac',53233,'Ličko Petrovo Selo','LIČKO-SENJSKA',now(),now(),1),
#1305
('Donji Varoš',35435,'Stara Gradiška','BRODSKO-POSAVSKA',now(),now(),1),
#1306
('Donji Velemerić',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#1307
('Donji Vidovec',40327,'Donji Vidovec','MEĐIMURSKA',now(),now(),1),
#1308
('Donji Viduševac',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1309
('Donji Vinjani',21260,'Imotski','SPLITSKO-DALMATINSKA',now(),now(),1),
#1310
('Donji Vučkovići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1311
('Donji Vukašinac',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#1312
('Donji Vukojevac',44272,'Lekenik','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1313
('Donji Vukšići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1314
('Donji Zagon',51251,'Ledenice','PRIMORSKO-GORANSKA',now(),now(),1),
#1315
('Donji Zatezeli',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#1316
('Donji Zbilj',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1317
('Donji Zebanec',40314,'Selnica','MEĐIMURSKA',now(),now(),1),
#1318
('Donji Zvečaj',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#1319
('Donji Žagari',51303,'Plešce','PRIMORSKO-GORANSKA',now(),now(),1),
#1320
('Donji Žirovac',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1321
('Dopsin',31404,'Vladislavci','OSJEČKO-BARANJSKA',now(),now(),1),
#1322
('Dorčići',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#1323
('Došen Dabar',53206,'Brušane','LIČKO-SENJSKA',now(),now(),1),
#1324
('Drače',20246,'Janjina','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1325
('Dračevac',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#1326
('Dračevac Ninski',23241,'Poličnik','ZADARSKA',now(),now(),1),
#1327
('Dračevica',21423,'Nerežišća','SPLITSKO-DALMATINSKA',now(),now(),1),
#1328
('Dračevo Polje',21483,'Podšpilje','SPLITSKO-DALMATINSKA',now(),now(),1),
#1329
('Draga',22202,'Primošten','ŠIBENSKO-KNINSKA',now(),now(),1),
#1330
('Draga',34330,'Velika','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1331
('Draga Bašćanska',51522,'Draga Bašćanska','PRIMORSKO-GORANSKA',now(),now(),1),
#1332
('Draga Crikvenička',51260,'Crikvenica','PRIMORSKO-GORANSKA',now(),now(),1),
#1333
('Draga Lukovdolska',51329,'Severin na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#1334
('Draga Svetojanska',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#1335
('Dragalić',35428,'Dragalić','BRODSKO-POSAVSKA',now(),now(),1),
#1336
('Dragaljin',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#1337
('Draganić',43212,'Rovišće','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1338
('Draganići',47201,'Draganići','KARLOVAČKA',now(),now(),1),
#1339
('Draganlug',34343,'Bektež','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1340
('Draganovec',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1341
('Draganje Selo',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#1342
('Drage',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#1343
('Drage',23211,'Pakoštane','ZADARSKA',now(),now(),1),
#1344
('Dragljane',21275,'Dragljane','SPLITSKO-DALMATINSKA',now(),now(),1),
#1345
('Dragonoš',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#1346
('Dragoslavec',40311,'Lopatinec','MEĐIMURSKA',now(),now(),1),
#1347
('Dragoslavec Breg',40306,'Macinec','MEĐIMURSKA',now(),now(),1),
#1348
('Dragoslavec Selo',40306,'Macinec','MEĐIMURSKA',now(),now(),1),
#1349
('Dragoševci',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#1350
('Dragošička',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#1351
('Dragotin',31411,'Trnava','OSJEČKO-BARANJSKA',now(),now(),1),
#1352
('Dragotina',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1353
('Dragotinci',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1354
('Dragovanščak',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#1355
('Dragovci',35410,'Nova Kapela','BRODSKO-POSAVSKA',now(),now(),1),
#1356
('Dragove',23286,'Božava','ZADARSKA',now(),now(),1),
#1357
('Dragović',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1358
('Dragovići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1359
('Dragozetići',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#1360
('Draguć',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#1361
('Draguzeti',52207,'Barban','ISTARSKA',now(),now(),1),
#1362
('Drakulić Rijeka',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#1363
('Dramalj',51265,'Dramalj','PRIMORSKO-GORANSKA',now(),now(),1),
#1364
('Drastin',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#1365
('Drašći Vrh',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#1366
('Draše',49294,'Kraljevec na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1367
('Draškovac',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1368
('Draškovec',40325,'Draškovec','MEĐIMURSKA',now(),now(),1),
#1369
('Drašković',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#1370
('Drašnice',21328,'Drašnice','SPLITSKO-DALMATINSKA',now(),now(),1),
#1371
('Draž',31305,'Draž','OSJEČKO-BARANJSKA',now(),now(),1),
#1372
('Draževitići',21277,'Veliki Prolog','SPLITSKO-DALMATINSKA',now(),now(),1),
#1373
('Dražica',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1374
('Dražice',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#1375
('Drenčec',10361,'Sesvete-Kraljevec','GRAD ZAGREB',now(),now(),1),
#1376
('Drenov Bok',44325,'Krapje','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1377
('Drenov Klanac',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#1378
('Drenovac',34315,'Ratkovica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1379
('Drenovac Banski',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1380
('Drenovac Osredački',23445,'Srb','ZADARSKA',now(),now(),1),
#1381
('Drenovac Radučki',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#1382
('Drenovci',32257,'Drenovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#1383
('Drenovec',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#1384
('Drenovica Lipnička',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#1385
('Drenje',31418,'Drenje','OSJEČKO-BARANJSKA',now(),now(),1),
#1386
('Drenje',52220,'Labin','ISTARSKA',now(),now(),1),
#1387
('Drenje Brdovečko',10291,'Prigorje Brdovečko','ZAGREBAČKA',now(),now(),1),
#1388
('Drenje Šćitarjevsko',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#1389
('Drežnica',47313,'Drežnica','KARLOVAČKA',now(),now(),1),
#1390
('Drežničko Selište',47246,'Drežnik Grad','KARLOVAČKA',now(),now(),1),
#1391
('Drežnik',35422,'Zapolje','BRODSKO-POSAVSKA',now(),now(),1),
#1392
('Drežnik Brezovički',10257,'Brezovica','GRAD ZAGREB',now(),now(),1),
#1393
('Drežnik Grad',47246,'Drežnik Grad','KARLOVAČKA',now(),now(),1),
#1394
('Drežnik Podokićki',10435,'Sveti Martin pod Okićem','ZAGREBAČKA',now(),now(),1),
#1395
('Drinak',51252,'Klenovica','PRIMORSKO-GORANSKA',now(),now(),1),
#1396
('Drinovci',22324,'Drinovci','ŠIBENSKO-KNINSKA',now(),now(),1),
#1397
('Drivenik',51242,'Drivenik','PRIMORSKO-GORANSKA',now(),now(),1),
#1398
('Drivenik-Stanica',51323,'Lič','PRIMORSKO-GORANSKA',now(),now(),1),
#1399
('Drlež',43506,'Dežanovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1400
('Drljača',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1401
('Drljanovac',43272,'Nova Rača','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1402
('Drnek',10411,'Orle','ZAGREBAČKA',now(),now(),1),
#1403
('Drniš',22320,'Drniš','ŠIBENSKO-KNINSKA',now(),now(),1),
#1404
('Drnje',48322,'Drnje','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1405
('Dropčevec',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#1406
('Dropkovec',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1407
('Drškovci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1408
('Drum',21262,'Kamenmost','SPLITSKO-DALMATINSKA',now(),now(),1),
#1409
('Druškovec',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#1410
('Druškovec Gora',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1411
('Druškovec Humski',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1412
('Družbinec',42206,'Petrijanec','VARAŽDINSKA',now(),now(),1),
#1413
('Družilovec',49214,'Veliko Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1414
('Drvenik',21333,'Drvenik','SPLITSKO-DALMATINSKA',now(),now(),1),
#1415
('Drvenik',20217,'Pridvorje','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1416
('Drvenik Mali',21225,'Drvenik Veliki','SPLITSKO-DALMATINSKA',now(),now(),1),
#1417
('Drvenik Veliki',21225,'Drvenik Veliki','SPLITSKO-DALMATINSKA',now(),now(),1),
#1418
('Držimurec',40321,'Mala Subotica','MEĐIMURSKA',now(),now(),1),
#1419
('Duba Konavoska',20210,'Cavtat','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1420
('Duba Pelješka',20240,'Trpanj','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1421
('Duba Stonska',20230,'Ston','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1422
('Dubočac',35254,'Bebrina','BRODSKO-POSAVSKA',now(),now(),1),
#1423
('Duboka',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1424
('Duboka',20356,'Klek','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1425
('Duboka',21483,'Podšpilje','SPLITSKO-DALMATINSKA',now(),now(),1),
#1426
('Duboki Dol',23440,'Gračac','ZADARSKA',now(),now(),1),
#1427
('Duboševica',31304,'Duboševica','OSJEČKO-BARANJSKA',now(),now(),1),
#1428
('Dubovac',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#1429
('Dubovec',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1430
('Dubovec Bisaški',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#1431
('Dubovica',42231,'Mali Bukovec','VARAŽDINSKA',now(),now(),1),
#1432
('Dubovik',35201,'Podcrkavlje','BRODSKO-POSAVSKA',now(),now(),1),
#1433
('Dubranec',10418,'Dubranec','ZAGREBAČKA',now(),now(),1),
#1434
('Dubrava',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#1435
('Dubrava',21252,'Tugare','SPLITSKO-DALMATINSKA',now(),now(),1),
#1436
('Dubrava',20247,'Žuljana','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1437
('Dubrava',23250,'Pag','ZADARSKA',now(),now(),1),
#1438
('Dubrava kod Šibenika',22000,'Šibenik','ŠIBENSKO-KNINSKA',now(),now(),1),
#1439
('Dubrava kod Tisnoga',22240,'Tisno','ŠIBENSKO-KNINSKA',now(),now(),1),
#1440
('Dubrava Križovljanska',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#1441
('Dubrava Pušćanska',10294,'Donja Pušća','ZAGREBAČKA',now(),now(),1),
#1442
('Dubrava Samoborska',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#1443
('Dubrava Zabočka',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1444
('Dubravci',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#1445
('Dubravci',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#1446
('Dubravčani',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#1447
('Dubrave',20278,'Nova Sela','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1448
('Dubrave',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1449
('Dubravec',42244,'Klenovnik','VARAŽDINSKA',now(),now(),1),
#1450
('Dubravica',10293,'Dubravica','ZAGREBAČKA',now(),now(),1),
#1451
('Dubravica',20350,'Metković','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1452
('Dubravica',20233,'Trsteno','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1453
('Dubravica Desinićka',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1454
('Dubravice',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#1455
('Dubravka',20216,'Dubravka','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1456
('Dubravski Markovac',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#1457
('Dubrovčan/dio/ 130-dalje',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1458
('Dubrovčan/dio/1-130',49214,'Veliko Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1459
('Dubrovnik',20000,'Dubrovnik','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1460
('Dučići',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#1461
('Duće',21310,'Omiš','SPLITSKO-DALMATINSKA',now(),now(),1),
#1462
('Duće',21315,'Dugi Rat','SPLITSKO-DALMATINSKA',now(),now(),1),
#1463
('Duga Gora',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#1464
('Duga Luka',52220,'Labin','ISTARSKA',now(),now(),1),
#1465
('Duga Međa',33513,'Zdenci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1466
('Duga Resa',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#1467
('Duga Rijeka',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1468
('Dugače',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#1469
('Duge Njive',21276,'Vrgorac','SPLITSKO-DALMATINSKA',now(),now(),1),
#1470
('Dugi Dol',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#1471
('Dugi Rat',21315,'Dugi Rat','SPLITSKO-DALMATINSKA',now(),now(),1),
#1472
('Dugnjevec',49295,'Kumrovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1473
('Dugo Selo',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#1474
('Dugo Selo',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1475
('Dugo Selo Lukačko',33406,'Lukač','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1476
('Dugobabe',21202,'Lećevica','SPLITSKO-DALMATINSKA',now(),now(),1),
#1477
('Dugopolje',21204,'Dugopolje','SPLITSKO-DALMATINSKA',now(),now(),1),
#1478
('Dugopolje',23445,'Srb','ZADARSKA',now(),now(),1),
#1479
('Duhovi',43507,'Uljanik','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1480
('Dujmić Selo',47307,'Gornje Zagorje','KARLOVAČKA',now(),now(),1),
#1481
('Dujmići',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#1482
('Dukovec',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1483
('Dulepska',10341,'Lonjica','ZAGREBAČKA',now(),now(),1),
#1484
('Dumače',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1485
('Dumovec',10361,'Sesvete-Kraljevec','GRAD ZAGREB',now(),now(),1),
#1486
('Dunave',20216,'Dubravka','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1487
('Dunjak',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#1488
('Dunjkovec',40305,'Nedelišće','MEĐIMURSKA',now(),now(),1),
#1489
('Dupci',21255,'Zadvarje','SPLITSKO-DALMATINSKA',now(),now(),1),
#1490
('Duričići',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#1491
('Durlinci',47282,'Kamanje','KARLOVAČKA',now(),now(),1),
#1492
('Dusina',21277,'Veliki Prolog','SPLITSKO-DALMATINSKA',now(),now(),1),
#1493
('Duzluk',33515,'Orahovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1494
('Dužica',44272,'Lekenik','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1495
('Dvor',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1496
('Dvoranci',10451,'Pisarovina','ZAGREBAČKA',now(),now(),1),
#1497
('Dvori',52464,'Kaštelir (Castelliere)','ISTARSKA',now(),now(),1),
#1498
('Dvorišće',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#1499
('Dvorišće',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1500
('Dvorišće Ozaljsko',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#1501
('Dvorišće Vivodinsko',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#1502
('Dvorište',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#1503
('Dvorjanci',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#1504
('Dvornica',22203,'Rogoznica','ŠIBENSKO-KNINSKA',now(),now(),1),
#1505
('Dvorska',33410,'Suhopolje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1506
('Džaperovac',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#1507
('Đakovo',31400,'Đakovo','OSJEČKO-BARANJSKA',now(),now(),1),
#1508
('Đelekovec',48316,'Đelekovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1509
('Đeletovci',32244,'Đeletovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#1510
('Đeverske',22305,'Kistanje','ŠIBENSKO-KNINSKA',now(),now(),1),
#1511
('Đivan',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#1512
('Đuba',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#1513
('Đulovac',43532,'Đulovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1514
('Đurđanci',32284,'Stari Mikanovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#1515
('Đurđekovec',10362,'Kašina','GRAD ZAGREB',now(),now(),1),
#1516
('Đurđenovac',31511,'Đurđenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#1517
('Đurđevac',48350,'Đurđevac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1518
('Đurđic',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1519
('Đurđic',43231,'Ivanska','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1520
('Đuričići',33522,'Voćin','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1521
('Đurići',32263,'Đurići','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#1522
('Đurin Potok',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#1523
('Đurinići',20218,'Pločice','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1524
('Đurinovec',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#1525
('Đurmanec',49225,'Đurmanec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1526
('Eminovci',34308,'Jakšić','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1527
('Emovački Lug',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1528
('Ercegovci',21232,'Dicmo','SPLITSKO-DALMATINSKA',now(),now(),1),
#1529
('Erdelj',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#1530
('Erdovec',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1531
('Erdut',31206,'Erdut','OSJEČKO-BARANJSKA',now(),now(),1),
#1532
('Erkovčići',52425,'Roč','ISTARSKA',now(),now(),1),
#1533
('Ernestinovo',31215,'Ernestinovo','OSJEČKO-BARANJSKA',now(),now(),1),
#1534
('Ertić',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#1535
('Ervenik',22305,'Kistanje','ŠIBENSKO-KNINSKA',now(),now(),1),
#1536
('Ervenik Zlatarski/dio/ 1-6 i 37-dalje',49247,'Zlatar Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1537
('Ervenik Zlatarski/dio/7-36',49250,'Zlatar','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1538
('Fabci',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#1539
('Fajerovec',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1540
('Falašćak',10435,'Sveti Martin pod Okićem','ZAGREBAČKA',now(),now(),1),
#1541
('Falinić Breg',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#1542
('Farini',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#1543
('Farkaševac',10344,'Farkaševac','ZAGREBAČKA',now(),now(),1),
#1544
('Farkaševec Samoborski',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#1545
('Fažana',52212,'Fažana (Fasana)','ISTARSKA',now(),now(),1),
#1546
('Fažonci',51303,'Plešce','PRIMORSKO-GORANSKA',now(),now(),1),
#1547
('Ferbežari',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#1548
('Ferdinandovac',48356,'Ferdinandovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1549
('Ferenci',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#1550
('Ferenci',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#1551
('Ferežani',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1552
('Feričanci',31512,'Feričanci','OSJEČKO-BARANJSKA',now(),now(),1),
#1553
('Ferketinec',40315,'Mursko Središče','MEĐIMURSKA',now(),now(),1),
#1554
('Ferovac',34340,'Kutjevo','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1555
('Festinec',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#1556
('Filipana',52206,'Marčana','ISTARSKA',now(),now(),1),
#1557
('Filipi',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#1558
('Filipići',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#1559
('Filipini',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#1560
('Filipovac',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1561
('Filipovići',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#1562
('Filozići',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#1563
('Finčevec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1564
('Finida',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#1565
('Fiorini',52474,'Brtonigla (Verteneglio)','ISTARSKA',now(),now(),1),
#1566
('Flengi',52450,'Vrsar (Orsera)','ISTARSKA',now(),now(),1),
#1567
('Florijan',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1568
('Fodrovac Riječki',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1569
('Foli',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#1570
('Forčići',52425,'Roč','ISTARSKA',now(),now(),1),
#1571
('Forkuševci',31402,'Semeljci','OSJEČKO-BARANJSKA',now(),now(),1),
#1572
('Fotez Breg',42245,'Donja Voća','VARAŽDINSKA',now(),now(),1),
#1573
('Frančići',52220,'Labin','ISTARSKA',now(),now(),1),
#1574
('Franovići',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#1575
('Franjetići',47201,'Draganići','KARLOVAČKA',now(),now(),1),
#1576
('Frata',52465,'Tar (Torre)','ISTARSKA',now(),now(),1),
#1577
('Fratrovci',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#1578
('Fratrovci Ozaljski',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#1579
('Frkanovec',40311,'Lopatinec','MEĐIMURSKA',now(),now(),1),
#1580
('Frkašić',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#1581
('Frketić Selo',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#1582
('Frkljevci',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1583
('Frkuljevec Mihovljanski',49252,'Mihovljan','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1584
('Frkuljevec Peršaveški',49251,'Mače','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1585
('Frnjolići',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#1586
('Fučkovac',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#1587
('Fuka',10343,'Nova Kapela','ZAGREBAČKA',now(),now(),1),
#1588
('Funtana',52452,'Funtana (Fontane)','ISTARSKA',now(),now(),1),
#1589
('Furjanići',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#1590
('Fuškulin',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#1591
('Fužine',51322,'Fužine','PRIMORSKO-GORANSKA',now(),now(),1),
#1592
('Gabajeva Greda',48323,'Hlebine','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1593
('Gaber',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1594
('Gabonjin',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#1595
('Gaboš',32212,'Gaboš','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#1596
('Gabrili',20213,'Čilipi','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1597
('Gabrilovac',31511,'Đurđenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#1598
('Gabrovec',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1599
('Gačice',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#1600
('Gaćelezi',22215,'Zaton','ŠIBENSKO-KNINSKA',now(),now(),1),
#1601
('Gaćeša Selo',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#1602
('Gaćeško Selo',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#1603
('Gaćište',33410,'Suhopolje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1604
('Gage',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1605
('Gaj',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#1606
('Gaj',34543,'Poljana','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1607
('Gajac-dio',23251,'Kolan','ZADARSKA',now(),now(),1),
#1608
('Gajac-dio',53291,'Novalja','LIČKO-SENJSKA',now(),now(),1),
#1609
('Gajana',52215,'Vodnjan (Dignano)','ISTARSKA',now(),now(),1),
#1610
('Gajec',10362,'Kašina','GRAD ZAGREB',now(),now(),1),
#1611
('Gajić',31305,'Draž','OSJEČKO-BARANJSKA',now(),now(),1),
#1612
('Gajine',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#1613
('Gala',21241,'Obrovac Sinjski','SPLITSKO-DALMATINSKA',now(),now(),1),
#1614
('Galezova Draga',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#1615
('Galgovo',10435,'Sveti Martin pod Okićem','ZAGREBAČKA',now(),now(),1),
#1616
('Galin',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#1617
('Galižana',52216,'Galižana (Gallesano)','ISTARSKA',now(),now(),1),
#1618
('Galovac',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1619
('Galovac',23222,'Zemunik','ZADARSKA',now(),now(),1),
#1620
('Galovec',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1621
('Galovec Začretski 1-61,63-dalje',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1622
('Galovec Začretski kbr. 62',49224,'Lepajci','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1623
('Galović Selo',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#1624
('Gambetići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#1625
('Gamboci',52460,'Buje (Buie)','ISTARSKA',now(),now(),1),
#1626
('Garbina',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#1627
('Garčin',35212,'Garčin','BRODSKO-POSAVSKA',now(),now(),1),
#1628
('Gardinovec',40319,'Belica','MEĐIMURSKA',now(),now(),1),
#1629
('Gardun',21240,'Trilj','SPLITSKO-DALMATINSKA',now(),now(),1),
#1630
('Garešnica',43280,'Garešnica','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1631
('Garešnički Brestovac',43280,'Garešnica','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1632
('Garica',51516,'Vrbnik','PRIMORSKO-GORANSKA',now(),now(),1),
#1633
('Garjak',21236,'Vrlika','SPLITSKO-DALMATINSKA',now(),now(),1),
#1634
('Gašinci',31421,'Satnica Đakovačka','OSJEČKO-BARANJSKA',now(),now(),1),
#1635
('Gašparci',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#1636
('Gat',31554,'Gat','OSJEČKO-BARANJSKA',now(),now(),1),
#1637
('Gata',21253,'Gata','SPLITSKO-DALMATINSKA',now(),now(),1),
#1638
('Gazije',31512,'Feričanci','OSJEČKO-BARANJSKA',now(),now(),1),
#1639
('Gdinj',21467,'Gdinj','SPLITSKO-DALMATINSKA',now(),now(),1),
#1640
('Gečkovec',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#1641
('Gedići',52446,'Nova Vas','ISTARSKA',now(),now(),1),
#1642
('Gejkovac',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#1643
('Generalski Stol',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#1644
('Gerovo',51304,'Gerovo','PRIMORSKO-GORANSKA',now(),now(),1),
#1645
('Gerovo Tounjsko',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#1646
('Gerovski Kraj',51304,'Gerovo','PRIMORSKO-GORANSKA',now(),now(),1),
#1647
('Gezinci',31530,'Podravska Moslavina','OSJEČKO-BARANJSKA',now(),now(),1),
#1648
('Giletinci',35404,'Cernik','BRODSKO-POSAVSKA',now(),now(),1),
#1649
('Gizdavac',21247,'Neorić','SPLITSKO-DALMATINSKA',now(),now(),1),
#1650
('Gladovec Kravarski',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#1651
('Gladovec Pokupski',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#1652
('Glavace',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#1653
('Glavani',52207,'Barban','ISTARSKA',now(),now(),1),
#1654
('Glavani',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#1655
('Glavat',20290,'Lastovo','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1656
('Glavica',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#1657
('Glavica',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1658
('Glavice',21230,'Sinj','SPLITSKO-DALMATINSKA',now(),now(),1),
#1659
('Glavičani',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1660
('Glavina Donja',21260,'Imotski','SPLITSKO-DALMATINSKA',now(),now(),1),
#1661
('Glavina Gornja',21260,'Imotski','SPLITSKO-DALMATINSKA',now(),now(),1),
#1662
('Glavnica Donja',10363,'Belovar','GRAD ZAGREB',now(),now(),1),
#1663
('Glavnica Gornja',10363,'Belovar','GRAD ZAGREB',now(),now(),1),
#1664
('Glavničica',10361,'Sesvete-Kraljevec','GRAD ZAGREB',now(),now(),1),
#1665
('Glibodol',53261,'Križpolje','LIČKO-SENJSKA',now(),now(),1),
#1666
('Glina',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1667
('Glinice',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#1668
('Glinska Poljana',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1669
('Glinsko Vrelo',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1670
('Globočec',49246,'Marija Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1671
('Globočec Ludbreški',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#1672
('Glogovac',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1673
('Glogovec Zagorski',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1674
('Glogovica',35201,'Podcrkavlje','BRODSKO-POSAVSKA',now(),now(),1),
#1675
('Glogovo',23440,'Gračac','ZADARSKA',now(),now(),1),
#1676
('Glušci',20350,'Metković','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1677
('Glušinja',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#1678
('Gljev',21241,'Obrovac Sinjski','SPLITSKO-DALMATINSKA',now(),now(),1),
#1679
('Gnojnice',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#1680
('Godinjak',35422,'Zapolje','BRODSKO-POSAVSKA',now(),now(),1),
#1681
('Gojak',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#1682
('Gojanec',42205,'Vidovec','VARAŽDINSKA',now(),now(),1),
#1683
('Gojkovac',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#1684
('Gojlo',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1685
('Gola',48331,'Gola','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1686
('Golaš',52211,'Bale (Valle)','ISTARSKA',now(),now(),1),
#1687
('Golenić',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1688
('Goleši Žumberački',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#1689
('Goli Breg',10257,'Brezovica','GRAD ZAGREB',now(),now(),1),
#1690
('Goli Vrh',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#1691
('Goli Vrh',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#1692
('Goli Vrh Lipnički',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#1693
('Goli Vrh Netretički',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#1694
('Goli Vrh Ozaljski',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#1695
('Golik',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#1696
('Goliki',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1697
('Golinci',31543,'Miholjački Poreč','OSJEČKO-BARANJSKA',now(),now(),1),
#1698
('Golinja',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1699
('Golo Brdo',34334,'Kaptol','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1700
('Golo Brdo',33000,'Virovitica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1701
('Golobrdac',35404,'Cernik','BRODSKO-POSAVSKA',now(),now(),1),
#1702
('Golobrdci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1703
('Gologorica',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#1704
('Gologorički Dol',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#1705
('Golovik',51418,'Brseč','PRIMORSKO-GORANSKA',now(),now(),1),
#1706
('Golubić',22301,'Golubić','ŠIBENSKO-KNINSKA',now(),now(),1),
#1707
('Golubić',23450,'Obrovac','ZADARSKA',now(),now(),1),
#1708
('Golubići',52427,'Livade (Levade)','ISTARSKA',now(),now(),1),
#1709
('Golubići',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#1710
('Golubnjak',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1711
('Golubovac Divuški',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1712
('Goljak',47201,'Draganići','KARLOVAČKA',now(),now(),1),
#1713
('Goljak',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#1714
('Goljak Klanječki',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1715
('Gomirje',51327,'Gomirje','PRIMORSKO-GORANSKA',now(),now(),1),
#1716
('Gondolići',52220,'Labin','ISTARSKA',now(),now(),1),
#1717
('Gonjeva',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#1718
('Gora',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1719
('Gora Glušići',52220,'Labin','ISTARSKA',now(),now(),1),
#1720
('Gora Košnička',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1721
('Gora Veternička',49255,'Novi Golubovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1722
('Gorači',51306,'Čabar','PRIMORSKO-GORANSKA',now(),now(),1),
#1723
('Goranec',10360,'Sesvete','GRAD ZAGREB',now(),now(),1),
#1724
('Goranec',42244,'Klenovnik','VARAŽDINSKA',now(),now(),1),
#1725
('Gorani',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#1726
('Gorenci',51328,'Lukovdol','PRIMORSKO-GORANSKA',now(),now(),1),
#1727
('Gorica',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1728
('Gorica',52341,'Žminj','ISTARSKA',now(),now(),1),
#1729
('Gorica',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#1730
('Gorica',23222,'Zemunik','ZADARSKA',now(),now(),1),
#1731
('Gorica',23249,'Povljana','ZADARSKA',now(),now(),1),
#1732
('Gorica Jamnička',10451,'Pisarovina','ZAGREBAČKA',now(),now(),1),
#1733
('Gorica Lipnička',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#1734
('Gorica Miholečka',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1735
('Gorica Skradska',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#1736
('Gorica Svetojanska',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#1737
('Gorica Valpovačka',31550,'Valpovo','OSJEČKO-BARANJSKA',now(),now(),1),
#1738
('Gorice',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#1739
('Gorice',35428,'Dragalić','BRODSKO-POSAVSKA',now(),now(),1),
#1740
('Goričan',40324,'Goričan','MEĐIMURSKA',now(),now(),1),
#1741
('Goričanec',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#1742
('Goričanovec (dio) 1-68',49225,'Đurmanec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1743
('Goričanovec (dio) 69-dalje',49234,'Petrovsko','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1744
('Goričica',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#1745
('Goričice Dobranske',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#1746
('Goričine',51242,'Drivenik','PRIMORSKO-GORANSKA',now(),now(),1),
#1747
('Gorička',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1748
('Goričko',48311,'Kunovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1749
('Gorići',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#1750
('Gorinci',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#1751
('Goriš',22221,'Lozovac','ŠIBENSKO-KNINSKA',now(),now(),1),
#1752
('Gorjakovo',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1753
('Gorjani',31422,'Gorjani','OSJEČKO-BARANJSKA',now(),now(),1),
#1754
('Gorjani Sutinski',49232,'Radoboj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1755
('Gorkovec',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1756
('Gorniki Vivodinski',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#1757
('Gornja Bačuga',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1758
('Gornja Batina',49254,'Belec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1759
('Gornja Bebrina',35208,'Ruščica','BRODSKO-POSAVSKA',now(),now(),1),
#1760
('Gornja Bistra',10298,'Donja Bistra','ZAGREBAČKA',now(),now(),1),
#1761
('Gornja Brckovčina',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1762
('Gornja Brela',21255,'Zadvarje','SPLITSKO-DALMATINSKA',now(),now(),1),
#1763
('Gornja Brusovača',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#1764
('Gornja Bučica',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1765
('Gornja Čemernica',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1766
('Gornja Dobra',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#1767
('Gornja Drenova',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#1768
('Gornja Dubrava',40306,'Macinec','MEĐIMURSKA',now(),now(),1),
#1769
('Gornja Garešnica',43233,'Trnovitički Popovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1770
('Gornja Glina',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1771
('Gornja Glogovnica',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1772
('Gornja Gračenica',44318,'Voloder','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1773
('Gornja Greda',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#1774
('Gornja Jagodnja',23423,'Polača','ZADARSKA',now(),now(),1),
#1775
('Gornja Jelenska',44317,'Popovača','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1776
('Gornja Konjščina',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1777
('Gornja Kovačica',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1778
('Gornja Krašićevica',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#1779
('Gornja Kupčina',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#1780
('Gornja Lamana Draga',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1781
('Gornja Letina',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1782
('Gornja Lomnica',10412,'Donja Lomnica','ZAGREBAČKA',now(),now(),1),
#1783
('Gornja Meminska',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1784
('Gornja Mlinoga',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1785
('Gornja Močila',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#1786
('Gornja Motičina',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#1787
('Gornja Nugla',52425,'Roč','ISTARSKA',now(),now(),1),
#1788
('Gornja Obreška',10312,'Kloštar Ivanić','ZAGREBAČKA',now(),now(),1),
#1789
('Gornja Obrijež',34552,'Badljevina','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1790
('Gornja Oraovica',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1791
('Gornja Pačetina 1-85',49224,'Lepajci','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1792
('Gornja Pačetina 86-dalje',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1793
('Gornja Pastuša',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1794
('Gornja Petrička',43232,'Berek','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1795
('Gornja Pištana',33515,'Orahovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1796
('Gornja Plemenšćina',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1797
('Gornja Ploča',53244,'Lovinac','LIČKO-SENJSKA',now(),now(),1),
#1798
('Gornja Ploščica',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1799
('Gornja Podgora',49240,'Donja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1800
('Gornja Podstrana',21312,'Podstrana','SPLITSKO-DALMATINSKA',now(),now(),1),
#1801
('Gornja Poljana',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#1802
('Gornja Purgarija',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#1803
('Gornja Pušća',10294,'Donja Pušća','ZAGREBAČKA',now(),now(),1),
#1804
('Gornja Rašenica',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1805
('Gornja Reka',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#1806
('Gornja Rijeka',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1807
('Gornja Selnica',49254,'Belec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1808
('Gornja Stranica',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#1809
('Gornja Stubica',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1810
('Gornja Stupnica',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1811
('Gornja Šemnica',49232,'Radoboj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1812
('Gornja Šumetlica',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1813
('Gornja Šušnjara',43246,'Štefanje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1814
('Gornja Topličica',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#1815
('Gornja Trebinja',47241,'Cerovac Vukmanički','KARLOVAČKA',now(),now(),1),
#1816
('Gornja Trnovitica',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1817
('Gornja Trstenica',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1818
('Gornja Vas',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#1819
('Gornja Velešnja',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1820
('Gornja Velika',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#1821
('Gornja Velika',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1822
('Gornja Visočka',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1823
('Gornja Višnjica',42255,'Donja Višnjica','VARAŽDINSKA',now(),now(),1),
#1824
('Gornja Vlahinićka',44316,'Velika Ludina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1825
('Gornja Voća',42245,'Donja Voća','VARAŽDINSKA',now(),now(),1),
#1826
('Gornja Vrba',35207,'Gornja Vrba','BRODSKO-POSAVSKA',now(),now(),1),
#1827
('Gornja Vrijeska',43531,'Veliki Bastaji','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1828
('Gornja Vrućica',20240,'Trpanj','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1829
('Gornja Zdenčina',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#1830
('Gornja Žrvnica',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#1831
('Gornjaki',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#1832
('Gornjaki',49283,'Hraščina-Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1833
('Gornje Bazje',33407,'Gornje Bazje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1834
('Gornje Biljane',23420,'Benkovac','ZADARSKA',now(),now(),1),
#1835
('Gornje Brezno',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1836
('Gornje Bukovlje',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#1837
('Gornje Ceranje',23420,'Benkovac','ZADARSKA',now(),now(),1),
#1838
('Gornje Cjepidlake',43532,'Đulovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1839
('Gornje Dubrave',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#1840
('Gornje Dvorišće',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#1841
('Gornje Gnojnice',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#1842
('Gornje Igrane',21327,'Podgora','SPLITSKO-DALMATINSKA',now(),now(),1),
#1843
('Gornje Jame',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1844
('Gornje Jesenje',49233,'Gornje Jesenje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1845
('Gornje Komarevo',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1846
('Gornje Kusonje',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1847
('Gornje Ladanje',42207,'Vinica','VARAŽDINSKA',now(),now(),1),
#1848
('Gornje Makojišće',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#1849
('Gornje Mokrice',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1850
('Gornje Mrzlo Polje Mrežničko',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#1851
('Gornje Obuljeno',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1852
('Gornje Ogorje',21206,'Donje Ogorje','SPLITSKO-DALMATINSKA',now(),now(),1),
#1853
('Gornje Orešje',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#1854
('Gornje Planjane',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#1855
('Gornje Podotočje',10419,'Vukovina','ZAGREBAČKA',now(),now(),1),
#1856
('Gornje Pokupje',47286,'Mahično','KARLOVAČKA',now(),now(),1),
#1857
('Gornje Postinje',21203,'Donji Muć','SPLITSKO-DALMATINSKA',now(),now(),1),
#1858
('Gornje Predrijevo',33523,'Čađavica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1859
('Gornje Prekrižje',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#1860
('Gornje Prilišće',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#1861
('Gornje Primišlje',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1862
('Gornje Psarjevo',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#1863
('Gornje Raštane',23207,'Sveti Filip i Jakov','ZADARSKA',now(),now(),1),
#1864
('Gornje Selište',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1865
('Gornje Selo',21432,'Stomorska','SPLITSKO-DALMATINSKA',now(),now(),1),
#1866
('Gornje Sitno',21251,'Žrnovnica','SPLITSKO-DALMATINSKA',now(),now(),1),
#1867
('Gornje Stative',47000,'Karlovac','KARLOVAČKA',now(),now(),1),
#1868
('Gornje Taborište',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1869
('Gornje Taborište',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1870
('Gornje Tihovo',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#1871
('Gornje Utore',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#1872
('Gornje Viljevo',33518,'Nova Bukovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1873
('Gornje Vinovo',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#1874
('Gornje Vratno',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#1875
('Gornje Vrhovine',53223,'Vrhovine','LIČKO-SENJSKA',now(),now(),1),
#1876
('Gornje Zagorje',47307,'Gornje Zagorje','KARLOVAČKA',now(),now(),1),
#1877
('Gornje Zdjelice',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1878
('Gornji Andrijevci',35252,'Sibinj','BRODSKO-POSAVSKA',now(),now(),1),
#1879
('Gornji Babin Potok',53223,'Vrhovine','LIČKO-SENJSKA',now(),now(),1),
#1880
('Gornji Bitelić',21233,'Hrvace','SPLITSKO-DALMATINSKA',now(),now(),1),
#1881
('Gornji Bjelovac',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1882
('Gornji Bogićevci',35429,'Gornji Bogićevci','BRODSKO-POSAVSKA',now(),now(),1),
#1883
('Gornji Borki',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1884
('Gornji Budački',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#1885
('Gornji Bukovac Žakanjski',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#1886
('Gornji Cerovac',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1887
('Gornji Cerovljani',44450,'Hrvatska Dubica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1888
('Gornji Crnogovci',35422,'Zapolje','BRODSKO-POSAVSKA',now(),now(),1),
#1889
('Gornji Čagalić',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1890
('Gornji Čehi',10020,'Zagreb-Novi Zagreb','GRAD ZAGREB',now(),now(),1),
#1891
('Gornji Čemehovec',49294,'Kraljevec na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1892
('Gornji Daruvar',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1893
('Gornji Desinec',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#1894
('Gornji Dobretin',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1895
('Gornji Dolac',21205,'Donji Dolac','SPLITSKO-DALMATINSKA',now(),now(),1),
#1896
('Gornji Draganec',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1897
('Gornji Dragičevci',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1898
('Gornji Dragonožec',10253,'Donji Dragonožec','GRAD ZAGREB',now(),now(),1),
#1899
('Gornji Dubovec',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1900
('Gornji Emovci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1901
('Gornji Fodrovec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1902
('Gornji Furjan',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1903
('Gornji Grahovljani',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1904
('Gornji Gučani',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1905
('Gornji Hrastovac',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1906
('Gornji Hrašćan',40306,'Macinec','MEĐIMURSKA',now(),now(),1),
#1907
('Gornji Hruševec',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#1908
('Gornji Humac',21424,'Pražnica','SPLITSKO-DALMATINSKA',now(),now(),1),
#1909
('Gornji Jalšovec',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1910
('Gornji Javoranj',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1911
('Gornji Karin',23452,'Karin','ZADARSKA',now(),now(),1),
#1912
('Gornji Klasnić',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1913
('Gornji Kneginec',42204,'Turčin','VARAŽDINSKA',now(),now(),1),
#1914
('Gornji Koncovčak',40313,'Sveti Martin na Muri','MEĐIMURSKA',now(),now(),1),
#1915
('Gornji Kosinj',53203,'Kosinj','LIČKO-SENJSKA',now(),now(),1),
#1916
('Gornji Kraljevec',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1917
('Gornji Kraljevec',40315,'Mursko Središče','MEĐIMURSKA',now(),now(),1),
#1918
('Gornji Kremen',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1919
('Gornji Kućan',42000,'Varaždin','VARAŽDINSKA',now(),now(),1),
#1920
('Gornji Kukuruzari',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1921
('Gornji Kuršanec',40305,'Nedelišće','MEĐIMURSKA',now(),now(),1),
#1922
('Gornji Kuti',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1923
('Gornji Laduč',10292,'Šenkovec','ZAGREBAČKA',now(),now(),1),
#1924
('Gornji Lađevac',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1925
('Gornji Lapac',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#1926
('Gornji Lipovac',35410,'Nova Kapela','BRODSKO-POSAVSKA',now(),now(),1),
#1927
('Gornji Lipovčani',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1928
('Gornji Lović',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#1929
('Gornji Ložac',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#1930
('Gornji Macelj',49225,'Đurmanec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1931
('Gornji Marinkovac',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#1932
('Gornji Martijanec',42232,'Donji Martijanec','VARAŽDINSKA',now(),now(),1),
#1933
('Gornji Maslarac',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1934
('Gornji Meljani',33522,'Voćin','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1935
('Gornji Mihaljevec',40306,'Macinec','MEĐIMURSKA',now(),now(),1),
#1936
('Gornji Miholjac',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#1937
('Gornji Miklouš',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1938
('Gornji Mosti',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1939
('Gornji Muć',21203,'Donji Muć','SPLITSKO-DALMATINSKA',now(),now(),1),
#1940
('Gornji Nikšić',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1941
('Gornji Okrug',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#1942
('Gornji Oštrc',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#1943
('Gornji Oštri Vrh Ozaljski',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#1944
('Gornji Poloj',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#1945
('Gornji Popovac',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#1946
('Gornji Prnjarovec',10314,'Križ','ZAGREBAČKA',now(),now(),1),
#1947
('Gornji Proložac',21264,'Donji Proložac','SPLITSKO-DALMATINSKA',now(),now(),1),
#1948
('Gornji Rogolji',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#1949
('Gornji Selkovac',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1950
('Gornji Sjeničak',47212,'Skakavac','KARLOVAČKA',now(),now(),1),
#1951
('Gornji Skrad',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#1952
('Gornji Slatinik',35201,'Podcrkavlje','BRODSKO-POSAVSKA',now(),now(),1),
#1953
('Gornji Sređani',43506,'Dežanovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1954
('Gornji Stupnik',10255,'Gornji Stupnik','ZAGREBAČKA',now(),now(),1),
#1955
('Gornji Sušobreg 97-140',49246,'Marija Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1956
('Gornji Šajn',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1957
('Gornji Šehovac',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1958
('Gornji Škrnik',49296,'Zagorska Sela','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1959
('Gornji Štrbci',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#1960
('Gornji Tkalec',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1961
('Gornji Tomaš',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1962
('Gornji Trupci',10253,'Donji Dragonožec','GRAD ZAGREB',now(),now(),1),
#1963
('Gornji Turni',51300,'Delnice','PRIMORSKO-GORANSKA',now(),now(),1),
#1964
('Gornji Uljanik',43507,'Uljanik','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1965
('Gornji Vaganac',53233,'Ličko Petrovo Selo','LIČKO-SENJSKA',now(),now(),1),
#1966
('Gornji Varoš',35435,'Stara Gradiška','BRODSKO-POSAVSKA',now(),now(),1),
#1967
('Gornji Velemerić',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#1968
('Gornji Viduševac',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1969
('Gornji Vinkovec',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#1970
('Gornji Vinjani',21260,'Imotski','SPLITSKO-DALMATINSKA',now(),now(),1),
#1971
('Gornji Vrhovci',34330,'Velika','POŽEŠKO-SLAVONSKA',now(),now(),1),
#1972
('Gornji Vučkovići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1973
('Gornji Vukašinac',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#1974
('Gornji Vukojevac',44272,'Lekenik','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1975
('Gornji Vukšići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1976
('Gornji Zagon',51251,'Ledenice','PRIMORSKO-GORANSKA',now(),now(),1),
#1977
('Gornji Zatezali',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#1978
('Gornji Zbilj',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1979
('Gornji Zebanec',40314,'Selnica','MEĐIMURSKA',now(),now(),1),
#1980
('Gornji Zvečaj',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#1981
('Gornji Žagari',51306,'Čabar','PRIMORSKO-GORANSKA',now(),now(),1),
#1982
('Gornji Žirovac',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#1983
('Goršćaki',47286,'Mahično','KARLOVAČKA',now(),now(),1),
#1984
('Goršćaki Ozaljski',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#1985
('Goršeti',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#1986
('Goruševnjak',42207,'Vinica','VARAŽDINSKA',now(),now(),1),
#1987
('Gospić',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#1988
('Gostenje',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1989
('Gostinjac',51514,'Dobrinj','PRIMORSKO-GORANSKA',now(),now(),1),
#1990
('Gostović',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#1991
('Gošić',22305,'Kistanje','ŠIBENSKO-KNINSKA',now(),now(),1),
#1992
('Gotalovac',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#1993
('Gotalovo',48331,'Gola','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#1994
('Goveđari',20226,'Goveđari','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#1995
('Goveđe Polje',43506,'Dežanovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#1996
('Grab',23440,'Gračac','ZADARSKA',now(),now(),1),
#1997
('Grab',21242,'Grab','SPLITSKO-DALMATINSKA',now(),now(),1),
#1998
('Grabarak',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#1999
('Grabarje',34312,'Sesvete (kod Požege)','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2000
('Grabarje',35201,'Podcrkavlje','BRODSKO-POSAVSKA',now(),now(),1),
#2001
('Grabarska',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#2002
('Grabe',49228,'Brestovec Orehovički','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2003
('Graberanec',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#2004
('Graberec',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#2005
('Graberje',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2006
('Graberje Ivaničko',10313,'Graberje Ivaničko','ZAGREBAČKA',now(),now(),1),
#2007
('Grabersko Brdo',10313,'Graberje Ivaničko','ZAGREBAČKA',now(),now(),1),
#2008
('Graberščak',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2009
('Grabić',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2010
('Grabik',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2011
('Graboštani',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2012
('Grabovac',31309,'Kneževi Vinogradi','OSJEČKO-BARANJSKA',now(),now(),1),
#2013
('Grabovac',23242,'Posedarje','ZADARSKA',now(),now(),1),
#2014
('Grabovac',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#2015
('Grabovac',21271,'Grabovac','SPLITSKO-DALMATINSKA',now(),now(),1),
#2016
('Grabovac Banski',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2017
('Grabovac Drežnički',47246,'Drežnik Grad','KARLOVAČKA',now(),now(),1),
#2018
('Grabovac Krnjački',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#2019
('Grabovac Vojnićki',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#2020
('Grabovci',22215,'Zaton','ŠIBENSKO-KNINSKA',now(),now(),1),
#2021
('Grabovica',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2022
('Grabovnica',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2023
('Grabovo',32232,'Sotin','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#2024
('Grabričina',44316,'Velika Ludina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2025
('Grabrić',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#2026
('Grabrk',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#2027
('Grabrov Potok',44316,'Velika Ludina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2028
('Grabrova',51417,'Mošćenička Draga','PRIMORSKO-GORANSKA',now(),now(),1),
#2029
('Grabrovec',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2030
('Grabrovnica',33405,'Pitomača','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2031
('Grabrovnik',40312,'Štrigova','MEĐIMURSKA',now(),now(),1),
#2032
('Grabušić',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#2033
('Gračac',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#2034
('Gračac',23440,'Gračac','ZADARSKA',now(),now(),1),
#2035
('Gračac Slavetički',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#2036
('Gračanica Šišinečka',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2037
('Gračec',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#2038
('Gračina',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2039
('Gračišće',52403,'Gračišće','ISTARSKA',now(),now(),1),
#2040
('Gradac',22322,'Ružić','ŠIBENSKO-KNINSKA',now(),now(),1),
#2041
('Gradac',21330,'Gradac','SPLITSKO-DALMATINSKA',now(),now(),1),
#2042
('Gradac',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#2043
('Gradac',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2044
('Gradac Našički',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#2045
('Gradac Orlovac',47000,'Karlovac','KARLOVAČKA',now(),now(),1),
#2046
('Gradec',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#2047
('Gradec Pokupski',10451,'Pisarovina','ZAGREBAČKA',now(),now(),1),
#2048
('Gradečki Pavlovec',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#2049
('Gradići',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#2050
('Gradina',22221,'Lozovac','ŠIBENSKO-KNINSKA',now(),now(),1),
#2051
('Gradina',20270,'Vela Luka','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2052
('Gradina',52450,'Vrsar (Orsera)','ISTARSKA',now(),now(),1),
#2053
('Gradina',33411,'Gradina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2054
('Gradina Korenička',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#2055
('Gradinje',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#2056
('Gradinje',52427,'Livade (Levade)','ISTARSKA',now(),now(),1),
#2057
('Gradiščak',40313,'Sveti Martin na Muri','MEĐIMURSKA',now(),now(),1),
#2058
('Gradišće',52341,'Žminj','ISTARSKA',now(),now(),1),
#2059
('Gradišće',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#2060
('Gradište',32273,'Gradište','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#2061
('Gradište',34343,'Bektež','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2062
('Gradna',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#2063
('Gradski Vrhovci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2064
('Gradusa Posavska',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2065
('Gramalj',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#2066
('Grana',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#2067
('Grandić Breg',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#2068
('Grandići',52207,'Barban','ISTARSKA',now(),now(),1),
#2069
('Granice',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#2070
('Graničari',10257,'Brezovica','GRAD ZAGREB',now(),now(),1),
#2071
('Granje',34308,'Jakšić','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2072
('Grbajel',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#2073
('Grbaševec',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2074
('Grbavac',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2075
('Grbavac',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2076
('Grbavac',21312,'Podstrana','SPLITSKO-DALMATINSKA',now(),now(),1),
#2077
('Grbe',23232,'Nin','ZADARSKA',now(),now(),1),
#2078
('Grdak',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2079
('Grdanjci',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#2080
('Grdenci',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2081
('Grdoselo',52000,'Pazin','ISTARSKA',now(),now(),1),
#2082
('Grdun',47281,'Mali Erjavec','KARLOVAČKA',now(),now(),1),
#2083
('Grebaštica',22000,'Šibenik','ŠIBENSKO-KNINSKA',now(),now(),1),
#2084
('Greda',10341,'Lonjica','ZAGREBAČKA',now(),now(),1),
#2085
('Greda',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#2086
('Greda',44273,'Sela','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2087
('Greda Breška',10310,'Ivanić-Grad','ZAGREBAČKA',now(),now(),1),
#2088
('Greda Sunjska',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2089
('Gredenec',49234,'Petrovsko','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2090
('Gredice',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2091
('Gređani',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#2092
('Gređani',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2093
('Gregurić Breg',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#2094
('Gregurovec',49252,'Mihovljan','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2095
('Gregurovec',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2096
('Gregurovec',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2097
('Grešćevina',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#2098
('Grganjica',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#2099
('Grgetići',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#2100
('Grgetići',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#2101
('Grginac',43226,'Veliko Trojstvo','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2102
('Grgurevići',35252,'Sibinj','BRODSKO-POSAVSKA',now(),now(),1),
#2103
('Grgurice',23242,'Posedarje','ZADARSKA',now(),now(),1),
#2104
('Grič',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#2105
('Griče',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#2106
('Grimalda',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#2107
('Grižane',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#2108
('Grižići',35252,'Sibinj','BRODSKO-POSAVSKA',now(),now(),1),
#2109
('Grkaveščak',40313,'Sveti Martin na Muri','MEĐIMURSKA',now(),now(),1),
#2110
('Grkine',48350,'Đurđevac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2111
('Grletinec',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2112
('Grljevac',21312,'Podstrana','SPLITSKO-DALMATINSKA',now(),now(),1),
#2113
('Grmov',51556,'Martinšćica','PRIMORSKO-GORANSKA',now(),now(),1),
#2114
('Grmušani',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2115
('Grobnik',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#2116
('Grobnik',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#2117
('Grobnik',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#2118
('Grohot',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2119
('Grohote',21430,'Grohote','SPLITSKO-DALMATINSKA',now(),now(),1),
#2120
('Gromača',20234,'Orašac','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2121
('Gromačnik',35252,'Sibinj','BRODSKO-POSAVSKA',now(),now(),1),
#2122
('Gromin Dolac',21465,'Jelsa','SPLITSKO-DALMATINSKA',now(),now(),1),
#2123
('Grožnjan',52429,'Grožnjan (Grisignana)','ISTARSKA',now(),now(),1),
#2124
('Gršćaki',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#2125
('Grtovec',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2126
('Grubići',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#2127
('Grubine',21262,'Kamenmost','SPLITSKO-DALMATINSKA',now(),now(),1),
#2128
('Grubišno Polje',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2129
('Gruda',20215,'Gruda','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2130
('Grudnjak',33513,'Zdenci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2131
('Gržini',52341,'Žminj','ISTARSKA',now(),now(),1),
#2132
('Gubaševo',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2133
('Gubavčevo Polje',23440,'Gračac','ZADARSKA',now(),now(),1),
#2134
('Guci Draganički',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#2135
('Guće Selo',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#2136
('Gudača',23275,'Ugljan','ZADARSKA',now(),now(),1),
#2137
('Gudalji',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#2138
('Gudci',10412,'Donja Lomnica','ZAGREBAČKA',now(),now(),1),
#2139
('Gudovac',43251,'Gudovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2140
('Gundinci',35222,'Gundinci','BRODSKO-POSAVSKA',now(),now(),1),
#2141
('Gunja',32260,'Gunja','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#2142
('Gunjevci',35422,'Zapolje','BRODSKO-POSAVSKA',now(),now(),1),
#2143
('Gusakovec',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2144
('Gustelnica',10418,'Dubranec','ZAGREBAČKA',now(),now(),1),
#2145
('Gusti Laz',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#2146
('Gustirna',21222,'Marina','SPLITSKO-DALMATINSKA',now(),now(),1),
#2147
('Gušće',44203,'Gušće','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2148
('Gušćerovec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2149
('Gvozd',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2150
('Gvozdanska',33533,'Pivnica Slavonska','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2151
('Gvozdansko',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2152
('Habjanovac',10343,'Nova Kapela','ZAGREBAČKA',now(),now(),1),
#2153
('Habjanovci',31223,'Brođanci','OSJEČKO-BARANJSKA',now(),now(),1),
#2154
('Hađer',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2155
('Haganj',10343,'Nova Kapela','ZAGREBAČKA',now(),now(),1),
#2156
('Hajdine',51326,'Vrbovsko','PRIMORSKO-GORANSKA',now(),now(),1),
#2157
('Hajtić',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2158
('Hambarište',51326,'Vrbovsko','PRIMORSKO-GORANSKA',now(),now(),1),
#2159
('Hampovica',48350,'Đurđevac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2160
('Harina Zlaka',49296,'Zagorska Sela','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2161
('Harkanovci',31227,'Zelčin','OSJEČKO-BARANJSKA',now(),now(),1),
#2162
('Harmica',10292,'Šenkovec','ZAGREBAČKA',now(),now(),1),
#2163
('Hartje',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#2164
('Havidić Selo',10253,'Donji Dragonožec','GRAD ZAGREB',now(),now(),1),
#2165
('Heki',52000,'Pazin','ISTARSKA',now(),now(),1),
#2166
('Hemuševec',40325,'Draškovec','MEĐIMURSKA',now(),now(),1),
#2167
('Heraki',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#2168
('Hercegovac',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2169
('Herešin',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2170
('Hižakovec',49240,'Donja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2171
('Hižanovec',48269,'Kalnik','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2172
('Hladna Voda',48361,'Kalinovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2173
('Hlapa',51514,'Dobrinj','PRIMORSKO-GORANSKA',now(),now(),1),
#2174
('Hlapičina',40313,'Sveti Martin na Muri','MEĐIMURSKA',now(),now(),1),
#2175
('Hlebine',48323,'Hlebine','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2176
('Hlevci',51314,'Ravna Gora','PRIMORSKO-GORANSKA',now(),now(),1),
#2177
('Hlevnica',49225,'Đurmanec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2178
('Hodilje',20230,'Ston','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2179
('Hodinci',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#2180
('Hodošan',40320,'Donji Kraljevec','MEĐIMURSKA',now(),now(),1),
#2181
('Homer',51316,'Lokve','PRIMORSKO-GORANSKA',now(),now(),1),
#2182
('Homoljac',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#2183
('Horvati',10436,'Rakov Potok','ZAGREBAČKA',now(),now(),1),
#2184
('Horvatsko',42244,'Klenovnik','VARAŽDINSKA',now(),now(),1),
#2185
('Hosnik',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#2186
('Hotnja',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#2187
('Hrastelnica',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2188
('Hrastin',31404,'Vladislavci','OSJEČKO-BARANJSKA',now(),now(),1),
#2189
('Hrastina Brdovečka',10299,'Marija Gorica','ZAGREBAČKA',now(),now(),1),
#2190
('Hrastina Samoborska',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#2191
('Hrastje',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#2192
('Hrastje Plešivičko',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#2193
('Hrastova Greda',48361,'Kalinovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2194
('Hrastovac',43280,'Garešnica','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2195
('Hrastovac',31403,'Vuka','OSJEČKO-BARANJSKA',now(),now(),1),
#2196
('Hrastovec Toplički',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#2197
('Hrastovica',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2198
('Hrastovica Vivodinska',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#2199
('Hrastovljan',42232,'Donji Martijanec','VARAŽDINSKA',now(),now(),1),
#2200
('Hrastovsko',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#2201
('Hrašća',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#2202
('Hrašće Turopoljsko',10020,'Zagreb-Novi Zagreb','GRAD ZAGREB',now(),now(),1),
#2203
('Hrašćica',42000,'Varaždin','VARAŽDINSKA',now(),now(),1),
#2204
('Hrašćina',49283,'Hraščina-Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2205
('Hrboki',52207,'Barban','ISTARSKA',now(),now(),1),
#2206
('Hrebine',10294,'Donja Pušća','ZAGREBAČKA',now(),now(),1),
#2207
('Hrebinec',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#2208
('Hreljići',52207,'Barban','ISTARSKA',now(),now(),1),
#2209
('Hreljin',51226,'Hreljin','PRIMORSKO-GORANSKA',now(),now(),1),
#2210
('Hreljin Ogulinski',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#2211
('Hrgovec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2212
('Hrib',51304,'Gerovo','PRIMORSKO-GORANSKA',now(),now(),1),
#2213
('Hribac',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#2214
('Hrkanovci Đakovački',31411,'Trnava','OSJEČKO-BARANJSKA',now(),now(),1),
#2215
('Hrnetić-Novaki',47000,'Karlovac','KARLOVAČKA',now(),now(),1),
#2216
('Hrnjanec',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#2217
('Hrnjevac',34335,'Vetovo','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2218
('Hromec',49225,'Đurmanec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2219
('Hrsina',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#2220
('Hrsovo',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2221
('Hršak Breg',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2222
('Hrščevani',21262,'Kamenmost','SPLITSKO-DALMATINSKA',now(),now(),1),
#2223
('Hrtić',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2224
('Hruščica',10373,'Ivanja Reka','GRAD ZAGREB',now(),now(),1),
#2225
('Hruševec',49240,'Donja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2226
('Hruševec Kupljenski',10295,'Kupljenovo','ZAGREBAČKA',now(),now(),1),
#2227
('Hruševec Pušćanski',10294,'Donja Pušća','ZAGREBAČKA',now(),now(),1),
#2228
('Hruševec Pušćanski (dio)',10295,'Kupljenovo','ZAGREBAČKA',now(),now(),1),
#2229
('Hruškovec',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#2230
('Hruškovica',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#2231
('Hrvace',21233,'Hrvace','SPLITSKO-DALMATINSKA',now(),now(),1),
#2232
('Hrvatska Dubica',44450,'Hrvatska Dubica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2233
('Hrvatska Kostajnica',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2234
('Hrvatski Čuntić',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2235
('Hrvatski Leskovac',10251,'Hrvatski Leskovac','GRAD ZAGREB',now(),now(),1),
#2236
('Hrvatsko',51303,'Plešce','PRIMORSKO-GORANSKA',now(),now(),1),
#2237
('Hrvatsko Polje',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#2238
('Hrvatsko Selo',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2239
('Hrvatsko Žarište',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#2240
('Hrženica',42233,'Sveti Đurđ','VARAŽDINSKA',now(),now(),1),
#2241
('Hrženik',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#2242
('Hudi Bitek',10257,'Brezovica','GRAD ZAGREB',now(),now(),1),
#2243
('Hudovljani',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2244
('Hudovo',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#2245
('Hum',52425,'Roč','ISTARSKA',now(),now(),1),
#2246
('Hum',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2247
('Hum Bistrički',49246,'Marija Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2248
('Hum Košnički',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2249
('Hum na Sutli',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2250
('Hum Stubički',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2251
('Hum Varoš',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2252
('Hum Zabočki',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2253
('Humac',21465,'Jelsa','SPLITSKO-DALMATINSKA',now(),now(),1),
#2254
('Humljani',33514,'Čačinci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2255
('Husain',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2256
('Husinec',49283,'Hraščina-Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2257
('Husje',47000,'Karlovac','KARLOVAČKA',now(),now(),1),
#2258
('Hutin',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#2259
('Hvar',21450,'Hvar','SPLITSKO-DALMATINSKA',now(),now(),1),
#2260
('Ičići',51414,'Ičići','PRIMORSKO-GORANSKA',now(),now(),1),
#2261
('Ićevo',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#2262
('Igrane',21329,'Igrane','SPLITSKO-DALMATINSKA',now(),now(),1),
#2263
('Igrišće',10297,'Jakovlje','ZAGREBAČKA',now(),now(),1),
#2264
('Ika',51414,'Ičići','PRIMORSKO-GORANSKA',now(),now(),1),
#2265
('Ilača',32248,'Ilača','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#2266
('Ilmin Dvor',33523,'Čađavica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2267
('Ilok',32236,'Ilok','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#2268
('Ilova',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2269
('Ilovac',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#2270
('Ilovačak',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2271
('Ilovik',51552,'Ilovik','PRIMORSKO-GORANSKA',now(),now(),1),
#2272
('Ilovik',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#2273
('Ilovski Klokočevac',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2274
('Imbrijovec Jalžabetski',42203,'Jalžabet','VARAŽDINSKA',now(),now(),1),
#2275
('Imbriovec',48316,'Đelekovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2276
('Imotica',20205,'Topolo','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2277
('Imotski',21260,'Imotski','SPLITSKO-DALMATINSKA',now(),now(),1),
#2278
('Imrijevci',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2279
('Imsovac',43506,'Dežanovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2280
('Ipši',52427,'Livade (Levade)','ISTARSKA',now(),now(),1),
#2281
('Irinovac',47246,'Drežnik Grad','KARLOVAČKA',now(),now(),1),
#2282
('Islam Grčki',23420,'Benkovac','ZADARSKA',now(),now(),1),
#2283
('Islam Latinski',23242,'Posedarje','ZADARSKA',now(),now(),1),
#2284
('Ist',23293,'Ist','ZADARSKA',now(),now(),1),
#2285
('Istočni Trojvrh',47303,'Josipdol','KARLOVAČKA',now(),now(),1),
#2286
('Iševnica',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#2287
('Ivan Dolac',21465,'Jelsa','SPLITSKO-DALMATINSKA',now(),now(),1),
#2288
('Ivanbegovina',21262,'Kamenmost','SPLITSKO-DALMATINSKA',now(),now(),1),
#2289
('Ivanbrijeg',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2290
('Ivančani',10344,'Farkaševac','ZAGREBAČKA',now(),now(),1),
#2291
('Ivančec',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2292
('Ivančići',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#2293
('Ivančići Pokupski',47204,'Šišljavić','KARLOVAČKA',now(),now(),1),
#2294
('Ivandol',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2295
('Ivanec',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#2296
('Ivanec Bistranski',10290,'Zaprešić','GRAD ZAGREB',now(),now(),1),
#2297
('Ivanec Križevački',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2298
('Ivanečka Željeznica',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#2299
('Ivanečki Vrhovec',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#2300
('Ivanečko Naselje',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#2301
('Ivanić Desinićki',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2302
('Ivanić Grad',10310,'Ivanić-Grad','ZAGREBAČKA',now(),now(),1),
#2303
('Ivanić Košnički',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2304
('Ivanić Miljanski',49296,'Zagorska Sela','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2305
('Ivanković Selo',47241,'Cerovac Vukmanički','KARLOVAČKA',now(),now(),1),
#2306
('Ivankovo',32281,'Ivankovo','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#2307
('Ivanovac',31216,'Antunovac','OSJEČKO-BARANJSKA',now(),now(),1),
#2308
('Ivanovci',31227,'Zelčin','OSJEČKO-BARANJSKA',now(),now(),1),
#2309
('Ivanovci',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2310
('Ivanovci Gorjanski',31400,'Đakovo','OSJEČKO-BARANJSKA',now(),now(),1),
#2311
('Ivanovec',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#2312
('Ivanovo',31540,'Donji Miholjac','OSJEČKO-BARANJSKA',now(),now(),1),
#2313
('Ivanovo Polje',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2314
('Ivanovo Selo',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2315
('Ivanska',43231,'Ivanska','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2316
('Ivanja Reka',10373,'Ivanja Reka','GRAD ZAGREB',now(),now(),1),
#2317
('Ivanje',51559,'Beli','PRIMORSKO-GORANSKA',now(),now(),1),
#2318
('Ivanjski Bok',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2319
('Ivići',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#2320
('Ivoševci',22305,'Kistanje','ŠIBENSKO-KNINSKA',now(),now(),1),
#2321
('Ivošević Selo',47241,'Cerovac Vukmanički','KARLOVAČKA',now(),now(),1),
#2322
('Izimje',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#2323
('Jablan',51326,'Vrbovsko','PRIMORSKO-GORANSKA',now(),now(),1),
#2324
('Jablanac',53287,'Jablanac','LIČKO-SENJSKA',now(),now(),1),
#2325
('Jablanovec',10298,'Donja Bistra','ZAGREBAČKA',now(),now(),1),
#2326
('Jabučeta',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2327
('Jabuka',21240,'Trilj','SPLITSKO-DALMATINSKA',now(),now(),1),
#2328
('Jabuka',21485,'Komiža','SPLITSKO-DALMATINSKA',now(),now(),1),
#2329
('Jabukovac',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2330
('Jadranovo',51264,'Jadranovo','PRIMORSKO-GORANSKA',now(),now(),1),
#2331
('Jadreški',52100,'Pula (Pola)','ISTARSKA',now(),now(),1),
#2332
('Jadrići',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#2333
('Jadrtovac',22000,'Šibenik','ŠIBENSKO-KNINSKA',now(),now(),1),
#2334
('Jadruhi',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#2335
('Jagma',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2336
('Jagnjedovac',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2337
('Jagnjić Dol',10431,'Sveta Nedjelja','ZAGREBAČKA',now(),now(),1),
#2338
('Jagodno',10415,'Novo Čiče','ZAGREBAČKA',now(),now(),1),
#2339
('Jagodnjak',31324,'Jagodnjak','OSJEČKO-BARANJSKA',now(),now(),1),
#2340
('Jagodnje',53236,'Podlapača','LIČKO-SENJSKA',now(),now(),1),
#2341
('Jagrovac',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#2342
('Jagrovac',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#2343
('Jaguplije',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2344
('Jakačići',52403,'Gračišće','ISTARSKA',now(),now(),1),
#2345
('Jakačina Mala',35252,'Sibinj','BRODSKO-POSAVSKA',now(),now(),1),
#2346
('Jakići I i II',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#2347
('Jakomići',52333,'Podpićan','ISTARSKA',now(),now(),1),
#2348
('Jakopovac',43202,'Zrinski Topolovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2349
('Jakopovec',42204,'Turčin','VARAŽDINSKA',now(),now(),1),
#2350
('Jakov Polje',51252,'Klenovica','PRIMORSKO-GORANSKA',now(),now(),1),
#2351
('Jakovci',34553,'Bučje','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2352
('Jakovci',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2353
('Jakovci Netretički',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#2354
('Jakovici',52444,'Tinjan','ISTARSKA',now(),now(),1),
#2355
('Jakovlje',10297,'Jakovlje','ZAGREBAČKA',now(),now(),1),
#2356
('Jakšić',34308,'Jakšić','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2357
('Jakšići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#2358
('Jakšinec',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2359
('Jakuševec Zabočki',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2360
('Jales Breznički',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#2361
('Jalkovec',42000,'Varaždin','VARAŽDINSKA',now(),now(),1),
#2362
('Jalševec Breški',10310,'Ivanić-Grad','ZAGREBAČKA',now(),now(),1),
#2363
('Jalševec Nartski',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#2364
('Jalševec Svibovečki',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#2365
('Jalšje',49214,'Veliko Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2366
('Jalšovec',40312,'Štrigova','MEĐIMURSKA',now(),now(),1),
#2367
('Jalžabet',42203,'Jalžabet','VARAŽDINSKA',now(),now(),1),
#2368
('Jamarica',44321,'Banova Jaruga','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2369
('Jamarje',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#2370
('Jame',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#2371
('Jamnica Pisarovinska',10451,'Pisarovina','ZAGREBAČKA',now(),now(),1),
#2372
('Jamno',42254,'Trakošćan','VARAŽDINSKA',now(),now(),1),
#2373
('Jančani',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#2374
('Jankolovica',23210,'Biograd na moru','ZADARSKA',now(),now(),1),
#2375
('Jankovac',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2376
('Jankovo Selište',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#2377
('Janja Gora',47304,'Plaški','KARLOVAČKA',now(),now(),1),
#2378
('Janja Lipa',44321,'Banova Jaruga','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2379
('Janjani',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#2380
('Janjevalj',51243,'Tribalj','PRIMORSKO-GORANSKA',now(),now(),1),
#2381
('Janjina',20246,'Janjina','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2382
('Japaga',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2383
('Japetić',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#2384
('Jarčani',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2385
('Jarče Polje',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#2386
('Jarebinjak',22203,'Rogoznica','ŠIBENSKO-KNINSKA',now(),now(),1),
#2387
('Jarek Bisaški',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#2388
('Jarek Habekov',49283,'Hraščina-Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2389
('Jargovo',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#2390
('Jarki',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#2391
('Jarki Horvatićevi',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#2392
('Jarmina',32280,'Jarmina','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#2393
('Jarnevići',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#2394
('Jaruge',35224,'Sikirevci','BRODSKO-POSAVSKA',now(),now(),1),
#2395
('Jarušje',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#2396
('Jasenak',47314,'Jasenak','KARLOVAČKA',now(),now(),1),
#2397
('Jasenaš',43532,'Đulovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2398
('Jasenice',23243,'Jasenice','ZADARSKA',now(),now(),1),
#2399
('Jasenice',20210,'Cavtat','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2400
('Jasenik',43227,'Šandrovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2401
('Jasenovac',31309,'Kneževi Vinogradi','OSJEČKO-BARANJSKA',now(),now(),1),
#2402
('Jasenovac',44324,'Jasenovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2403
('Jasenovčani',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2404
('Jasenovec',10363,'Belovar','GRAD ZAGREB',now(),now(),1),
#2405
('Jasenovec Zagorski',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2406
('Jasenovica',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#2407
('Jasenovica',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#2408
('Jasensko',21230,'Sinj','SPLITSKO-DALMATINSKA',now(),now(),1),
#2409
('Jasik',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2410
('Jasikovac',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#2411
('Jasnić Brdo',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#2412
('Jastrebarsko',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#2413
('Jaškovo',47281,'Mali Erjavec','KARLOVAČKA',now(),now(),1),
#2414
('Javnica',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2415
('Javor',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#2416
('Javorek',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#2417
('Javorje',51252,'Klenovica','PRIMORSKO-GORANSKA',now(),now(),1),
#2418
('Javorje',10291,'Prigorje Brdovečko','ZAGREBAČKA',now(),now(),1),
#2419
('Javornik',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2420
('Javorovac',48325,'Novigrad Podravski','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2421
('Jazavica',44323,'Rajić','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2422
('Jazbina',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2423
('Jazbina Cvetlinska',42254,'Trakošćan','VARAŽDINSKA',now(),now(),1),
#2424
('Jazbina Višnjička',42255,'Donja Višnjica','VARAŽDINSKA',now(),now(),1),
#2425
('Jazvaci',47201,'Draganići','KARLOVAČKA',now(),now(),1),
#2426
('Jazvenik',44273,'Sela','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2427
('Jazvine',49232,'Radoboj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2428
('Jeduševac',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2429
('Jehnići',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#2430
('Jelenščak',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#2431
('Jelenjak',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2432
('Jelenje',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#2433
('Jelisavac',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#2434
('Jelov Klanac',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#2435
('Jelovec',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2436
('Jelovec Voćanski',42245,'Donja Voća','VARAŽDINSKA',now(),now(),1),
#2437
('Jelovice',52420,'Buzet','ISTARSKA',now(),now(),1),
#2438
('Jelsa',21465,'Jelsa','SPLITSKO-DALMATINSKA',now(),now(),1),
#2439
('Jeminovac',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2440
('Jerčinovići',51242,'Drivenik','PRIMORSKO-GORANSKA',now(),now(),1),
#2441
('Jerebić',10418,'Dubranec','ZAGREBAČKA',now(),now(),1),
#2442
('Jerovec',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#2443
('Jertovec',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2444
('Jesenice',21314,'Jesenice','SPLITSKO-DALMATINSKA',now(),now(),1),
#2445
('Jesenovik',52234,'Plomin','ISTARSKA',now(),now(),1),
#2446
('Jezera',22242,'Jezera','ŠIBENSKO-KNINSKA',now(),now(),1),
#2447
('Jezerane',53262,'Jezerane','LIČKO-SENJSKA',now(),now(),1),
#2448
('Jezerce',53231,'Plitvička Jezera','LIČKO-SENJSKA',now(),now(),1),
#2449
('Jezerine',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#2450
('Jezerišće',49225,'Đurmanec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2451
('Jezernice',10457,'Sošice','ZAGREBAČKA',now(),now(),1),
#2452
('Jezero',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2453
('Jezero I Dio',47304,'Plaški','KARLOVAČKA',now(),now(),1),
#2454
('Jezero Klanječko',49214,'Veliko Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2455
('Jezero Posavsko',44201,'Martinska Ves','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2456
('Ježdovec',10250,'Lučko','GRAD ZAGREB',now(),now(),1),
#2457
('Ježenj',52000,'Pazin','ISTARSKA',now(),now(),1),
#2458
('Ježević',21236,'Vrlika','SPLITSKO-DALMATINSKA',now(),now(),1),
#2459
('Ježevik',35209,'Bukovlje','BRODSKO-POSAVSKA',now(),now(),1),
#2460
('Ježevo',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#2461
('Ježovec',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#2462
('Johi',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#2463
('Johovec',10314,'Križ','ZAGREBAČKA',now(),now(),1),
#2464
('Johovo',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#2465
('Josipdol',47303,'Josipdol','KARLOVAČKA',now(),now(),1),
#2466
('Josipovac',31221,'Josipovac','OSJEČKO-BARANJSKA',now(),now(),1),
#2467
('Josipovac Punitovački',31424,'Punitovci','OSJEČKO-BARANJSKA',now(),now(),1),
#2468
('Josipovo',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2469
('Jošan',53234,'Udbina','LIČKO-SENJSKA',now(),now(),1),
#2470
('Jošavica',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2471
('Joševica',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2472
('Jovac',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2473
('Jovići',23248,'Ražanac','ZADARSKA',now(),now(),1),
#2474
('Jugovac',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#2475
('Jugovo Polje',33412,'Cabuna','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2476
('Juradi',52420,'Buzet','ISTARSKA',now(),now(),1),
#2477
('Jural',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#2478
('Jurandvor',51523,'Baška','PRIMORSKO-GORANSKA',now(),now(),1),
#2479
('Juranšćina',49254,'Belec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2480
('Jurazini',52231,'Nedešćina','ISTARSKA',now(),now(),1),
#2481
('Jurcani',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#2482
('Jurdani',51213,'Jurdani','PRIMORSKO-GORANSKA',now(),now(),1),
#2483
('Jurga',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#2484
('Juricani',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#2485
('Juričići',52420,'Buzet','ISTARSKA',now(),now(),1),
#2486
('Jurićev Kal',52207,'Barban','ISTARSKA',now(),now(),1),
#2487
('Jurići',52341,'Žminj','ISTARSKA',now(),now(),1),
#2488
('Jurići',52445,'Baderna','ISTARSKA',now(),now(),1),
#2489
('Jurjevac Punitovački',31424,'Punitovci','OSJEČKO-BARANJSKA',now(),now(),1),
#2490
('Jurjevčani',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#2491
('Jurjevec Začretski',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2492
('Jurketinec',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#2493
('Jurkovac',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2494
('Jurkovo Selo',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#2495
('Jurovčak',40313,'Sveti Martin na Muri','MEĐIMURSKA',now(),now(),1),
#2496
('Jurovec',40313,'Sveti Martin na Muri','MEĐIMURSKA',now(),now(),1),
#2497
('Jurovo',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#2498
('Jurovski Brod',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#2499
('Juršići',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#2500
('Jušići',51213,'Jurdani','PRIMORSKO-GORANSKA',now(),now(),1),
#2501
('Kabal',10344,'Farkaševac','ZAGREBAČKA',now(),now(),1),
#2502
('Kablar',47212,'Skakavac','KARLOVAČKA',now(),now(),1),
#2503
('Kačkovec',49294,'Kraljevec na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2504
('Kadanovci',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2505
('Kadina Glavica',22321,'Siverić','ŠIBENSKO-KNINSKA',now(),now(),1),
#2506
('Kadumi',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#2507
('Kajgana',43280,'Garešnica','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2508
('Kajini',52420,'Buzet','ISTARSKA',now(),now(),1),
#2509
('Kakanj',22305,'Kistanje','ŠIBENSKO-KNINSKA',now(),now(),1),
#2510
('Kakinac',43212,'Rovišće','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2511
('Kakma',23423,'Polača','ZADARSKA',now(),now(),1),
#2512
('Kalac',51417,'Mošćenička Draga','PRIMORSKO-GORANSKA',now(),now(),1),
#2513
('Kaldanija',52460,'Buje (Buie)','ISTARSKA',now(),now(),1),
#2514
('Kaldir',52424,'Motovun (Montana)','ISTARSKA',now(),now(),1),
#2515
('Kaldrma',23445,'Srb','ZADARSKA',now(),now(),1),
#2516
('Kalebovac',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#2517
('Kalenić',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2518
('Kali',23272,'Kali','ZADARSKA',now(),now(),1),
#2519
('Kalić',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#2520
('Kalina',22202,'Primošten','ŠIBENSKO-KNINSKA',now(),now(),1),
#2521
('Kalinovac',48361,'Kalinovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2522
('Kalinovača',53213,'Donje Pazarište','LIČKO-SENJSKA',now(),now(),1),
#2523
('Kalinovica',10436,'Rakov Potok','ZAGREBAČKA',now(),now(),1),
#2524
('Kalinje',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#2525
('Kalnik',48269,'Kalnik','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2526
('Kaluđerovac',53202,'Perušić','LIČKO-SENJSKA',now(),now(),1),
#2527
('Kalje',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#2528
('Kamanje',47282,'Kamanje','KARLOVAČKA',now(),now(),1),
#2529
('Kamen',21000,'Split','SPLITSKO-DALMATINSKA',now(),now(),1),
#2530
('Kamena Gorica',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#2531
('Kamenac',31309,'Kneževi Vinogradi','OSJEČKO-BARANJSKA',now(),now(),1),
#2532
('Kamenci',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#2533
('Kamenica',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2534
('Kamenica',42250,'Lepoglava','VARAŽDINSKA',now(),now(),1),
#2535
('Kamenica',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#2536
('Kamenica Skradnička',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#2537
('Kamenički Vrhovec',42250,'Lepoglava','VARAŽDINSKA',now(),now(),1),
#2538
('Kameničko Podgorje',42250,'Lepoglava','VARAŽDINSKA',now(),now(),1),
#2539
('Kamenmost',21262,'Kamenmost','SPLITSKO-DALMATINSKA',now(),now(),1),
#2540
('Kamenska',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2541
('Kamenski Hrib',51303,'Plešce','PRIMORSKO-GORANSKA',now(),now(),1),
#2542
('Kamenski Šeovci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2543
('Kamenski Vučjak',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2544
('Kamensko',51326,'Vrbovsko','PRIMORSKO-GORANSKA',now(),now(),1),
#2545
('Kamensko',47000,'Karlovac','KARLOVAČKA',now(),now(),1),
#2546
('Kamensko',21246,'Aržano','SPLITSKO-DALMATINSKA',now(),now(),1),
#2547
('Kamenjak',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#2548
('Kamešnica',48269,'Kalnik','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2549
('Kampelje',51516,'Vrbnik','PRIMORSKO-GORANSKA',now(),now(),1),
#2550
('Kampor',51280,'Rab','PRIMORSKO-GORANSKA',now(),now(),1),
#2551
('Kanegra',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#2552
('Kanfanar',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#2553
('Kaniška Iva',43283,'Kaniška Iva','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2554
('Kaniža',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#2555
('Kaniža',35254,'Bebrina','BRODSKO-POSAVSKA',now(),now(),1),
#2556
('Kaniža Gospićka',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#2557
('Kantrovci',34330,'Velika','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2558
('Kanjane',22321,'Siverić','ŠIBENSKO-KNINSKA',now(),now(),1),
#2559
('Kaočine',22324,'Drinovci','ŠIBENSKO-KNINSKA',now(),now(),1),
#2560
('Kapela',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2561
('Kapela',42231,'Mali Bukovec','VARAŽDINSKA',now(),now(),1),
#2562
('Kapela Dvor',33406,'Lukač','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2563
('Kapela Kalnička',42222,'Ljubeščica','VARAŽDINSKA',now(),now(),1),
#2564
('Kapela Korenička',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#2565
('Kapela Ravenska',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2566
('Kapelec',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#2567
('Kapelica',43280,'Garešnica','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2568
('Kapelica',52220,'Labin','ISTARSKA',now(),now(),1),
#2569
('Kapelna',31531,'Viljevo','OSJEČKO-BARANJSKA',now(),now(),1),
#2570
('Kapelski Vrh',49294,'Kraljevec na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2571
('Kapelščak',40313,'Sveti Martin na Muri','MEĐIMURSKA',now(),now(),1),
#2572
('Kapetanovo Polje',34552,'Badljevina','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2573
('Kapinci',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2574
('Kapljuv',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#2575
('Kapovići',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#2576
('Kaprije',22235,'Kaprije','ŠIBENSKO-KNINSKA',now(),now(),1),
#2577
('Kaptol',34334,'Kaptol','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2578
('Karadžićevo',32280,'Jarmina','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#2579
('Karakašica',21230,'Sinj','SPLITSKO-DALMATINSKA',now(),now(),1),
#2580
('Karalić',22324,'Drinovci','ŠIBENSKO-KNINSKA',now(),now(),1),
#2581
('Karanac',31315,'Karanac','OSJEČKO-BARANJSKA',now(),now(),1),
#2582
('Karane',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2583
('Karasi',47203,'Rečica','KARLOVAČKA',now(),now(),1),
#2584
('Karigador',52474,'Brtonigla (Verteneglio)','ISTARSKA',now(),now(),1),
#2585
('Karivaroš',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2586
('Karlobag',53288,'Karlobag','LIČKO-SENJSKA',now(),now(),1),
#2587
('Karlovac',47000,'Karlovac','KARLOVAČKA',now(),now(),1),
#2588
('Karlovac Feričanački',33515,'Orahovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2589
('Karlovec Ludbreški',42233,'Sveti Đurđ','VARAŽDINSKA',now(),now(),1),
#2590
('Karlovići',52341,'Žminj','ISTARSKA',now(),now(),1),
#2591
('Karojba',52423,'Karojba','ISTARSKA',now(),now(),1),
#2592
('Kartalije',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#2593
('Kastav',51215,'Kastav','PRIMORSKO-GORANSKA',now(),now(),1),
#2594
('Kasuni',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#2595
('Kašćerga',52000,'Pazin','ISTARSKA',now(),now(),1),
#2596
('Kašić',22213,'Pirovac','ŠIBENSKO-KNINSKA',now(),now(),1),
#2597
('Kašina',10362,'Kašina','GRAD ZAGREB',now(),now(),1),
#2598
('Kašinska Sopnica',10362,'Kašina','GRAD ZAGREB',now(),now(),1),
#2599
('Kašljavac',43274,'Severin','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2600
('Kašt',47284,'Kašt','KARLOVAČKA',now(),now(),1),
#2601
('Kaštel',52460,'Buje (Buie)','ISTARSKA',now(),now(),1),
#2602
('Kaštel Dežanovački',43506,'Dežanovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2603
('Kaštel Gomilica',21213,'Kaštel Gomilica','SPLITSKO-DALMATINSKA',now(),now(),1),
#2604
('Kaštel Kambelovac',21214,'Kaštel Kambelovac','SPLITSKO-DALMATINSKA',now(),now(),1),
#2605
('Kaštel Lukšić',21215,'Kaštel Lukšić','SPLITSKO-DALMATINSKA',now(),now(),1),
#2606
('Kaštel Novi',21217,'Kaštel Štafilić','SPLITSKO-DALMATINSKA',now(),now(),1),
#2607
('Kaštel Stari',21216,'Kaštel Stari','SPLITSKO-DALMATINSKA',now(),now(),1),
#2608
('Kaštel Sućurac',21212,'Kaštel Sućurac','SPLITSKO-DALMATINSKA',now(),now(),1),
#2609
('Kaštel Štafilić',21217,'Kaštel Štafilić','SPLITSKO-DALMATINSKA',now(),now(),1),
#2610
('Kaštel Žegarski',23450,'Obrovac','ZADARSKA',now(),now(),1),
#2611
('Kaštelanec',42204,'Turčin','VARAŽDINSKA',now(),now(),1),
#2612
('Kaštelir',52464,'Kaštelir (Castelliere)','ISTARSKA',now(),now(),1),
#2613
('Katinac',43532,'Đulovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2614
('Katinka',33407,'Gornje Bazje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2615
('Katinovac',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2616
('Katoličke Čaire',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2617
('Katoličko Selišće',44316,'Velika Ludina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2618
('Katoro',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#2619
('Katun',52445,'Baderna','ISTARSKA',now(),now(),1),
#2620
('Katun',51264,'Jadranovo','PRIMORSKO-GORANSKA',now(),now(),1),
#2621
('Katuni',21250,'Šestanovac','SPLITSKO-DALMATINSKA',now(),now(),1),
#2622
('Kavran',52208,'Krnica','ISTARSKA',now(),now(),1),
#2623
('Kavrani',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#2624
('Kebel',49221,'Bedekovčina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2625
('Kegljevac',43226,'Veliko Trojstvo','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2626
('Kejići',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#2627
('Kekići',10457,'Sošice','ZAGREBAČKA',now(),now(),1),
#2628
('Kelemen',42203,'Jalžabet','VARAŽDINSKA',now(),now(),1),
#2629
('Keleminovec',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#2630
('Kelešinka',31433,'Podgorač','OSJEČKO-BARANJSKA',now(),now(),1),
#2631
('Kenđelovec',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2632
('Kepčije',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2633
('Kerestinec',10431,'Sveta Nedjelja','ZAGREBAČKA',now(),now(),1),
#2634
('Keseri',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#2635
('Keserov Potok',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#2636
('Kestenovac',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#2637
('Kestenovac',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#2638
('Kestenjak',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#2639
('Kestenje',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#2640
('Kešinci',31402,'Semeljci','OSJEČKO-BARANJSKA',now(),now(),1),
#2641
('Kičeri',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#2642
('Kihalac',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2643
('Kijani',23440,'Gračac','ZADARSKA',now(),now(),1),
#2644
('Kijevo',22310,'Kijevo','ŠIBENSKO-KNINSKA',now(),now(),1),
#2645
('Kik',53244,'Lovinac','LIČKO-SENJSKA',now(),now(),1),
#2646
('Kindrovo',35201,'Podcrkavlje','BRODSKO-POSAVSKA',now(),now(),1),
#2647
('Kinjačka',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2648
('Kip',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2649
('Kirin',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2650
('Kirmenjak',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#2651
('Kistanje',22305,'Kistanje','ŠIBENSKO-KNINSKA',now(),now(),1),
#2652
('Kitišanci',31554,'Gat','OSJEČKO-BARANJSKA',now(),now(),1),
#2653
('Klada',53284,'Sveti Juraj','LIČKO-SENJSKA',now(),now(),1),
#2654
('Kladare',33405,'Pitomača','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2655
('Kladari',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2656
('Kladešćica',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#2657
('Kladje',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#2658
('Kladnik',49295,'Kumrovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2659
('Kladnjice',21202,'Lećevica','SPLITSKO-DALMATINSKA',now(),now(),1),
#2660
('Klakar',35208,'Ruščica','BRODSKO-POSAVSKA',now(),now(),1),
#2661
('Klake',10435,'Sveti Martin pod Okićem','ZAGREBAČKA',now(),now(),1),
#2662
('Klana',51217,'Klana','PRIMORSKO-GORANSKA',now(),now(),1),
#2663
('Klanac',53212,'Klanac','LIČKO-SENJSKA',now(),now(),1),
#2664
('Klanac',51329,'Severin na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#2665
('Klanac',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#2666
('Klanac Perjasički',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#2667
('Klanice',51514,'Dobrinj','PRIMORSKO-GORANSKA',now(),now(),1),
#2668
('Klanjec',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2669
('Klanječno',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2670
('Klarići',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#2671
('Klarići',51242,'Drivenik','PRIMORSKO-GORANSKA',now(),now(),1),
#2672
('Klašnjica',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#2673
('Klek',20356,'Klek','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2674
('Klenice',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2675
('Klenovac',53202,'Perušić','LIČKO-SENJSKA',now(),now(),1),
#2676
('Klenovec Humski',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2677
('Klenovica',51252,'Klenovica','PRIMORSKO-GORANSKA',now(),now(),1),
#2678
('Klenovnik',42244,'Klenovnik','VARAŽDINSKA',now(),now(),1),
#2679
('Klenovščak',52420,'Buzet','ISTARSKA',now(),now(),1),
#2680
('Klepeće Selo',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#2681
('Kletište',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2682
('Kličevica',23420,'Benkovac','ZADARSKA',now(),now(),1),
#2683
('Klimen',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2684
('Klimni',52341,'Žminj','ISTARSKA',now(),now(),1),
#2685
('Klimno',51514,'Dobrinj','PRIMORSKO-GORANSKA',now(),now(),1),
#2686
('Klinac',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2687
('Klinča Sela',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#2688
('Klipino Brdo',47241,'Cerovac Vukmanički','KARLOVAČKA',now(),now(),1),
#2689
('Klis',21231,'Klis','SPLITSKO-DALMATINSKA',now(),now(),1),
#2690
('Klisa',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2691
('Klisa',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2692
('Klisa',31207,'Tenja','OSJEČKO-BARANJSKA',now(),now(),1),
#2693
('Kliševo',20234,'Orašac','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2694
('Klobučak',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2695
('Klokoč',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#2696
('Klokočevac',43211,'Predavac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2697
('Klokočevac Samoborski',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#2698
('Klokočevci',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#2699
('Klokočevik',35211,'Trnjani','BRODSKO-POSAVSKA',now(),now(),1),
#2700
('Klokovec',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2701
('Kloštar',52450,'Vrsar (Orsera)','ISTARSKA',now(),now(),1),
#2702
('Kloštar Ivanić',10312,'Kloštar Ivanić','ZAGREBAČKA',now(),now(),1),
#2703
('Kloštar Podravski',48362,'Kloštar Podravski','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2704
('Kloštar Šiljevički',51264,'Jadranovo','PRIMORSKO-GORANSKA',now(),now(),1),
#2705
('Kloštar Vojakovački',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2706
('Klupci',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2707
('Klupica',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#2708
('Kljaić Brdo',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#2709
('Kljake',22322,'Ružić','ŠIBENSKO-KNINSKA',now(),now(),1),
#2710
('Kljenak',21276,'Vrgorac','SPLITSKO-DALMATINSKA',now(),now(),1),
#2711
('Ključ',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#2712
('Ključ',22324,'Drinovci','ŠIBENSKO-KNINSKA',now(),now(),1),
#2713
('Ključ Brdovečki',10292,'Šenkovec','ZAGREBAČKA',now(),now(),1),
#2714
('Ključar',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#2715
('Ključić Brdo',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#2716
('Kmeti',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#2717
('Knapić',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#2718
('Knapići',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#2719
('Knez Gorica',47241,'Cerovac Vukmanički','KARLOVAČKA',now(),now(),1),
#2720
('Knezovec',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#2721
('Knezovljani',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2722
('Knežci',34312,'Sesvete (kod Požege)','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2723
('Kneževac',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2724
('Kneževi Vinogradi',31309,'Kneževi Vinogradi','OSJEČKO-BARANJSKA',now(),now(),1),
#2725
('Knežević Kosa',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#2726
('Kneževo',31302,'Kneževo','OSJEČKO-BARANJSKA',now(),now(),1),
#2727
('Knežica',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2728
('Knin',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#2729
('Kninsko Polje',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#2730
('Kobasičari',43211,'Predavac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2731
('Kobilić',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#2732
('Kobilić Pokupski',47000,'Karlovac','KARLOVAČKA',now(),now(),1),
#2733
('Kobiljača',20278,'Nova Sela','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2734
('Kobiljak',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2735
('Kocijani',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#2736
('Kočičin',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#2737
('Kočići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#2738
('Kohanjac',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#2739
('Kokanj',51242,'Drivenik','PRIMORSKO-GORANSKA',now(),now(),1),
#2740
('Kokinac',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2741
('Kokirevo',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#2742
('Kokočak',33515,'Orahovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2743
('Kokorić',21276,'Vrgorac','SPLITSKO-DALMATINSKA',now(),now(),1),
#2744
('Kolan',23251,'Kolan','ZADARSKA',now(),now(),1),
#2745
('Kolarec',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2746
('Kolarevo Selo',43247,'Narta','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2747
('Kolarić',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#2748
('Kolarina',23420,'Benkovac','ZADARSKA',now(),now(),1),
#2749
('Kolarovec',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#2750
('Kolašac',22305,'Kistanje','ŠIBENSKO-KNINSKA',now(),now(),1),
#2751
('Koledinec',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2752
('Kolenica',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#2753
('Kolenovac',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#2754
('Koločep',20221,'Koločep','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2755
('Kolumbera',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#2756
('Koljane',21236,'Vrlika','SPLITSKO-DALMATINSKA',now(),now(),1),
#2757
('Kom',23440,'Gračac','ZADARSKA',now(),now(),1),
#2758
('Komaji',20213,'Čilipi','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2759
('Komarna',20356,'Klek','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2760
('Komarnica',35420,'Staro Petrovo Selo','BRODSKO-POSAVSKA',now(),now(),1),
#2761
('Komarnica Ludbreška',42233,'Sveti Đurđ','VARAŽDINSKA',now(),now(),1),
#2762
('Komarovci',34334,'Kaptol','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2763
('Komatnica',48323,'Hlebine','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2764
('Komazeci',23450,'Obrovac','ZADARSKA',now(),now(),1),
#2765
('Komesarac',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#2766
('Kometnik-Jorgići',33522,'Voćin','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2767
('Kometnik-Zubići',33522,'Voćin','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2768
('Komić',53234,'Udbina','LIČKO-SENJSKA',now(),now(),1),
#2769
('Komin',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#2770
('Komin',20344,'Komin (Dalma)','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2771
('Komiža',21485,'Komiža','SPLITSKO-DALMATINSKA',now(),now(),1),
#2772
('Komlenići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#2773
('Komletinci',32253,'Komletinci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#2774
('Komogovina',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2775
('Komolac',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2776
('Komor Začretski',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2777
('Komora',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2778
('Komorica',34315,'Ratkovica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2779
('Kompanj',52425,'Roč','ISTARSKA',now(),now(),1),
#2780
('Kompator',44316,'Velika Ludina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2781
('Kompolje',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#2782
('Kompolje Koreničko',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#2783
('Komuševac',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2784
('Komušina',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2785
('Konak',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#2786
('Končanica',43505,'Končanica (Končenice)','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2787
('Končarev Kraj',53231,'Plitvička Jezera','LIČKO-SENJSKA',now(),now(),1),
#2788
('Kondrić',31411,'Trnava','OSJEČKO-BARANJSKA',now(),now(),1),
#2789
('Konšćani',10315,'Novoselec','ZAGREBAČKA',now(),now(),1),
#2790
('Konšćica',10435,'Sveti Martin pod Okićem','ZAGREBAČKA',now(),now(),1),
#2791
('Konštari',20231,'Doli','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2792
('Kontešići',52450,'Vrsar (Orsera)','ISTARSKA',now(),now(),1),
#2793
('Konjarić Vrh',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#2794
('Konjevrate',22221,'Lozovac','ŠIBENSKO-KNINSKA',now(),now(),1),
#2795
('Konjkovsko',47286,'Mahično','KARLOVAČKA',now(),now(),1),
#2796
('Konjsko',53288,'Karlobag','LIČKO-SENJSKA',now(),now(),1),
#2797
('Konjsko',21231,'Klis','SPLITSKO-DALMATINSKA',now(),now(),1),
#2798
('Konjsko Brdo',53202,'Perušić','LIČKO-SENJSKA',now(),now(),1),
#2799
('Konjščina',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2800
('Kopačevo',31327,'Bilje','OSJEČKO-BARANJSKA',now(),now(),1),
#2801
('Kopčevec',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#2802
('Koprivna',31215,'Ernestinovo','OSJEČKO-BARANJSKA',now(),now(),1),
#2803
('Koprivna',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2804
('Koprivnica',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2805
('Koprivnica',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2806
('Koprivnica Zagorska',49225,'Đurmanec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2807
('Koprivnički Bregi',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2808
('Koprivnički Ivanec',48314,'Koprivnički Ivanec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2809
('Koprivno',21204,'Dugopolje','SPLITSKO-DALMATINSKA',now(),now(),1),
#2810
('Koprno',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#2811
('Korana',47246,'Drežnik Grad','KARLOVAČKA',now(),now(),1),
#2812
('Korana',53231,'Plitvička Jezera','LIČKO-SENJSKA',now(),now(),1),
#2813
('Koranska Strana',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#2814
('Koranski Brijeg',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#2815
('Koranski Lug',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#2816
('Koransko Selo',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#2817
('Korčula',20260,'Korčula','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2818
('Kordići Žumberački',10457,'Sošice','ZAGREBAČKA',now(),now(),1),
#2819
('Kordunski Ljeskovac',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#2820
('Korduševci',35211,'Trnjani','BRODSKO-POSAVSKA',now(),now(),1),
#2821
('Korelići',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#2822
('Korenica',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#2823
('Koreničani',43531,'Veliki Bastaji','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2824
('Korenić Brdo',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#2825
('Korenići',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#2826
('Korenjak',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#2827
('Koretinec',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#2828
('Korija',33000,'Virovitica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2829
('Korita',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2830
('Korita',21238,'Otok (Dalmacija)','SPLITSKO-DALMATINSKA',now(),now(),1),
#2831
('Korita',20224,'Maranovići','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2832
('Korita Rakovička',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#2833
('Koritinja',47204,'Šišljavić','KARLOVAČKA',now(),now(),1),
#2834
('Koritna',31402,'Semeljci','OSJEČKO-BARANJSKA',now(),now(),1),
#2835
('Koritna',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#2836
('Korlat',23420,'Benkovac','ZADARSKA',now(),now(),1),
#2837
('Korlevići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#2838
('Kornati',22243,'Murter','ŠIBENSKO-KNINSKA',now(),now(),1),
#2839
('Kornić',51517,'Kornić','PRIMORSKO-GORANSKA',now(),now(),1),
#2840
('Korog',31214,'Laslovo (Szentl&#225;szl&#243;)','OSJEČKO-BARANJSKA',now(),now(),1),
#2841
('Koromačno',52222,'Koromačno','ISTARSKA',now(),now(),1),
#2842
('Koromani',52207,'Barban','ISTARSKA',now(),now(),1),
#2843
('Korušce',21202,'Lećevica','SPLITSKO-DALMATINSKA',now(),now(),1),
#2844
('Kosa',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#2845
('Kosa Janjačka',53202,'Perušić','LIČKO-SENJSKA',now(),now(),1),
#2846
('Kosavin',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#2847
('Kosi',51216,'Viškovo','PRIMORSKO-GORANSKA',now(),now(),1),
#2848
('Kosijer Selo',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#2849
('Kosijersko Selo',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#2850
('Kosinožići',52446,'Nova Vas','ISTARSKA',now(),now(),1),
#2851
('Kosinjski Bakovac',53203,'Kosinj','LIČKO-SENJSKA',now(),now(),1),
#2852
('Kosna',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2853
('Kosore',21236,'Vrlika','SPLITSKO-DALMATINSKA',now(),now(),1),
#2854
('Kosoriga',52420,'Buzet','ISTARSKA',now(),now(),1),
#2855
('Kosovac',35429,'Gornji Bogićevci','BRODSKO-POSAVSKA',now(),now(),1),
#2856
('Kosovečko',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2857
('Kostadinovac',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2858
('Kostanj',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#2859
('Kostanje',21207,'Kostanje','SPLITSKO-DALMATINSKA',now(),now(),1),
#2860
('Kostanjevac',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#2861
('Kostanjevac',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2862
('Kostanjevec Podvrški',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#2863
('Kostanjevec Podvrški',10253,'Donji Dragonožec','GRAD ZAGREB',now(),now(),1),
#2864
('Kostanjevec Riječki',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2865
('Kostanjica',52429,'Grožnjan (Grisignana)','ISTARSKA',now(),now(),1),
#2866
('Kostel',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2867
('Kostel Pribićki',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#2868
('Kostelsko',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2869
('Kostelj',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#2870
('Kostrčani',52232,'Kršan','ISTARSKA',now(),now(),1),
#2871
('Kostrena Sveta Barbara',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#2872
('Kostrena Sveta Lucija',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#2873
('Kostreši Bjelovački',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2874
('Kostreši Šaški',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2875
('Kostrići',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2876
('Koška',31224,'Koška','OSJEČKO-BARANJSKA',now(),now(),1),
#2877
('Koškovec',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#2878
('Košljun',23250,'Pag','ZADARSKA',now(),now(),1),
#2879
('Košnica',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2880
('Košutarica',44324,'Jasenovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2881
('Košute',21240,'Trilj','SPLITSKO-DALMATINSKA',now(),now(),1),
#2882
('Košutići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#2883
('Kotarani',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2884
('Kotari',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#2885
('Kotarice',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2886
('Kotelja',22203,'Rogoznica','ŠIBENSKO-KNINSKA',now(),now(),1),
#2887
('Kotezi',21276,'Vrgorac','SPLITSKO-DALMATINSKA',now(),now(),1),
#2888
('Kotezi',20231,'Doli','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2889
('Kotlenice',21204,'Dugopolje','SPLITSKO-DALMATINSKA',now(),now(),1),
#2890
('Kotli',52425,'Roč','ISTARSKA',now(),now(),1),
#2891
('Kotlina',31309,'Kneževi Vinogradi','OSJEČKO-BARANJSKA',now(),now(),1),
#2892
('Kotor',51260,'Crikvenica','PRIMORSKO-GORANSKA',now(),now(),1),
#2893
('Kotoriba',40329,'Kotoriba','MEĐIMURSKA',now(),now(),1),
#2894
('Koturić',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2895
('Koturić',34553,'Bučje','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2896
('Kovačevac',35400,'Nova Gradiška','BRODSKO-POSAVSKA',now(),now(),1),
#2897
('Kovačevac',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2898
('Kovačevac',43212,'Rovišće','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2899
('Kovači',52464,'Kaštelir (Castelliere)','ISTARSKA',now(),now(),1),
#2900
('Kovačić',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#2901
('Kozalj Vrh',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#2902
('Kozaperovica',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2903
('Kozarac',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2904
('Kozarac',31325,'Čeminac','OSJEČKO-BARANJSKA',now(),now(),1),
#2905
('Kozarevac',48362,'Kloštar Podravski','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#2906
('Kozarevac Račanski',43272,'Nova Rača','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2907
('Kozarica',20225,'Babino Polje','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#2908
('Kozarice',44322,'Lipovljani','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2909
('Kozibrod',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2910
('Kozica',21275,'Dragljane','SPLITSKO-DALMATINSKA',now(),now(),1),
#2911
('Kozice',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2912
('Kozinščak',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#2913
('Kozjača',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#2914
('Kozjak',31309,'Kneževi Vinogradi','OSJEČKO-BARANJSKA',now(),now(),1),
#2915
('Kozjak Začretski',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2916
('Kozjan',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#2917
('Kozji Vrh',51307,'Prezid','PRIMORSKO-GORANSKA',now(),now(),1),
#2918
('Kozlikovo',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#2919
('Kožino',23231,'Petrčane','ZADARSKA',now(),now(),1),
#2920
('Kožlovac',23420,'Benkovac','ZADARSKA',now(),now(),1),
#2921
('Kožljak',52234,'Plomin','ISTARSKA',now(),now(),1),
#2922
('Kožljani',52207,'Barban','ISTARSKA',now(),now(),1),
#2923
('Kračevec',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#2924
('Kraguj',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2925
('Kraj',23212,'Tkon','ZADARSKA',now(),now(),1),
#2926
('Kraj',21232,'Dicmo','SPLITSKO-DALMATINSKA',now(),now(),1),
#2927
('Kraj Donji',10299,'Marija Gorica','ZAGREBAČKA',now(),now(),1),
#2928
('Kraj Drage',52231,'Nedešćina','ISTARSKA',now(),now(),1),
#2929
('Kraj Gornji -južni dio',10293,'Dubravica','ZAGREBAČKA',now(),now(),1),
#2930
('Kraj Gornji -sjeverni dio',10293,'Dubravica','ZAGREBAČKA',now(),now(),1),
#2931
('Krajačići',35252,'Sibinj','BRODSKO-POSAVSKA',now(),now(),1),
#2932
('Krajcar Brijeg',52341,'Žminj','ISTARSKA',now(),now(),1),
#2933
('Krajići',52428,'Oprtalj (Portole)','ISTARSKA',now(),now(),1),
#2934
('Krajiška Kutinica',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2935
('Krajna',33514,'Čačinci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2936
('Krajska Vas',10296,'Luka','ZAGREBAČKA',now(),now(),1),
#2937
('Krakar',47313,'Drežnica','KARLOVAČKA',now(),now(),1),
#2938
('Kraljev Vrh',10297,'Jakovlje','ZAGREBAČKA',now(),now(),1),
#2939
('Kraljev Vrh',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#2940
('Kraljev Vrh',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#2941
('Kraljeva Velika',44322,'Lipovljani','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2942
('Kraljevac',21255,'Zadvarje','SPLITSKO-DALMATINSKA',now(),now(),1),
#2943
('Kraljevac',43212,'Rovišće','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2944
('Kraljevčani',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2945
('Kraljevec na Sutli',49294,'Kraljevec na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2946
('Kraljevec Radobojski',49232,'Radoboj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2947
('Kraljevec Šemnički',49232,'Radoboj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2948
('Kraljevica',51262,'Kraljevica','PRIMORSKO-GORANSKA',now(),now(),1),
#2949
('Kraljevo Selo',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#2950
('Krančići',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#2951
('Krančići',52464,'Kaštelir (Castelliere)','ISTARSKA',now(),now(),1),
#2952
('Kranjci',52220,'Labin','ISTARSKA',now(),now(),1),
#2953
('Kranjci',51307,'Prezid','PRIMORSKO-GORANSKA',now(),now(),1),
#2954
('Krapan',52223,'Raša','ISTARSKA',now(),now(),1),
#2955
('Krapanj',22000,'Šibenik','ŠIBENSKO-KNINSKA',now(),now(),1),
#2956
('Krapina',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2957
('Krapina Selo',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2958
('Krapinica',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2959
('Krapinske Toplice',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#2960
('Krapje',44325,'Krapje','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2961
('Kras',52425,'Roč','ISTARSKA',now(),now(),1),
#2962
('Kras',51514,'Dobrinj','PRIMORSKO-GORANSKA',now(),now(),1),
#2963
('Krasica',52460,'Buje (Buie)','ISTARSKA',now(),now(),1),
#2964
('Krasica',51224,'Krasica','PRIMORSKO-GORANSKA',now(),now(),1),
#2965
('Kraskovići',33514,'Čačinci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2966
('Krasno',53274,'Krasno','LIČKO-SENJSKA',now(),now(),1),
#2967
('Krašić',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#2968
('Kratečko',44213,'Kratečko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2969
('Kravarsko',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#2970
('Kravljak',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#2971
('Kravljak',33533,'Pivnica Slavonska','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2972
('Krbava',53236,'Podlapača','LIČKO-SENJSKA',now(),now(),1),
#2973
('Krbavčići',52420,'Buzet','ISTARSKA',now(),now(),1),
#2974
('Krbavica',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#2975
('Krbune',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#2976
('Krbune',52333,'Podpićan','ISTARSKA',now(),now(),1),
#2977
('Krculi',52341,'Žminj','ISTARSKA',now(),now(),1),
#2978
('Krč',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#2979
('Krč Bosiljevski',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#2980
('Krčenik',31530,'Podravska Moslavina','OSJEČKO-BARANJSKA',now(),now(),1),
#2981
('Krčevina',31511,'Đurđenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#2982
('Kreča Ves',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#2983
('Kremenići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#2984
('Kresini',52341,'Žminj','ISTARSKA',now(),now(),1),
#2985
('Kreševo',21250,'Šestanovac','SPLITSKO-DALMATINSKA',now(),now(),1),
#2986
('Kreštelovac',43506,'Dežanovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2987
('Kričina',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#2988
('Kričke',22320,'Drniš','ŠIBENSKO-KNINSKA',now(),now(),1),
#2989
('Kričke',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2990
('Kričke',44330,'Novska','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2991
('Kringa',52444,'Tinjan','ISTARSKA',now(),now(),1),
#2992
('Krištanovec',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#2993
('Krivac',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#2994
('Krivaj',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#2995
('Krivaj',44322,'Lipovljani','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2996
('Krivaj Sunjski',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#2997
('Krivaja',43232,'Berek','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#2998
('Krivaja Pustara',33507,'Crnac','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#2999
('Krivaja Vojnićka',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#3000
('Krivi Put',53271,'Krivi Put','LIČKO-SENJSKA',now(),now(),1),
#3001
('Krivodol',21242,'Grab','SPLITSKO-DALMATINSKA',now(),now(),1),
#3002
('Krivodol',21263,'Krivodol','SPLITSKO-DALMATINSKA',now(),now(),1),
#3003
('Križ',10314,'Križ','ZAGREBAČKA',now(),now(),1),
#3004
('Križ Brdovečki',10299,'Marija Gorica','ZAGREBAČKA',now(),now(),1),
#3005
('Križ Gornji',43202,'Zrinski Topolovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3006
('Križ Hrastovački',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3007
('Križ Kamenica',53261,'Križpolje','LIČKO-SENJSKA',now(),now(),1),
#3008
('Križ Koranski',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#3009
('Križanci',52341,'Žminj','ISTARSKA',now(),now(),1),
#3010
('Križanče',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#3011
('Križanče',49221,'Bedekovčina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3012
('Križančići',47201,'Draganići','KARLOVAČKA',now(),now(),1),
#3013
('Križanec',42204,'Turčin','VARAŽDINSKA',now(),now(),1),
#3014
('Križci',10312,'Kloštar Ivanić','ZAGREBAČKA',now(),now(),1),
#3015
('Križevci',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3016
('Križevčec',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#3017
('Križic',43231,'Ivanska','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3018
('Križine',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#3019
('Križišće',51241,'Križišće','PRIMORSKO-GORANSKA',now(),now(),1),
#3020
('Križnica',33405,'Pitomača','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3021
('Križovec',40315,'Mursko Središče','MEĐIMURSKA',now(),now(),1),
#3022
('Križovljan',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#3023
('Križovljan Radovečki',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#3024
('Križpolje',53261,'Križpolje','LIČKO-SENJSKA',now(),now(),1),
#3025
('Krk',51500,'Krk','PRIMORSKO-GORANSKA',now(),now(),1),
#3026
('Krkač',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#3027
('Krkanec',42205,'Vidovec','VARAŽDINSKA',now(),now(),1),
#3028
('Krković',22214,'Čista Velika','ŠIBENSKO-KNINSKA',now(),now(),1),
#3029
('Krkuž',52425,'Roč','ISTARSKA',now(),now(),1),
#3030
('Krmed',52211,'Bale (Valle)','ISTARSKA',now(),now(),1),
#3031
('Krmpotske Vodice',51252,'Klenovica','PRIMORSKO-GORANSKA',now(),now(),1),
#3032
('Krndija',31424,'Punitovci','OSJEČKO-BARANJSKA',now(),now(),1),
#3033
('Krneza',23248,'Ražanac','ZADARSKA',now(),now(),1),
#3034
('Krnežići',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#3035
('Krnica',52208,'Krnica','ISTARSKA',now(),now(),1),
#3036
('Krničari',52341,'Žminj','ISTARSKA',now(),now(),1),
#3037
('Krnići',21255,'Zadvarje','SPLITSKO-DALMATINSKA',now(),now(),1),
#3038
('Krnjak',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#3039
('Krnjeuve',22305,'Kistanje','ŠIBENSKO-KNINSKA',now(),now(),1),
#3040
('Kropinjak',52420,'Buzet','ISTARSKA',now(),now(),1),
#3041
('Krstatice',21272,'Slivno','SPLITSKO-DALMATINSKA',now(),now(),1),
#3042
('Krstinja',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#3043
('Krš',53203,'Kosinj','LIČKO-SENJSKA',now(),now(),1),
#3044
('Kršan',52232,'Kršan','ISTARSKA',now(),now(),1),
#3045
('Kršanci',52341,'Žminj','ISTARSKA',now(),now(),1),
#3046
('Krščenovec',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#3047
('Kršete',52474,'Brtonigla (Verteneglio)','ISTARSKA',now(),now(),1),
#3048
('Kršikla',52000,'Pazin','ISTARSKA',now(),now(),1),
#3049
('Kršinci',31433,'Podgorač','OSJEČKO-BARANJSKA',now(),now(),1),
#3050
('Kršuli',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#3051
('Krti',52427,'Livade (Levade)','ISTARSKA',now(),now(),1),
#3052
('Kruge',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#3053
('Krunčići',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#3054
('Krunoslavje',31543,'Miholjački Poreč','OSJEČKO-BARANJSKA',now(),now(),1),
#3055
('Krupa',23450,'Obrovac','ZADARSKA',now(),now(),1),
#3056
('Krupače',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#3057
('Krušak',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#3058
('Kruščica',53203,'Kosinj','LIČKO-SENJSKA',now(),now(),1),
#3059
('Kruševica',35220,'Slavonski Šamac','BRODSKO-POSAVSKA',now(),now(),1),
#3060
('Kruševo',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3061
('Kruševo',23450,'Obrovac','ZADARSKA',now(),now(),1),
#3062
('Kruševo',22204,'Široke','ŠIBENSKO-KNINSKA',now(),now(),1),
#3063
('Kruškovac',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#3064
('Kruškovača',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#3065
('Krušljevac',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#3066
('Krušljevec',42214,'Sveti Ilija','VARAŽDINSKA',now(),now(),1),
#3067
('Krušljevo Selo',49243,'Oroslavje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3068
('Krušvar',21232,'Dicmo','SPLITSKO-DALMATINSKA',now(),now(),1),
#3069
('Krušvari',52420,'Buzet','ISTARSKA',now(),now(),1),
#3070
('Krvavac I',20341,'Kula Norinska','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3071
('Krvavac II',20350,'Metković','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3072
('Krvavica',21320,'Baška Voda','SPLITSKO-DALMATINSKA',now(),now(),1),
#3073
('Krželji',21255,'Zadvarje','SPLITSKO-DALMATINSKA',now(),now(),1),
#3074
('Kuberton',52462,'Momjan (Momiano)','ISTARSKA',now(),now(),1),
#3075
('Kučaj',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#3076
('Kučari',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3077
('Kuče',10419,'Vukovina','ZAGREBAČKA',now(),now(),1),
#3078
('Kučeli',51211,'Matulji','PRIMORSKO-GORANSKA',now(),now(),1),
#3079
('Kučer',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#3080
('Kučiće',21208,'Kučiće','SPLITSKO-DALMATINSKA',now(),now(),1),
#3081
('Kučilovina',10362,'Kašina','GRAD ZAGREB',now(),now(),1),
#3082
('Kučine',21209,'Mravince','SPLITSKO-DALMATINSKA',now(),now(),1),
#3083
('Kućan Ludbreški',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#3084
('Kućan Marof',42000,'Varaždin','VARAŽDINSKA',now(),now(),1),
#3085
('Kućanci',31542,'Magadenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#3086
('Kućanci Đakovački',31418,'Drenje','OSJEČKO-BARANJSKA',now(),now(),1),
#3087
('Kućanec',10360,'Sesvete','GRAD ZAGREB',now(),now(),1),
#3088
('Kućari',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#3089
('Kućevice',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#3090
('Kućibreg',52462,'Momjan (Momiano)','ISTARSKA',now(),now(),1),
#3091
('Kućišta Cesarička',53288,'Karlobag','LIČKO-SENJSKA',now(),now(),1),
#3092
('Kućište',20267,'Kućište','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3093
('Kujići',52207,'Barban','ISTARSKA',now(),now(),1),
#3094
('Kujnik',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3095
('Kujnik',35250,'Oriovac','BRODSKO-POSAVSKA',now(),now(),1),
#3096
('Kuk',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#3097
('Kukci',52446,'Nova Vas','ISTARSKA',now(),now(),1),
#3098
('Kukljica',23271,'Kukljica','ZADARSKA',now(),now(),1),
#3099
('Kukljić',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#3100
('Kukuljani',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#3101
('Kukuljanovo',51227,'Kukuljanovo','PRIMORSKO-GORANSKA',now(),now(),1),
#3102
('Kukunjevac',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3103
('Kukurini',52332,'Pićan','ISTARSKA',now(),now(),1),
#3104
('Kula',34343,'Bektež','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3105
('Kula Atlagić',23420,'Benkovac','ZADARSKA',now(),now(),1),
#3106
('Kula Norinska',20341,'Kula Norinska','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3107
('Kuljaji',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#3108
('Kuljani',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3109
('Kumrovec',49295,'Kumrovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3110
('Kuna Konavoska',20217,'Pridvorje','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3111
('Kuna Pelješka',20243,'Kuna','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3112
('Kunčani',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#3113
('Kunđevec',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3114
('Kunić',47304,'Plaški','KARLOVAČKA',now(),now(),1),
#3115
('Kunić Ribnički',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#3116
('Kunišinci',31555,'Marijanci','OSJEČKO-BARANJSKA',now(),now(),1),
#3117
('Kunovac',23452,'Karin','ZADARSKA',now(),now(),1),
#3118
('Kunovac Kupirovački',23445,'Srb','ZADARSKA',now(),now(),1),
#3119
('Kunovci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3120
('Kunovec',48311,'Kunovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3121
('Kunovec Breg',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3122
('Kunj',52220,'Labin','ISTARSKA',now(),now(),1),
#3123
('Kupa',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#3124
('Kupari',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3125
('Kupčina Žumberačka',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#3126
('Kupeć Dol',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#3127
('Kupina',35216,'Prnjavor','BRODSKO-POSAVSKA',now(),now(),1),
#3128
('Kupinec',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#3129
('Kupinečki Kraljevec',10257,'Brezovica','GRAD ZAGREB',now(),now(),1),
#3130
('Kupinovac',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3131
('Kupirovo',23445,'Srb','ZADARSKA',now(),now(),1),
#3132
('Kupjak',51313,'Kupjak','PRIMORSKO-GORANSKA',now(),now(),1),
#3133
('Kupljenovo',10295,'Kupljenovo','ZAGREBAČKA',now(),now(),1),
#3134
('Kupljensko',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#3135
('Kurili',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#3136
('Kurjak',53234,'Udbina','LIČKO-SENJSKA',now(),now(),1),
#3137
('Kurjavići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#3138
('Kurpezova Gorica',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#3139
('Kuršanec',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#3140
('Kusaja',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#3141
('Kusanovec',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#3142
('Kusijevec',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3143
('Kusonje',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3144
('Kustići',53296,'Zubovići','LIČKO-SENJSKA',now(),now(),1),
#3145
('Kuševac',31400,'Đakovo','OSJEČKO-BARANJSKA',now(),now(),1),
#3146
('Kuštani',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3147
('Kutanja',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#3148
('Kuterevo',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#3149
('Kutina',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3150
('Kutinica',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3151
('Kutinska Slatina',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3152
('Kutjevo',34340,'Kutjevo','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3153
('Kutnjak',48317,'Legrad','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3154
('Kutovi',33513,'Zdenci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3155
('Kuzma',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3156
('Kuzma Perjasička',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#3157
('Kuzmica',34311,'Kuzmica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3158
('Kuzminec',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3159
('Kuzminec Miljanski',49296,'Zagorska Sela','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3160
('Kuzminec/dio/1-81 i 88-dalje',49252,'Mihovljan','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3161
('Kuzminec/dio/82-87',49255,'Novi Golubovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3162
('Kuželj',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#3163
('Kvarte',53202,'Perušić','LIČKO-SENJSKA',now(),now(),1),
#3164
('Labin',52220,'Labin','ISTARSKA',now(),now(),1),
#3165
('Labin',21201,'Prgomet','SPLITSKO-DALMATINSKA',now(),now(),1),
#3166
('Labinci',52464,'Kaštelir (Castelliere)','ISTARSKA',now(),now(),1),
#3167
('Lacići',31542,'Magadenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#3168
('Ladešići',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#3169
('Ladići',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#3170
('Ladimirevci',31550,'Valpovo','OSJEČKO-BARANJSKA',now(),now(),1),
#3171
('Ladina',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#3172
('Ladinec',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3173
('Ladislav',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3174
('Ladislav Sokolovački',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3175
('Ladislavec',49250,'Zlatar','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3176
('Ladrovići',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#3177
('Ladvenjak',47241,'Cerovac Vukmanički','KARLOVAČKA',now(),now(),1),
#3178
('Ladvić',51260,'Crikvenica','PRIMORSKO-GORANSKA',now(),now(),1),
#3179
('Lađanska',31225,'Breznica Našička','OSJEČKO-BARANJSKA',now(),now(),1),
#3180
('Lađevac',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#3181
('Lađevačko Selište',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#3182
('Lađevci',22214,'Čista Velika','ŠIBENSKO-KNINSKA',now(),now(),1),
#3183
('Laginji',52341,'Žminj','ISTARSKA',now(),now(),1),
#3184
('Lakmartin',51517,'Kornić','PRIMORSKO-GORANSKA',now(),now(),1),
#3185
('Lakovići',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#3186
('Laktac',21233,'Hrvace','SPLITSKO-DALMATINSKA',now(),now(),1),
#3187
('Laktec',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#3188
('Lakušija',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3189
('Lalići',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3190
('Laminac',43246,'Štefanje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3191
('Lančić',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#3192
('Lanišće',52232,'Kršan','ISTARSKA',now(),now(),1),
#3193
('Lanišće',52422,'Lanišće','ISTARSKA',now(),now(),1),
#3194
('Lanišće',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#3195
('Lapat',47304,'Plaški','KARLOVAČKA',now(),now(),1),
#3196
('Lapovci',31411,'Trnava','OSJEČKO-BARANJSKA',now(),now(),1),
#3197
('Lapšina',40313,'Sveti Martin na Muri','MEĐIMURSKA',now(),now(),1),
#3198
('Lasinja',47206,'Lasinja','KARLOVAČKA',now(),now(),1),
#3199
('Laslavići',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#3200
('Laslovo',31214,'Laslovo (Szentl&#225;szl&#243;)','OSJEČKO-BARANJSKA',now(),now(),1),
#3201
('Lasovac',43273,'Bulinac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3202
('Lasovac-Brdo',43273,'Bulinac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3203
('Lastine',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3204
('Lastovo',20290,'Lastovo','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3205
('Lašići',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#3206
('Latin',47304,'Plaški','KARLOVAČKA',now(),now(),1),
#3207
('Latinovac',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3208
('Lautari',51307,'Prezid','PRIMORSKO-GORANSKA',now(),now(),1),
#3209
('Laz',23234,'Vir','ZADARSKA',now(),now(),1),
#3210
('Laz Bistrički',49246,'Marija Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3211
('Laz Stubički',49246,'Marija Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3212
('Lazac Lokvarski',51316,'Lokve','PRIMORSKO-GORANSKA',now(),now(),1),
#3213
('Lazarići',52232,'Kršan','ISTARSKA',now(),now(),1),
#3214
('Laze',35422,'Zapolje','BRODSKO-POSAVSKA',now(),now(),1),
#3215
('Laze Prnjavor',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3216
('Lazi',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#3217
('Lazi Krapinski',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3218
('Lazi Turopoljski',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#3219
('Lazina',47201,'Draganići','KARLOVAČKA',now(),now(),1),
#3220
('Lazina Čička',10415,'Novo Čiče','ZAGREBAČKA',now(),now(),1),
#3221
('Lećevica',21202,'Lećevica','SPLITSKO-DALMATINSKA',now(),now(),1),
#3222
('Ledenice',51251,'Ledenice','PRIMORSKO-GORANSKA',now(),now(),1),
#3223
('Ledenik',31224,'Koška','OSJEČKO-BARANJSKA',now(),now(),1),
#3224
('Ledenik Cesarički',53288,'Karlobag','LIČKO-SENJSKA',now(),now(),1),
#3225
('Ledina',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#3226
('Ledine Klanječke',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3227
('Ledinec',42201,'Beretinec','VARAŽDINSKA',now(),now(),1),
#3228
('Legovići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#3229
('Legrad',48317,'Legrad','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3230
('Lekenik',44272,'Lekenik','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3231
('Lekneno',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#3232
('Lemeš',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3233
('Lemeš Križevački',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3234
('Lenišće',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3235
('Lepa Ves',49240,'Donja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3236
('Lepajci',49224,'Lepajci','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3237
('Lepavina',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3238
('Lepenica',22206,'Boraja','ŠIBENSKO-KNINSKA',now(),now(),1),
#3239
('Lepoglava',42250,'Lepoglava','VARAŽDINSKA',now(),now(),1),
#3240
('Lepoglavec',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3241
('Leprovica',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#3242
('Lepšić',10310,'Ivanić-Grad','ZAGREBAČKA',now(),now(),1),
#3243
('Lepuri',23420,'Benkovac','ZADARSKA',now(),now(),1),
#3244
('Lesci',51328,'Lukovdol','PRIMORSKO-GORANSKA',now(),now(),1),
#3245
('Lesišćina',52426,'Lupoglav','ISTARSKA',now(),now(),1),
#3246
('Leska',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#3247
('Leskova Draga',51313,'Kupjak','PRIMORSKO-GORANSKA',now(),now(),1),
#3248
('Leskovac Barilovićki',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#3249
('Leskovec',40312,'Štrigova','MEĐIMURSKA',now(),now(),1),
#3250
('Leskovec Toplički',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#3251
('Lešće',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#3252
('Leštakovec',42203,'Jalžabet','VARAŽDINSKA',now(),now(),1),
#3253
('Letaj',52232,'Kršan','ISTARSKA',now(),now(),1),
#3254
('Letajac',52220,'Labin','ISTARSKA',now(),now(),1),
#3255
('Letičani',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3256
('Letinac',53260,'Brinje','LIČKO-SENJSKA',now(),now(),1),
#3257
('Letovanić',44273,'Sela','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3258
('Letovčan Novodvorski',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3259
('Letovčan Tomaševečki',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3260
('Levanjska Varoš',31416,'Levanjska Varoš','OSJEČKO-BARANJSKA',now(),now(),1),
#3261
('Levinovac',33533,'Pivnica Slavonska','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3262
('Levkušje',47286,'Mahično','KARLOVAČKA',now(),now(),1),
#3263
('Lič',51323,'Lič','PRIMORSKO-GORANSKA',now(),now(),1),
#3264
('Lička Jesenica',47306,'Saborsko','KARLOVAČKA',now(),now(),1),
#3265
('Lički Čitluk',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#3266
('Lički Novi',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#3267
('Lički Osik',53201,'Lički Osik','LIČKO-SENJSKA',now(),now(),1),
#3268
('Lički Ribnik',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#3269
('Ličko Cerje',53244,'Lovinac','LIČKO-SENJSKA',now(),now(),1),
#3270
('Ličko Lešće',53224,'Ličko Lešće','LIČKO-SENJSKA',now(),now(),1),
#3271
('Ličko Novo Selo',31511,'Đurđenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#3272
('Ličko Petrovo Selo',53233,'Ličko Petrovo Selo','LIČKO-SENJSKA',now(),now(),1),
#3273
('Liganj',51415,'Lovran','PRIMORSKO-GORANSKA',now(),now(),1),
#3274
('Liješće',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#3275
('Lijeva Luka',44201,'Martinska Ves','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3276
('Lijeva Martinska Ves',44201,'Martinska Ves','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3277
('Lijevi Degoj',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#3278
('Lijevi Dubrovčak',10316,'Lijevi Dubrovčak','ZAGREBAČKA',now(),now(),1),
#3279
('Lijevi Štefanki',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#3280
('Lijevo Sredičko',10451,'Pisarovina','ZAGREBAČKA',now(),now(),1),
#3281
('Lijevo Trebarjevo',44201,'Martinska Ves','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3282
('Lijevo Željezno',44201,'Martinska Ves','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3283
('Lila',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#3284
('Linardići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#3285
('Lindar',52000,'Pazin','ISTARSKA',now(),now(),1),
#3286
('Lipa',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#3287
('Lipa',51214,'Šapjane','PRIMORSKO-GORANSKA',now(),now(),1),
#3288
('Lipice',53261,'Križpolje','LIČKO-SENJSKA',now(),now(),1),
#3289
('Lipik',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3290
('Lipine',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#3291
('Lipje',47212,'Skakavac','KARLOVAČKA',now(),now(),1),
#3292
('Liplje',51329,'Severin na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#3293
('Lipnica',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#3294
('Lipnica',10253,'Donji Dragonožec','GRAD ZAGREB',now(),now(),1),
#3295
('Lipnica Zagorska',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3296
('Lipnik',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#3297
('Lipošćaki',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#3298
('Lipov Pesak',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#3299
('Lipovac',32246,'Lipovac','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#3300
('Lipovac',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#3301
('Lipovac',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3302
('Lipovac',33411,'Gradina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3303
('Lipovac Hrastinski',31403,'Vuka','OSJEČKO-BARANJSKA',now(),now(),1),
#3304
('Lipovac Krstinjski',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#3305
('Lipovac Majur',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3306
('Lipovača',32010,'Vukovar','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#3307
('Lipovača Drežnička',47246,'Drežnik Grad','KARLOVAČKA',now(),now(),1),
#3308
('Lipovčani',43211,'Predavac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3309
('Lipovec',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3310
('Lipovec Lonjski',10312,'Kloštar Ivanić','ZAGREBAČKA',now(),now(),1),
#3311
('Lipovljani',44322,'Lipovljani','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3312
('Lipovlje',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#3313
('Lipovnik',42244,'Klenovnik','VARAŽDINSKA',now(),now(),1),
#3314
('Lipovo Brdo',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3315
('Lipovo Polje',53203,'Kosinj','LIČKO-SENJSKA',now(),now(),1),
#3316
('Lisac',51217,'Klana','PRIMORSKO-GORANSKA',now(),now(),1),
#3317
('Lisac',20231,'Doli','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3318
('Lisičić',23420,'Benkovac','ZADARSKA',now(),now(),1),
#3319
('Lisičina Gorica',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#3320
('Lisičine',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3321
('Lisine',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#3322
('Liska',21232,'Dicmo','SPLITSKO-DALMATINSKA',now(),now(),1),
#3323
('Lišane Ostrovičke',23420,'Benkovac','ZADARSKA',now(),now(),1),
#3324
('Lišane Tinjske',23423,'Polača','ZADARSKA',now(),now(),1),
#3325
('Lišnica',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#3326
('Lišnjak',22320,'Drniš','ŠIBENSKO-KNINSKA',now(),now(),1),
#3327
('Livade',52427,'Livade (Levade)','ISTARSKA',now(),now(),1),
#3328
('Livađani',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3329
('Livana',31431,'Čepin','OSJEČKO-BARANJSKA',now(),now(),1),
#3330
('Ližnjan',52204,'Ližnjan (Lisignano)','ISTARSKA',now(),now(),1),
#3331
('Lobor',49253,'Lobor','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3332
('Loborika',52206,'Marčana','ISTARSKA',now(),now(),1),
#3333
('Lokošin Dol',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#3334
('Lokva Rogoznica',21317,'Lokva Rogoznica','SPLITSKO-DALMATINSKA',now(),now(),1),
#3335
('Lokve',51316,'Lokve','PRIMORSKO-GORANSKA',now(),now(),1),
#3336
('Lokvica',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#3337
('Lokvičići',21263,'Krivodol','SPLITSKO-DALMATINSKA',now(),now(),1),
#3338
('Lončar Brdo',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#3339
('Lončarica',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3340
('Londžica',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#3341
('Lonja',44203,'Gušće','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3342
('Lonjgari',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#3343
('Lonjica',10341,'Lonjica','ZAGREBAČKA',now(),now(),1),
#3344
('Lopača',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#3345
('Lopar',51281,'Lopar','PRIMORSKO-GORANSKA',now(),now(),1),
#3346
('Lopatinec',40311,'Lopatinec','MEĐIMURSKA',now(),now(),1),
#3347
('Lopud',20222,'Lopud','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3348
('Loskunja',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#3349
('Lotine',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3350
('Lovas',32237,'Lovas','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#3351
('Lovča',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3352
('Lovčić',35253,'Brodski Stupnik','BRODSKO-POSAVSKA',now(),now(),1),
#3353
('Lović Prekriški',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#3354
('Lovinac',53244,'Lovinac','LIČKO-SENJSKA',now(),now(),1),
#3355
('Lovinac',23241,'Poličnik','ZADARSKA',now(),now(),1),
#3356
('Lovište',20269,'Lovište','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3357
('Lovorje',20357,'Blace','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3358
('Lovorno',20217,'Pridvorje','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3359
('Lovran',51415,'Lovran','PRIMORSKO-GORANSKA',now(),now(),1),
#3360
('Lovranska Draga',51415,'Lovran','PRIMORSKO-GORANSKA',now(),now(),1),
#3361
('Lovrečan',49247,'Zlatar Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3362
('Lovrečan',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#3363
('Lovrečica',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#3364
('Lovrečka Varoš',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#3365
('Lovrečka Velika',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#3366
('Lovreć',21257,'Lovreć','SPLITSKO-DALMATINSKA',now(),now(),1),
#3367
('Lovreća Sela',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3368
('Lovrentovec',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#3369
('Lovska',44330,'Novska','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3370
('Lozan',33404,'Špišić Bukovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3371
('Lozari',52460,'Buje (Buie)','ISTARSKA',now(),now(),1),
#3372
('Lozica',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3373
('Lozice',23234,'Vir','ZADARSKA',now(),now(),1),
#3374
('Loznati',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#3375
('Lozovac',22221,'Lozovac','ŠIBENSKO-KNINSKA',now(),now(),1),
#3376
('Ložišća',21404,'Ložišća','SPLITSKO-DALMATINSKA',now(),now(),1),
#3377
('Ložnice',22204,'Široke','ŠIBENSKO-KNINSKA',now(),now(),1),
#3378
('Lubarska',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#3379
('Lubena',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#3380
('Lubenice',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#3381
('Luč',31300,'Beli Manastir','OSJEČKO-BARANJSKA',now(),now(),1),
#3382
('Lučane',21230,'Sinj','SPLITSKO-DALMATINSKA',now(),now(),1),
#3383
('Lučelnica',10451,'Pisarovina','ZAGREBAČKA',now(),now(),1),
#3384
('Lučelnica Tomaševečka',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3385
('Lučica',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#3386
('Lučica',23234,'Vir','ZADARSKA',now(),now(),1),
#3387
('Lučice',51300,'Delnice','PRIMORSKO-GORANSKA',now(),now(),1),
#3388
('Lučinci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3389
('Lučko',10250,'Lučko','GRAD ZAGREB',now(),now(),1),
#3390
('Ludbreg',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#3391
('Ludbreški Ivanec',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3392
('Ludinica',44316,'Velika Ludina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3393
('Ludvinci',32225,'Bobota','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#3394
('Lug',47201,'Draganići','KARLOVAČKA',now(),now(),1),
#3395
('Lug',31328,'Lug (Lask&#243;)','OSJEČKO-BARANJSKA',now(),now(),1),
#3396
('Lug Gradinski',33411,'Gradina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3397
('Lug Orehovički',49228,'Brestovec Orehovički','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3398
('Lug Pozn.-Naselje M.Novosela',49221,'Bedekovčina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3399
('Lug Pozn.-Naselje zagor.put',49221,'Bedekovčina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3400
('Lug Poznanovečki (dio)',49222,'Poznanovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3401
('Lug Samoborski',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#3402
('Lug Subotički',31224,'Koška','OSJEČKO-BARANJSKA',now(),now(),1),
#3403
('Lug Zabočki',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3404
('Lugarski Breg',10293,'Dubravica','ZAGREBAČKA',now(),now(),1),
#3405
('Luka',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#3406
('Luka',10296,'Luka','ZAGREBAČKA',now(),now(),1),
#3407
('Luka',20230,'Ston','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3408
('Luka',23282,'Žman','ZADARSKA',now(),now(),1),
#3409
('Luka Krmpotska',51252,'Klenovica','PRIMORSKO-GORANSKA',now(),now(),1),
#3410
('Luka Ludbreška',42233,'Sveti Đurđ','VARAŽDINSKA',now(),now(),1),
#3411
('Luka Pokupska',47203,'Rečica','KARLOVAČKA',now(),now(),1),
#3412
('Lukač',33406,'Lukač','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3413
('Lukač',34335,'Vetovo','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3414
('Lukačevec',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3415
('Lukačevec Toplički',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#3416
('Lukar',22303,'Oklaj','ŠIBENSKO-KNINSKA',now(),now(),1),
#3417
('Lukarišće',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#3418
('Lukavac',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3419
('Lukavec',10412,'Donja Lomnica','ZAGREBAČKA',now(),now(),1),
#3420
('Lukavec',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#3421
('Lukavec Klanječki',49294,'Kraljevec na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3422
('Lukavec Posavski',44203,'Gušće','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3423
('Lukavec Sutlanski',10293,'Dubravica','ZAGREBAČKA',now(),now(),1),
#3424
('Luke',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#3425
('Luke Poljanske',49296,'Zagorska Sela','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3426
('Lukeži',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#3427
('Lukinić Brdo',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#3428
('Lukinić Draga',47282,'Kamanje','KARLOVAČKA',now(),now(),1),
#3429
('Lukoran',23274,'Lukoran','ZADARSKA',now(),now(),1),
#3430
('Lukovčak',49225,'Đurmanec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3431
('Lukovdol',51328,'Lukovdol','PRIMORSKO-GORANSKA',now(),now(),1),
#3432
('Lukovec',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3433
('Lukovo',53284,'Sveti Juraj','LIČKO-SENJSKA',now(),now(),1),
#3434
('Lukovo',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#3435
('Lukovo Šugarje',53289,'Lukovo Šugarje','LIČKO-SENJSKA',now(),now(),1),
#3436
('Lukšići Ozaljski',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#3437
('Lumbarda',20263,'Lumbarda','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3438
('Lumbardenik',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#3439
('Lun',53294,'Lun','LIČKO-SENJSKA',now(),now(),1),
#3440
('Lunjkovec',42231,'Mali Bukovec','VARAŽDINSKA',now(),now(),1),
#3441
('Lupinjak',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3442
('Lupoglav',52426,'Lupoglav','ISTARSKA',now(),now(),1),
#3443
('Lupoglav',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#3444
('Luščani',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3445
('Lužan',10363,'Belovar','GRAD ZAGREB',now(),now(),1),
#3446
('Lužan Biškupečki',42204,'Turčin','VARAŽDINSKA',now(),now(),1),
#3447
('Lužani',35257,'Lužani','BRODSKO-POSAVSKA',now(),now(),1),
#3448
('Lužani Zagorski',49233,'Gornje Jesenje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3449
('Lužnica',10290,'Zaprešić','GRAD ZAGREB',now(),now(),1),
#3450
('Ljeskovac',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3451
('Lještani',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#3452
('Ljubač',23248,'Ražanac','ZADARSKA',now(),now(),1),
#3453
('Ljubač',20234,'Orašac','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3454
('Ljubač',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#3455
('Ljubački Stanovi',23248,'Ražanac','ZADARSKA',now(),now(),1),
#3456
('Ljubelj',42222,'Ljubeščica','VARAŽDINSKA',now(),now(),1),
#3457
('Ljubelj Kalnički',42222,'Ljubeščica','VARAŽDINSKA',now(),now(),1),
#3458
('Ljubešćica',42222,'Ljubeščica','VARAŽDINSKA',now(),now(),1),
#3459
('Ljubina',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3460
('Ljubitovica',21201,'Prgomet','SPLITSKO-DALMATINSKA',now(),now(),1),
#3461
('Ljubljanica',44201,'Martinska Ves','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3462
('Ljubostinje',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#3463
('Ljubošina',51327,'Gomirje','PRIMORSKO-GORANSKA',now(),now(),1),
#3464
('Ljubotić',22303,'Oklaj','ŠIBENSKO-KNINSKA',now(),now(),1),
#3465
('Ljubović',23440,'Gračac','ZADARSKA',now(),now(),1),
#3466
('Ljudevit Selo',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3467
('Ljupina',35400,'Nova Gradiška','BRODSKO-POSAVSKA',now(),now(),1),
#3468
('Ljut',21245,'Tijarica','SPLITSKO-DALMATINSKA',now(),now(),1),
#3469
('Ljuta',20217,'Pridvorje','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3470
('Ljutići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#3471
('Macinec',40306,'Macinec','MEĐIMURSKA',now(),now(),1),
#3472
('Macute',33522,'Voćin','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3473
('Mače',49251,'Mače','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3474
('Mački',10344,'Farkaševac','ZAGREBAČKA',now(),now(),1),
#3475
('Mačkovac',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3476
('Mačkovac',35400,'Nova Gradiška','BRODSKO-POSAVSKA',now(),now(),1),
#3477
('Mačkovec',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#3478
('Mačkovo Selo',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3479
('Madaraševec',42232,'Donji Martijanec','VARAŽDINSKA',now(),now(),1),
#3480
('Madžarevo',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#3481
('Madžari',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3482
('Magadenovac',31542,'Magadenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#3483
('Magadinovac',33515,'Orahovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3484
('Magić Mala',35410,'Nova Kapela','BRODSKO-POSAVSKA',now(),now(),1),
#3485
('Maglenča',43226,'Veliko Trojstvo','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3486
('Mahično',47286,'Mahično','KARLOVAČKA',now(),now(),1),
#3487
('Mahovo',44201,'Martinska Ves','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3488
('Maja',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3489
('Majar',31416,'Levanjska Varoš','OSJEČKO-BARANJSKA',now(),now(),1),
#3490
('Majdan',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3491
('Majer',51327,'Gomirje','PRIMORSKO-GORANSKA',now(),now(),1),
#3492
('Majerje',42206,'Petrijanec','VARAŽDINSKA',now(),now(),1),
#3493
('Majiške Međe',31323,'Bolman','OSJEČKO-BARANJSKA',now(),now(),1),
#3494
('Majkovec',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#3495
('Majkovi',20232,'Slano','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3496
('Majkusi',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#3497
('Majske Poljane',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3498
('Majski Trtnik',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3499
('Majur',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3500
('Majur',10344,'Farkaševac','ZAGREBAČKA',now(),now(),1),
#3501
('Majurec',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3502
('Makarska',21300,'Makarska','SPLITSKO-DALMATINSKA',now(),now(),1),
#3503
('Maklen',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#3504
('Makloševac',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#3505
('Makoše',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3506
('Makov Hrib',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#3507
('Makovci',52429,'Grožnjan (Grisignana)','ISTARSKA',now(),now(),1),
#3508
('Mala Babina Gora',43532,'Đulovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3509
('Mala Barna',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3510
('Mala Branjska',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3511
('Mala Bršljanica',43282,'Veliko Vukovje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3512
('Mala Buna',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#3513
('Mala Ciglena',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3514
('Mala Crkvina',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#3515
('Mala Črešnjevica',33405,'Pitomača','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3516
('Mala Dapčevica',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3517
('Mala Dobra',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#3518
('Mala Erpenja',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3519
('Mala Gora',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3520
('Mala Gorica',10431,'Sveta Nedjelja','ZAGREBAČKA',now(),now(),1),
#3521
('Mala Gradusa',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3522
('Mala Hrastilnica',10314,'Križ','ZAGREBAČKA',now(),now(),1),
#3523
('Mala Huba',52420,'Buzet','ISTARSKA',now(),now(),1),
#3524
('Mala Jasenovača',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3525
('Mala Jazbina',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#3526
('Mala Jelsa',47000,'Karlovac','KARLOVAČKA',now(),now(),1),
#3527
('Mala Klisa',33533,'Pivnica Slavonska','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3528
('Mala Kopanica',35221,'Velika Kopanica','BRODSKO-POSAVSKA',now(),now(),1),
#3529
('Mala Kosa',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#3530
('Mala Kosnica',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#3531
('Mala Lamljana',23272,'Kali','ZADARSKA',now(),now(),1),
#3532
('Mala Lešnica',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#3533
('Mala Ludina',44316,'Velika Ludina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3534
('Mala Milešina',21206,'Donje Ogorje','SPLITSKO-DALMATINSKA',now(),now(),1),
#3535
('Mala Mlaka',10020,'Zagreb-Novi Zagreb','GRAD ZAGREB',now(),now(),1),
#3536
('Mala Mlinska',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3537
('Mala Mučna',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3538
('Mala Ostrna',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#3539
('Mala Pačetina',49234,'Petrovsko','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3540
('Mala Paka',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#3541
('Mala Paukova',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3542
('Mala Peratovica',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3543
('Mala Pisanica',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3544
('Mala Plana',53213,'Donje Pazarište','LIČKO-SENJSKA',now(),now(),1),
#3545
('Mala Prespa',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3546
('Mala Rakovica',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#3547
('Mala Rasinjica',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3548
('Mala Rijeka',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3549
('Mala Solna',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3550
('Mala Subotica',40321,'Mala Subotica','MEĐIMURSKA',now(),now(),1),
#3551
('Mala Trapinska',33410,'Suhopolje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3552
('Mala Trnovitica',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3553
('Mala Učka',51414,'Ičići','PRIMORSKO-GORANSKA',now(),now(),1),
#3554
('Mala Vranovina',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3555
('Male Drage',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#3556
('Male Mune',51212,'Vele Mune','PRIMORSKO-GORANSKA',now(),now(),1),
#3557
('Male Sesvete',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3558
('Male Srakane',51550,'Mali Lošinj','PRIMORSKO-GORANSKA',now(),now(),1),
#3559
('Malešević Selo',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#3560
('Maletić',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#3561
('Mali Banovac',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3562
('Mali Bastaji',43531,'Veliki Bastaji','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3563
('Mali Bilač',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3564
('Mali Botinovac',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3565
('Mali Brezovec',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#3566
('Mali Brgud',51213,'Jurdani','PRIMORSKO-GORANSKA',now(),now(),1),
#3567
('Mali Budići',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3568
('Mali Budići',34553,'Bučje','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3569
('Mali Bukovec',42231,'Mali Bukovec','VARAŽDINSKA',now(),now(),1),
#3570
('Mali Bukovec',49251,'Mače','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3571
('Mali Carevdar',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3572
('Mali Dol',51241,'Križišće','PRIMORSKO-GORANSKA',now(),now(),1),
#3573
('Mali Erjavec',47281,'Mali Erjavec','KARLOVAČKA',now(),now(),1),
#3574
('Mali Golji',52220,'Labin','ISTARSKA',now(),now(),1),
#3575
('Mali Gorenec',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#3576
('Mali Grabičani',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3577
('Mali Gradac',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3578
('Mali Grđevac',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3579
('Mali Iž',23284,'Veli Iž','ZADARSKA',now(),now(),1),
#3580
('Mali Jadrč',51329,'Severin na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#3581
('Mali Komor',49251,'Mače','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3582
('Mali Kozinac',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#3583
('Mali Lipovec',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#3584
('Mali Lošinj',51550,'Mali Lošinj','PRIMORSKO-GORANSKA',now(),now(),1),
#3585
('Mali Lovrečan',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#3586
('Mali Lug',51304,'Gerovo','PRIMORSKO-GORANSKA',now(),now(),1),
#3587
('Mali Mihaljevec',40311,'Lopatinec','MEĐIMURSKA',now(),now(),1),
#3588
('Mali Miletinac',43531,'Veliki Bastaji','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3589
('Mali Mlun',52420,'Buzet','ISTARSKA',now(),now(),1),
#3590
('Mali Modrušpotok',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#3591
('Mali Obljaj',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3592
('Mali Otok',48317,'Legrad','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3593
('Mali Pašijan',43280,'Garešnica','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3594
('Mali Podol',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#3595
('Mali Poganac',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3596
('Mali Potočec',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3597
('Mali Prolog',20278,'Nova Sela','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3598
('Mali Rastovac',33507,'Crnac','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3599
('Mali Raven',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3600
('Mali Ston',20230,'Ston','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3601
('Mali Tabor',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3602
('Mali Turini',52220,'Labin','ISTARSKA',now(),now(),1),
#3603
('Mali Vareški',52208,'Krnica','ISTARSKA',now(),now(),1),
#3604
('Mali Vrh Kamanjski',47282,'Kamanje','KARLOVAČKA',now(),now(),1),
#3605
('Mali Vuković',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#3606
('Mali Zdenci',43293,'Veliki Zdenci','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3607
('Malička',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3608
('Malik',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#3609
('Malinci',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#3610
('Malino',35250,'Oriovac','BRODSKO-POSAVSKA',now(),now(),1),
#3611
('Malinovac',31542,'Magadenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#3612
('Malinska',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#3613
('Malo Grablje',21450,'Hvar','SPLITSKO-DALMATINSKA',now(),now(),1),
#3614
('Malo Gradišće',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#3615
('Malo Korenovo',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3616
('Malo Krčevo',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3617
('Malo Polje',53202,'Perušić','LIČKO-SENJSKA',now(),now(),1),
#3618
('Malo Selce',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#3619
('Malo Selo',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#3620
('Malo Trojstvo',43226,'Veliko Trojstvo','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3621
('Malo Vukovje',43283,'Kaniška Iva','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3622
('Malunje',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#3623
('Maljevac',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#3624
('Maljevačko Selište',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#3625
('Maljkovo',21233,'Hrvace','SPLITSKO-DALMATINSKA',now(),now(),1),
#3626
('Mandalenčići',52403,'Gračišće','ISTARSKA',now(),now(),1),
#3627
('Mandić Selo',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#3628
('Mandićevac',31418,'Drenje','OSJEČKO-BARANJSKA',now(),now(),1),
#3629
('Mandli',51303,'Plešce','PRIMORSKO-GORANSKA',now(),now(),1),
#3630
('Mandre',23251,'Kolan','ZADARSKA',now(),now(),1),
#3631
('Mantovani',52332,'Pićan','ISTARSKA',now(),now(),1),
#3632
('Manja Vas',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#3633
('Manjadvorci',52207,'Barban','ISTARSKA',now(),now(),1),
#3634
('Manjerovići',47241,'Cerovac Vukmanički','KARLOVAČKA',now(),now(),1),
#3635
('Maovice',21236,'Vrlika','SPLITSKO-DALMATINSKA',now(),now(),1),
#3636
('Maračići',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#3637
('Maranovići',20224,'Maranovići','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3638
('Marasi',52450,'Vrsar (Orsera)','ISTARSKA',now(),now(),1),
#3639
('Maravić Draga',47313,'Drežnica','KARLOVAČKA',now(),now(),1),
#3640
('Marceljani',52220,'Labin','ISTARSKA',now(),now(),1),
#3641
('Marčan',42207,'Vinica','VARAŽDINSKA',now(),now(),1),
#3642
('Marčana',52206,'Marčana','ISTARSKA',now(),now(),1),
#3643
('Marčani',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3644
('Marčelji',51216,'Viškovo','PRIMORSKO-GORANSKA',now(),now(),1),
#3645
('Marčenegla',52420,'Buzet','ISTARSKA',now(),now(),1),
#3646
('Mareda',52466,'Novigrad (Cittanova)','ISTARSKA',now(),now(),1),
#3647
('Marenić',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#3648
('Maretić',49283,'Hraščina-Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3649
('Margečan',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#3650
('Marići',43211,'Predavac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3651
('Marići',52220,'Labin','ISTARSKA',now(),now(),1),
#3652
('Marići',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#3653
('Marigutić',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3654
('Marija Bistrica',49246,'Marija Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3655
('Marija Gorica',10299,'Marija Gorica','ZAGREBAČKA',now(),now(),1),
#3656
('Marija Magdalena',10294,'Donja Pušća','ZAGREBAČKA',now(),now(),1),
#3657
('Marija Trošt',51300,'Delnice','PRIMORSKO-GORANSKA',now(),now(),1),
#3658
('Marijanci',31555,'Marijanci','OSJEČKO-BARANJSKA',now(),now(),1),
#3659
('Marina',21222,'Marina','SPLITSKO-DALMATINSKA',now(),now(),1),
#3660
('Marinbrod',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3661
('Marinci',32221,'Nuštar','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#3662
('Marinci',52420,'Buzet','ISTARSKA',now(),now(),1),
#3663
('Marindolsko Brdo',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#3664
('Marindvor',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3665
('Marine Zemlje',21480,'Vis','SPLITSKO-DALMATINSKA',now(),now(),1),
#3666
('Marinec',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3667
('Marinići',51216,'Viškovo','PRIMORSKO-GORANSKA',now(),now(),1),
#3668
('Marino Selo',34543,'Poljana','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3669
('Marinovec',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3670
('Marinovec Zelinski',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#3671
('Marjančanci',31227,'Zelčin','OSJEČKO-BARANJSKA',now(),now(),1),
#3672
('Marjanski Ivanovci',31555,'Marijanci','OSJEČKO-BARANJSKA',now(),now(),1),
#3673
('Markoci',52220,'Labin','ISTARSKA',now(),now(),1),
#3674
('Markovac',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#3675
('Markovac',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3676
('Markovac',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#3677
('Markovac',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3678
('Markovac Križevački',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3679
('Markovac Našički',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#3680
('Marković Selo',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#3681
('Markovići',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#3682
('Markovo Polje',10360,'Sesvete','GRAD ZAGREB',now(),now(),1),
#3683
('Markušbrijeg',49253,'Lobor','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3684
('Markuševec Turopoljski',10412,'Donja Lomnica','ZAGREBAČKA',now(),now(),1),
#3685
('Markušica',32213,'Markušica','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#3686
('Markušići',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#3687
('Marlovac',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#3688
('Marof',40313,'Sveti Martin na Muri','MEĐIMURSKA',now(),now(),1),
#3689
('Maršići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#3690
('Martin',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#3691
('Martina',51418,'Brseč','PRIMORSKO-GORANSKA',now(),now(),1),
#3692
('Martinac',43226,'Veliko Trojstvo','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3693
('Martinac',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3694
('Martinci',52420,'Buzet','ISTARSKA',now(),now(),1),
#3695
('Martinci Miholjački',31530,'Podravska Moslavina','OSJEČKO-BARANJSKA',now(),now(),1),
#3696
('Martinčići',52429,'Grožnjan (Grisignana)','ISTARSKA',now(),now(),1),
#3697
('Martinec Orehovički',49228,'Brestovec Orehovički','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3698
('Martinić',42231,'Mali Bukovec','VARAŽDINSKA',now(),now(),1),
#3699
('Martinišće',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3700
('Martinkovec',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#3701
('Martinovići',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3702
('Martinovići',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3703
('Martinovo Selo',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#3704
('Martinska Ves',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#3705
('Martinski Vrh',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#3706
('Martinšćica',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#3707
('Martinšćica',51556,'Martinšćica','PRIMORSKO-GORANSKA',now(),now(),1),
#3708
('Martinšćina',49250,'Zlatar','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3709
('Martinuševec',40312,'Štrigova','MEĐIMURSKA',now(),now(),1),
#3710
('Martiša Ves',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3711
('Maruševec',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#3712
('Marušići',52462,'Momjan (Momiano)','ISTARSKA',now(),now(),1),
#3713
('Marušići',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#3714
('Marušići',21318,'Mimice','SPLITSKO-DALMATINSKA',now(),now(),1),
#3715
('Maružini',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#3716
('Maslenica',23243,'Jasenice','ZADARSKA',now(),now(),1),
#3717
('Maslenjača',43531,'Veliki Bastaji','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3718
('Maslinica',21430,'Grohote','SPLITSKO-DALMATINSKA',now(),now(),1),
#3719
('Mastelići',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#3720
('Mastrinka',21220,'Trogir','SPLITSKO-DALMATINSKA',now(),now(),1),
#3721
('Mašić',35429,'Gornji Bogićevci','BRODSKO-POSAVSKA',now(),now(),1),
#3722
('Mašvina',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#3723
('Matase',22303,'Oklaj','ŠIBENSKO-KNINSKA',now(),now(),1),
#3724
('Matenci',49240,'Donja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3725
('Materada',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#3726
('Mateše',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#3727
('Mateško Selo',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#3728
('Matići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#3729
('Matijaši',52341,'Žminj','ISTARSKA',now(),now(),1),
#3730
('Matijevići',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3731
('Matković Mala',35201,'Podcrkavlje','BRODSKO-POSAVSKA',now(),now(),1),
#3732
('Matohanci',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#3733
('Matulini',52445,'Baderna','ISTARSKA',now(),now(),1),
#3734
('Matulji',51211,'Matulji','PRIMORSKO-GORANSKA',now(),now(),1),
#3735
('Maturovec',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3736
('Maurovac',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#3737
('Mavrići',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#3738
('Mavrinci',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#3739
('Mazin',23440,'Gračac','ZADARSKA',now(),now(),1),
#3740
('Mece',31326,'Darda','OSJEČKO-BARANJSKA',now(),now(),1),
#3741
('Mečenčani',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3742
('Medak',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#3743
('Medaki',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#3744
('Medančići',52341,'Žminj','ISTARSKA',now(),now(),1),
#3745
('Medari',35429,'Gornji Bogićevci','BRODSKO-POSAVSKA',now(),now(),1),
#3746
('Medinci',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3747
('Medov Dolac',21271,'Grabovac','SPLITSKO-DALMATINSKA',now(),now(),1),
#3748
('Medsave',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#3749
('Medulin',52203,'Medulin','ISTARSKA',now(),now(),1),
#3750
('Medvedička',48327,'Molve','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3751
('Medveja',51415,'Lovran','PRIMORSKO-GORANSKA',now(),now(),1),
#3752
('Medveje',52420,'Buzet','ISTARSKA',now(),now(),1),
#3753
('Medven Draga',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#3754
('Medvidići',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#3755
('Medvidovića Draga',21260,'Imotski','SPLITSKO-DALMATINSKA',now(),now(),1),
#3756
('Medviđa',23420,'Benkovac','ZADARSKA',now(),now(),1),
#3757
('Međa',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3758
('Međare',22214,'Čista Velika','ŠIBENSKO-KNINSKA',now(),now(),1),
#3759
('Međedi',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#3760
('Međeđak',47304,'Plaški','KARLOVAČKA',now(),now(),1),
#3761
('Međeđak Utinjski',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#3762
('Međurača',43272,'Nova Rača','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3763
('Međurače',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3764
('Međurić',44321,'Banova Jaruga','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3765
('Meja Gaj',51226,'Hreljin','PRIMORSKO-GORANSKA',now(),now(),1),
#3766
('Mekiši kod Kaštelira',52464,'Kaštelir (Castelliere)','ISTARSKA',now(),now(),1),
#3767
('Mekiši kod Vižinade',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#3768
('Melinovac',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#3769
('Melnica',52207,'Barban','ISTARSKA',now(),now(),1),
#3770
('Melnice',53273,'Vratnik','LIČKO-SENJSKA',now(),now(),1),
#3771
('Meljan',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#3772
('Merag',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#3773
('Merenje',10295,'Kupljenovo','ZAGREBAČKA',now(),now(),1),
#3774
('Merhatovec',40314,'Selnica','MEĐIMURSKA',now(),now(),1),
#3775
('Merišće',52462,'Momjan (Momiano)','ISTARSKA',now(),now(),1),
#3776
('Merolino Sikirevačko',31410,'Strizivojna','OSJEČKO-BARANJSKA',now(),now(),1),
#3777
('Metajna',53296,'Zubovići','LIČKO-SENJSKA',now(),now(),1),
#3778
('Metković',20350,'Metković','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3779
('Metohija',20230,'Ston','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3780
('Mezinovac',53202,'Perušić','LIČKO-SENJSKA',now(),now(),1),
#3781
('Mičetići',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#3782
('Mičetinac',48350,'Đurđevac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3783
('Mičevec',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#3784
('Mičijevac',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3785
('Migalovci',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3786
('Mihajlije',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3787
('Mihalić Selo',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#3788
('Mihalj',20357,'Blace','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3789
('Mihaljekov Jarek',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3790
('Mihaljevac',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#3791
('Mihaljevci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3792
('Mihaljevići',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3793
('Mihanići',20217,'Pridvorje','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3794
('Mihanovićev Dol',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3795
('Mihatovići',52446,'Nova Vas','ISTARSKA',now(),now(),1),
#3796
('Mihelići',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#3797
('Miholašćica',51556,'Martinšćica','PRIMORSKO-GORANSKA',now(),now(),1),
#3798
('Miholec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3799
('Miholjački Poreč',31543,'Miholjački Poreč','OSJEČKO-BARANJSKA',now(),now(),1),
#3800
('Miholjanec',48326,'Virje','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3801
('Miholjsko',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#3802
('Mihotići',51211,'Matulji','PRIMORSKO-GORANSKA',now(),now(),1),
#3803
('Mihovljan',49252,'Mihovljan','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3804
('Mihovljan',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#3805
('Mijaca',21272,'Slivno','SPLITSKO-DALMATINSKA',now(),now(),1),
#3806
('Mijači',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3807
('Mikašinovići',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#3808
('Miklavec',40315,'Mursko Središče','MEĐIMURSKA',now(),now(),1),
#3809
('Mikleuš',33517,'Mikleuš','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3810
('Mikleuška',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3811
('Mikluševci',32238,'Čakovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#3812
('Mikovec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3813
('Mikulići',20218,'Pločice','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3814
('Mikulijina Luka',20270,'Vela Luka','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3815
('Miladini',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#3816
('Milanezi',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#3817
('Milani',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#3818
('Milanlug',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3819
('Milanovac',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3820
('Milanovac',33000,'Virovitica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3821
('Milanovac',33507,'Crnac','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3822
('Milaševac',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3823
('Milaši',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#3824
('Milčetići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#3825
('Milekovo Selo',49240,'Donja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3826
('Miličani',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3827
('Milinac',31416,'Levanjska Varoš','OSJEČKO-BARANJSKA',now(),now(),1),
#3828
('Milivojevci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3829
('Milna',21450,'Hvar','SPLITSKO-DALMATINSKA',now(),now(),1),
#3830
('Milna',21405,'Milna','SPLITSKO-DALMATINSKA',now(),now(),1),
#3831
('Milna',21480,'Vis','SPLITSKO-DALMATINSKA',now(),now(),1),
#3832
('Milohnići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#3833
('Miloševac',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#3834
('Milotski Brijeg',52341,'Žminj','ISTARSKA',now(),now(),1),
#3835
('Milovčići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#3836
('Miljana',49296,'Zagorska Sela','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3837
('Miljanovac',43541,'Sirač','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3838
('Miljevac',21312,'Podstrana','SPLITSKO-DALMATINSKA',now(),now(),1),
#3839
('Miljevac',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#3840
('Miljevci',33518,'Nova Bukovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3841
('Mimice',21318,'Mimice','SPLITSKO-DALMATINSKA',now(),now(),1),
#3842
('Miočić',22321,'Siverić','ŠIBENSKO-KNINSKA',now(),now(),1),
#3843
('Miočinovići',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3844
('Miranje',23420,'Benkovac','ZADARSKA',now(),now(),1),
#3845
('Mirca',21400,'Supetar','SPLITSKO-DALMATINSKA',now(),now(),1),
#3846
('Mirić Selo',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#3847
('Mirići',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#3848
('Mirkovac',31309,'Kneževi Vinogradi','OSJEČKO-BARANJSKA',now(),now(),1),
#3849
('Mirkovci',32100,'Vinkovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#3850
('Mirkovec',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3851
('Mirkovec Breznički',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#3852
('Mirlović Polje',22322,'Ružić','ŠIBENSKO-KNINSKA',now(),now(),1),
#3853
('Mirlović Zagora',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#3854
('Miroši',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#3855
('Mislina',20353,'Mlinište','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3856
('Mišinci',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#3857
('Mišinka',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3858
('Miškovići',23249,'Povljana','ZADARSKA',now(),now(),1),
#3859
('Mišljenovac',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#3860
('Mitlo',21228,'Blizna Donja','SPLITSKO-DALMATINSKA',now(),now(),1),
#3861
('Mitrovac',31309,'Kneževi Vinogradi','OSJEČKO-BARANJSKA',now(),now(),1),
#3862
('Mitrovac',34340,'Kutjevo','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3863
('Mjesto Primišlje',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#3864
('Mladenići',51216,'Viškovo','PRIMORSKO-GORANSKA',now(),now(),1),
#3865
('Mlaka',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#3866
('Mlaka',44324,'Jasenovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3867
('Mlaka Antinska',32214,'Tordinci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#3868
('Mlakovac',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#3869
('Mlakva',53203,'Kosinj','LIČKO-SENJSKA',now(),now(),1),
#3870
('Mlinari',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#3871
('Mlini',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3872
('Mlinište',20353,'Mlinište','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3873
('Mlinski Vinogradi',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3874
('Močići',20213,'Čilipi','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3875
('Močile',51329,'Severin na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#3876
('Modrič',23244,'Starigrad Paklenica','ZADARSKA',now(),now(),1),
#3877
('Modrino Selo',22305,'Kistanje','ŠIBENSKO-KNINSKA',now(),now(),1),
#3878
('Modrovec',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3879
('Modruš',47303,'Josipdol','KARLOVAČKA',now(),now(),1),
#3880
('Modrušani',52341,'Žminj','ISTARSKA',now(),now(),1),
#3881
('Modruška Munjava',47303,'Josipdol','KARLOVAČKA',now(),now(),1),
#3882
('Mogorić',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#3883
('Mohovo',32233,'Opatovac','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#3884
('Mokošica',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3885
('Mokreš',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3886
('Mokrica Tomaševečka',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#3887
('Mokrice',49243,'Oroslavje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3888
('Mokrice Miholečke',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3889
('Mokro Polje',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#3890
('Molat',23292,'Molat','ZADARSKA',now(),now(),1),
#3891
('Molunat',20218,'Pločice','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3892
('Molve',48327,'Molve','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3893
('Molve Grede',48327,'Molve','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3894
('Molvice',48361,'Kalinovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#3895
('Molvice',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#3896
('Momčilovića Kosa',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3897
('Momići',20341,'Kula Norinska','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3898
('Momjan',52462,'Momjan (Momiano)','ISTARSKA',now(),now(),1),
#3899
('Monterol',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#3900
('Montižana',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#3901
('Moravče',10363,'Belovar','GRAD ZAGREB',now(),now(),1),
#3902
('Moravice',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#3903
('Moravička Sela',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#3904
('Morpolača',23422,'Stankovci','ZADARSKA',now(),now(),1),
#3905
('Moseć',22320,'Drniš','ŠIBENSKO-KNINSKA',now(),now(),1),
#3906
('Moslavačka Slatina',44317,'Popovača','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3907
('Most Raša',52223,'Raša','ISTARSKA',now(),now(),1),
#3908
('Mostari',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#3909
('Mošanci',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#3910
('Mošćenica',44253,'Mošćenica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3911
('Mošćenice',51417,'Mošćenička Draga','PRIMORSKO-GORANSKA',now(),now(),1),
#3912
('Mošćenička Draga',51417,'Mošćenička Draga','PRIMORSKO-GORANSKA',now(),now(),1),
#3913
('Moštanica',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3914
('Motovun',52424,'Motovun (Montana)','ISTARSKA',now(),now(),1),
#3915
('Motovunski Novaki',52423,'Karojba','ISTARSKA',now(),now(),1),
#3916
('Movrač',49294,'Kraljevec na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3917
('Možđenec',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#3918
('Mracelj',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#3919
('Mraclin',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#3920
('Mračaj',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3921
('Mračaj Krstinjski',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#3922
('Mračin',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#3923
('Mratovo',22303,'Oklaj','ŠIBENSKO-KNINSKA',now(),now(),1),
#3924
('Mravince',21209,'Mravince','SPLITSKO-DALMATINSKA',now(),now(),1),
#3925
('Mravinjac',20234,'Orašac','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3926
('Mravnica',20232,'Slano','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3927
('Mravnica',22205,'Perković','ŠIBENSKO-KNINSKA',now(),now(),1),
#3928
('Mrčevo',20234,'Orašac','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3929
('Mrežnica',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#3930
('Mrežničke Poljice',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#3931
('Mrežnički Brest',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#3932
('Mrežnički Brig',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#3933
('Mrežnički Novaki',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#3934
('Mrežnički Varoš',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#3935
('Mrežničko Dvorišće',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#3936
('Mrgani',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#3937
('Mrkopalj',51315,'Mrkopalj','PRIMORSKO-GORANSKA',now(),now(),1),
#3938
('Mrkoplje',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#3939
('Mrljane',23264,'Neviđane','ZADARSKA',now(),now(),1),
#3940
('Mrzla Vodica',51316,'Lokve','PRIMORSKO-GORANSKA',now(),now(),1),
#3941
('Mrzli Dol',53271,'Krivi Put','LIČKO-SENJSKA',now(),now(),1),
#3942
('Mrzlo Polje',49214,'Veliko Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3943
('Mrzlo Polje Žumberačko',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#3944
('Mrzljaki',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#3945
('Mrzljaki',47201,'Draganići','KARLOVAČKA',now(),now(),1),
#3946
('Mrzović',32284,'Stari Mikanovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#3947
('Mučići',51213,'Jurdani','PRIMORSKO-GORANSKA',now(),now(),1),
#3948
('Mugeba',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#3949
('Muline',23275,'Ugljan','ZADARSKA',now(),now(),1),
#3950
('Mundanije',51280,'Rab','PRIMORSKO-GORANSKA',now(),now(),1),
#3951
('Munije',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3952
('Muntić',52100,'Pula (Pola)','ISTARSKA',now(),now(),1),
#3953
('Muntrilj',52444,'Tinjan','ISTARSKA',now(),now(),1),
#3954
('Munjari',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#3955
('Munjava',47303,'Josipdol','KARLOVAČKA',now(),now(),1),
#3956
('Muraj',51517,'Kornić','PRIMORSKO-GORANSKA',now(),now(),1),
#3957
('Muričevec',42250,'Lepoglava','VARAŽDINSKA',now(),now(),1),
#3958
('Murine',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#3959
('Mursko Središće',40315,'Mursko Središče','MEĐIMURSKA',now(),now(),1),
#3960
('Murter',22243,'Murter','ŠIBENSKO-KNINSKA',now(),now(),1),
#3961
('Murvica',21420,'Bol','SPLITSKO-DALMATINSKA',now(),now(),1),
#3962
('Murvica',23000,'Zadar','ZADARSKA',now(),now(),1),
#3963
('Musić',31416,'Levanjska Varoš','OSJEČKO-BARANJSKA',now(),now(),1),
#3964
('Mustafina Klada',44316,'Velika Ludina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3965
('Musulini',51327,'Gomirje','PRIMORSKO-GORANSKA',now(),now(),1),
#3966
('Mušalež',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#3967
('Mušaluk',53201,'Lički Osik','LIČKO-SENJSKA',now(),now(),1),
#3968
('Muškovci',23450,'Obrovac','ZADARSKA',now(),now(),1),
#3969
('Mutilić',53234,'Udbina','LIČKO-SENJSKA',now(),now(),1),
#3970
('Mutogras',21312,'Podstrana','SPLITSKO-DALMATINSKA',now(),now(),1),
#3971
('Mutvoran',52208,'Krnica','ISTARSKA',now(),now(),1),
#3972
('Mužilovčica',44203,'Gušće','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3973
('Mužini',52341,'Žminj','ISTARSKA',now(),now(),1),
#3974
('Nadin',23420,'Benkovac','ZADARSKA',now(),now(),1),
#3975
('Nadin kosa',23420,'Benkovac','ZADARSKA',now(),now(),1),
#3976
('Nadvoda',23450,'Obrovac','ZADARSKA',now(),now(),1),
#3977
('Nadvrelo',23440,'Gračac','ZADARSKA',now(),now(),1),
#3978
('Nadvučnik',51328,'Lukovdol','PRIMORSKO-GORANSKA',now(),now(),1),
#3979
('Naglići',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#3980
('Najevi',21222,'Marina','SPLITSKO-DALMATINSKA',now(),now(),1),
#3981
('Naklice',21252,'Tugare','SPLITSKO-DALMATINSKA',now(),now(),1),
#3982
('Nakovanj',20267,'Kućište','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#3983
('Nard',31550,'Valpovo','OSJEČKO-BARANJSKA',now(),now(),1),
#3984
('Narduči',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#3985
('Nart Savski',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#3986
('Narta',43247,'Narta','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#3987
('Naselje A.Hebrang',35106,'Slavonski Brod','BRODSKO-POSAVSKA',now(),now(),1),
#3988
('Naselje Stjepana Radića',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#3989
('Našice',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#3990
('Našičko Novo Selo',31511,'Đurđenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#3991
('Natkrižovljan',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#3992
('Naudovac',33410,'Suhopolje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#3993
('Nebljusi',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#3994
('Nebojan',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#3995
('Nebojse',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#3996
('Nečujam',21432,'Stomorska','SPLITSKO-DALMATINSKA',now(),now(),1),
#3997
('Nedelišće',40305,'Nedelišće','MEĐIMURSKA',now(),now(),1),
#3998
('Nedeljanec',42205,'Vidovec','VARAŽDINSKA',now(),now(),1),
#3999
('Nedešćina',52231,'Nedešćina','ISTARSKA',now(),now(),1),
#4000
('Negnar',52420,'Buzet','ISTARSKA',now(),now(),1),
#4001
('Negoslavci',32239,'Negoslavci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4002
('Negovec',10341,'Lonjica','ZAGREBAČKA',now(),now(),1),
#4003
('Nemčevac',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4004
('Nemetin',31000,'Osijek','OSJEČKO-BARANJSKA',now(),now(),1),
#4005
('Nenadići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#4006
('Neorić',21247,'Neorić','SPLITSKO-DALMATINSKA',now(),now(),1),
#4007
('Nerezine',51554,'Nerezine','PRIMORSKO-GORANSKA',now(),now(),1),
#4008
('Nerežišća',21423,'Nerežišća','SPLITSKO-DALMATINSKA',now(),now(),1),
#4009
('Nespeš',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#4010
('Neteka',23445,'Srb','ZADARSKA',now(),now(),1),
#4011
('Netretić',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#4012
('Nevest',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#4013
('Neviđane',23264,'Neviđane','ZADARSKA',now(),now(),1),
#4014
('Nevinac',43272,'Nova Rača','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4015
('Nijemci',32245,'Nijemci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4016
('Nikolići',47313,'Drežnica','KARLOVAČKA',now(),now(),1),
#4017
('Nikšići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#4018
('Nin',23232,'Nin','ZADARSKA',now(),now(),1),
#4019
('Ninski Stanovi',23232,'Nin','ZADARSKA',now(),now(),1),
#4020
('Nisko',21202,'Lećevica','SPLITSKO-DALMATINSKA',now(),now(),1),
#4021
('Niza',31224,'Koška','OSJEČKO-BARANJSKA',now(),now(),1),
#4022
('Normanci',31224,'Koška','OSJEČKO-BARANJSKA',now(),now(),1),
#4023
('Noršić Selo',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#4024
('Nos Kalik',22324,'Drinovci','ŠIBENSKO-KNINSKA',now(),now(),1),
#4025
('Noskovačka Dubrava',33523,'Čađavica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4026
('Noskovci',33523,'Čađavica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4027
('Nova Bukovica',33518,'Nova Bukovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4028
('Nova Diklenica',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4029
('Nova Drenčina',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4030
('Nova Gradiška',35400,'Nova Gradiška','BRODSKO-POSAVSKA',now(),now(),1),
#4031
('Nova Jošava',33515,'Orahovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4032
('Nova Kapela',35410,'Nova Kapela','BRODSKO-POSAVSKA',now(),now(),1),
#4033
('Nova Kapela',10343,'Nova Kapela','ZAGREBAČKA',now(),now(),1),
#4034
('Nova Krivaja',43532,'Đulovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4035
('Nova Kršlja',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#4036
('Nova Lipa',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4037
('Nova Lipovica',34343,'Bektež','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4038
('Nova Ljeskovica',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4039
('Nova Mokošica',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4040
('Nova Pisanica',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4041
('Nova Ploščica',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4042
('Nova Rača',43272,'Nova Rača','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4043
('Nova Sela',20278,'Nova Sela','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4044
('Nova Sela',21243,'Ugljane','SPLITSKO-DALMATINSKA',now(),now(),1),
#4045
('Nova Sela',21254,'Blato na Cetini','SPLITSKO-DALMATINSKA',now(),now(),1),
#4046
('Nova Subocka',44330,'Novska','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4047
('Nova Šarovka',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4048
('Nova Vas',52234,'Plomin','ISTARSKA',now(),now(),1),
#4049
('Nova Vas',52446,'Nova Vas','ISTARSKA',now(),now(),1),
#4050
('Nova Vas',52474,'Brtonigla (Verteneglio)','ISTARSKA',now(),now(),1),
#4051
('Nova Ves Petrijanečka',42206,'Petrijanec','VARAŽDINSKA',now(),now(),1),
#4052
('Novačka',48332,'Ždala','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4053
('Novačka',48331,'Gola','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4054
('Novaki',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#4055
('Novaki',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#4056
('Novaki',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4057
('Novaki Bistranski',10298,'Donja Bistra','ZAGREBAČKA',now(),now(),1),
#4058
('Novaki Bizovački',31223,'Brođanci','OSJEČKO-BARANJSKA',now(),now(),1),
#4059
('Novaki Lipnički',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#4060
('Novaki Nartski',10361,'Sesvete-Kraljevec','GRAD ZAGREB',now(),now(),1),
#4061
('Novaki Oborovski',10372,'Oborovo','ZAGREBAČKA',now(),now(),1),
#4062
('Novaki Ozaljski',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#4063
('Novaki Pazinski',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#4064
('Novaki Petrovinski',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#4065
('Novaki Ravenski',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4066
('Novaki Samoborski',10431,'Sveta Nedjelja','ZAGREBAČKA',now(),now(),1),
#4067
('Novaki Šćitarjevski',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#4068
('Novakovec',42203,'Jalžabet','VARAŽDINSKA',now(),now(),1),
#4069
('Novakovec',40318,'Dekanovec','MEĐIMURSKA',now(),now(),1),
#4070
('Novakovec Bisaški',10381,'Bedenica','ZAGREBAČKA',now(),now(),1),
#4071
('Novalja',53291,'Novalja','LIČKO-SENJSKA',now(),now(),1),
#4072
('Nove Hiže',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#4073
('Novi Antunovac',33404,'Špišić Bukovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4074
('Novi Bešinci',34334,'Kaptol','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4075
('Novi Bezdan',31322,'Baranjsko Petrovo Selo','OSJEČKO-BARANJSKA',now(),now(),1),
#4076
('Novi Bolman',31323,'Bolman','OSJEČKO-BARANJSKA',now(),now(),1),
#4077
('Novi Bošnjani',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4078
('Novi Čakovci',32238,'Čakovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4079
('Novi Čeminac',31325,'Čeminac','OSJEČKO-BARANJSKA',now(),now(),1),
#4080
('Novi Dol',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#4081
('Novi Dvori Klanječki',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4082
('Novi Đurđic',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4083
('Novi Farkašić',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4084
('Novi Glog',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4085
('Novi Golubovec',49255,'Novi Golubovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4086
('Novi Grabovac',44322,'Lipovljani','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4087
('Novi Grad',35216,'Prnjavor','BRODSKO-POSAVSKA',now(),now(),1),
#4088
('Novi Gradac',33411,'Gradina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4089
('Novi Jankovci',32241,'Stari Jankovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4090
('Novi Lazi',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#4091
('Novi Majur',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4092
('Novi Marof',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#4093
('Novi Mihaljevci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4094
('Novi Mikanovci',32283,'Vođinci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4095
('Novi Pavljani',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4096
('Novi Perkovci',31417,'Piškorevci','OSJEČKO-BARANJSKA',now(),now(),1),
#4097
('Novi Senkovac',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4098
('Novi Skucani',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4099
('Novi Štitnjak',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4100
('Novi Varoš',35435,'Stara Gradiška','BRODSKO-POSAVSKA',now(),now(),1),
#4101
('Novi Vinodolski',51250,'Novi Vinodolski','PRIMORSKO-GORANSKA',now(),now(),1),
#4102
('Novi Zdenkovac',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4103
('Novigrad',23312,'Novigrad (Dalmacija)','ZADARSKA',now(),now(),1),
#4104
('Novigrad',52466,'Novigrad (Cittanova)','ISTARSKA',now(),now(),1),
#4105
('Novigrad na Dobri',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#4106
('Novigrad Podravski',48325,'Novigrad Podravski','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4107
('Novo Brdo',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#4108
('Novo Brdo Mrežničko',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#4109
('Novo Čiče',10415,'Novo Čiče','ZAGREBAČKA',now(),now(),1),
#4110
('Novo Kusonje',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4111
('Novo Mjesto',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#4112
('Novo Nevesinje',31322,'Baranjsko Petrovo Selo','OSJEČKO-BARANJSKA',now(),now(),1),
#4113
('Novo Petrovo Polje',33507,'Crnac','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4114
('Novo Pračno',44010,'Sisak-Caprag','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4115
('Novo Selište',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4116
('Novo Selo',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4117
('Novo Selo',44010,'Sisak-Caprag','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4118
('Novo Selo',10417,'Buševec','ZAGREBAČKA',now(),now(),1),
#4119
('Novo Selo',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#4120
('Novo Selo',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#4121
('Novo Selo',21425,'Selca','SPLITSKO-DALMATINSKA',now(),now(),1),
#4122
('Novo Selo',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4123
('Novo Selo Bosiljevsko',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#4124
('Novo Selo Garešničko',43233,'Trnovitički Popovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4125
('Novo Selo Glinsko',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4126
('Novo Selo Koreničko',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#4127
('Novo Selo Lasinjsko',47206,'Lasinja','KARLOVAČKA',now(),now(),1),
#4128
('Novo Selo na Dravi',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#4129
('Novo Selo Okićko',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#4130
('Novo Selo Palanječko',44202,'Topolovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4131
('Novo Selo Perjasičko',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#4132
('Novo Selo Podravsko',42231,'Mali Bukovec','VARAŽDINSKA',now(),now(),1),
#4133
('Novo Selo Rok',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#4134
('Novo Selo Žumberačko',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#4135
('Novo Svibje',10361,'Sesvete-Kraljevec','GRAD ZAGREB',now(),now(),1),
#4136
('Novo Topolje',35214,'Donji Andrijevci','BRODSKO-POSAVSKA',now(),now(),1),
#4137
('Novo Virje',48355,'Novo Virje','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4138
('Novo Zvečevo',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4139
('Novoselci',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4140
('Novoselci',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4141
('Novoselec',10315,'Novoselec','ZAGREBAČKA',now(),now(),1),
#4142
('Novoselija',53213,'Donje Pazarište','LIČKO-SENJSKA',now(),now(),1),
#4143
('Novoselo Bilajsko',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#4144
('Novoselo Trnovačko',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#4145
('Novoseljani',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4146
('Novska',44330,'Novska','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4147
('Nunić',22305,'Kistanje','ŠIBENSKO-KNINSKA',now(),now(),1),
#4148
('Nurkovac',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4149
('Nuštar',32221,'Nuštar','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4150
('Nježići',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4151
('Njivice',51512,'Njivice','PRIMORSKO-GORANSKA',now(),now(),1),
#4152
('Njivice',20226,'Goveđari','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4153
('Obed',10411,'Orle','ZAGREBAČKA',now(),now(),1),
#4154
('Obedišće',10315,'Novoselec','ZAGREBAČKA',now(),now(),1),
#4155
('Obedišće Ježevsko',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#4156
('Oblakovac',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4157
('Oborovo',10372,'Oborovo','ZAGREBAČKA',now(),now(),1),
#4158
('Oborovo Bistransko',10298,'Donja Bistra','ZAGREBAČKA',now(),now(),1),
#4159
('Obradovci',33513,'Zdenci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4160
('Obrankovec',42233,'Sveti Đurđ','VARAŽDINSKA',now(),now(),1),
#4161
('Obrezina',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#4162
('Obrež Kalnički',48269,'Kalnik','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4163
('Obrež Stupnički',10255,'Gornji Stupnik','ZAGREBAČKA',now(),now(),1),
#4164
('Obrež Vivodinski',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#4165
('Obrež Zelinski',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#4166
('Obrh',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#4167
('Obrovac',23450,'Obrovac','ZADARSKA',now(),now(),1),
#4168
('Obrovac Sinjski',21241,'Obrovac Sinjski','SPLITSKO-DALMATINSKA',now(),now(),1),
#4169
('Obrovnica',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4170
('Obrš',51417,'Mošćenička Draga','PRIMORSKO-GORANSKA',now(),now(),1),
#4171
('Očura',42250,'Lepoglava','VARAŽDINSKA',now(),now(),1),
#4172
('Očura',49255,'Novi Golubovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4173
('Oćestovo',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#4174
('Odra',10020,'Zagreb-Novi Zagreb','GRAD ZAGREB',now(),now(),1),
#4175
('Odra Sisačka',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4176
('Odranski Obrež',10020,'Zagreb-Novi Zagreb','GRAD ZAGREB',now(),now(),1),
#4177
('Oglavci',22203,'Rogoznica','ŠIBENSKO-KNINSKA',now(),now(),1),
#4178
('Ogulin',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#4179
('Ogulinac',10417,'Buševec','ZAGREBAČKA',now(),now(),1),
#4180
('Ohnići',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#4181
('Okešinec',10315,'Novoselec','ZAGREBAČKA',now(),now(),1),
#4182
('Okić',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#4183
('Oklaj',22303,'Oklaj','ŠIBENSKO-KNINSKA',now(),now(),1),
#4184
('Oklinak',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#4185
('Oključna',21485,'Komiža','SPLITSKO-DALMATINSKA',now(),now(),1),
#4186
('Okoli',44316,'Velika Ludina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4187
('Okreti',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#4188
('Okrivje',51303,'Plešce','PRIMORSKO-GORANSKA',now(),now(),1),
#4189
('Okrug',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#4190
('Okrug Donji',21223,'Okrug Gornji','SPLITSKO-DALMATINSKA',now(),now(),1),
#4191
('Okrug Gornji',21223,'Okrug Gornji','SPLITSKO-DALMATINSKA',now(),now(),1),
#4192
('Okrugli Vrh',40311,'Lopatinec','MEĐIMURSKA',now(),now(),1),
#4193
('Okruglica',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#4194
('Okrugljača',33404,'Špišić Bukovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4195
('Okučani',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#4196
('Okuje',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#4197
('Okuklje',20224,'Maranovići','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4198
('Okunšćak',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#4199
('Olib',23296,'Olib','ZADARSKA',now(),now(),1),
#4200
('Oljasi',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4201
('Omamno',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#4202
('Omamno',10381,'Bedenica','ZAGREBAČKA',now(),now(),1),
#4203
('Omanovac',34552,'Badljevina','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4204
('Omiš',21310,'Omiš','SPLITSKO-DALMATINSKA',now(),now(),1),
#4205
('Omišalj',51513,'Omišalj','PRIMORSKO-GORANSKA',now(),now(),1),
#4206
('Omsica',23440,'Gračac','ZADARSKA',now(),now(),1),
#4207
('Ondić',53234,'Udbina','LIČKO-SENJSKA',now(),now(),1),
#4208
('Opanci',21257,'Lovreć','SPLITSKO-DALMATINSKA',now(),now(),1),
#4209
('Opasanjek',49247,'Zlatar Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4210
('Opatija',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#4211
('Opatija',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#4212
('Opatija',51410,'Opatija','PRIMORSKO-GORANSKA',now(),now(),1),
#4213
('Opatinec',10310,'Ivanić-Grad','ZAGREBAČKA',now(),now(),1),
#4214
('Opatovac',32233,'Opatovac','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4215
('Opatovac',35404,'Cernik','BRODSKO-POSAVSKA',now(),now(),1),
#4216
('Općevac',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4217
('Oplaznik',10299,'Marija Gorica','ZAGREBAČKA',now(),now(),1),
#4218
('Oporovec',40325,'Draškovec','MEĐIMURSKA',now(),now(),1),
#4219
('Oprič',51415,'Lovran','PRIMORSKO-GORANSKA',now(),now(),1),
#4220
('Oprisavci',35213,'Oprisavci','BRODSKO-POSAVSKA',now(),now(),1),
#4221
('Opršinac',35404,'Cernik','BRODSKO-POSAVSKA',now(),now(),1),
#4222
('Oprtalj',52428,'Oprtalj (Portole)','ISTARSKA',now(),now(),1),
#4223
('Opuzen',20355,'Opuzen','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4224
('Orah',21276,'Vrgorac','SPLITSKO-DALMATINSKA',now(),now(),1),
#4225
('Orahovica',33515,'Orahovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4226
('Oraovac',53250,'Donji Lapac','LIČKO-SENJSKA',now(),now(),1),
#4227
('Orašac',20234,'Orašac','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4228
('Oratje',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4229
('Oravac',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#4230
('Orbani',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#4231
('Orbanići',52341,'Žminj','ISTARSKA',now(),now(),1),
#4232
('Orbanići',52206,'Marčana','ISTARSKA',now(),now(),1),
#4233
('Ordanja',31224,'Koška','OSJEČKO-BARANJSKA',now(),now(),1),
#4234
('Orebić',20250,'Orebić','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4235
('Orehova Gorica',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4236
('Orehovec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4237
('Orehovec',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#4238
('Orehovec Radobojski',49232,'Radoboj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4239
('Orehovica',49228,'Brestovec Orehovički','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4240
('Orehovica',40322,'Orehovica','MEĐIMURSKA',now(),now(),1),
#4241
('Orešac',33410,'Suhopolje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4242
('Orešje',10434,'Strmec Samoborski','ZAGREBAČKA',now(),now(),1),
#4243
('Orešje Humsko',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4244
('Orešje Okićko',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#4245
('Orešnjak',31530,'Podravska Moslavina','OSJEČKO-BARANJSKA',now(),now(),1),
#4246
('Orić',52332,'Pićan','ISTARSKA',now(),now(),1),
#4247
('Orihi',52207,'Barban','ISTARSKA',now(),now(),1),
#4248
('Orijevac',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#4249
('Oriovac',35250,'Oriovac','BRODSKO-POSAVSKA',now(),now(),1),
#4250
('Oriovčić',35201,'Podcrkavlje','BRODSKO-POSAVSKA',now(),now(),1),
#4251
('Orišje',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#4252
('Orle',10411,'Orle','ZAGREBAČKA',now(),now(),1),
#4253
('Orlec',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#4254
('Orlić',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#4255
('Orlovac',43272,'Nova Rača','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4256
('Orlovac Zdenački',43293,'Veliki Zdenci','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4257
('Orljakovo',47282,'Kamanje','KARLOVAČKA',now(),now(),1),
#4258
('Orljavac',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4259
('Ornice',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#4260
('Orolik',32243,'Orolik','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4261
('Oroslavje',49243,'Oroslavje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4262
('Orovac',43274,'Severin','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4263
('Orubica',35424,'Orubica','BRODSKO-POSAVSKA',now(),now(),1),
#4264
('Osečka',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#4265
('Osekovo',44317,'Popovača','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4266
('Osijek',31000,'Osijek','OSJEČKO-BARANJSKA',now(),now(),1),
#4267
('Osijek Vojakovački',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4268
('Oskoruš',52462,'Momjan (Momiano)','ISTARSKA',now(),now(),1),
#4269
('Oskorušno',20242,'Oskorušno','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4270
('Oslići',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#4271
('Osobljava',20246,'Janjina','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4272
('Osoje',21232,'Dicmo','SPLITSKO-DALMATINSKA',now(),now(),1),
#4273
('Osojnik',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4274
('Osojnik',51329,'Severin na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#4275
('Osonjak',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#4276
('Osor',51554,'Nerezine','PRIMORSKO-GORANSKA',now(),now(),1),
#4277
('Osredci',23445,'Srb','ZADARSKA',now(),now(),1),
#4278
('Osredek Desinićki',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4279
('Osredek Žumberački',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#4280
('Ostojići',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4281
('Ostrogašica',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#4282
('Ostrošinci',31433,'Podgorač','OSJEČKO-BARANJSKA',now(),now(),1),
#4283
('Ostrovica',21253,'Gata','SPLITSKO-DALMATINSKA',now(),now(),1),
#4284
('Ostrovica',23420,'Benkovac','ZADARSKA',now(),now(),1),
#4285
('Ostrovo',32211,'Ostrovo','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4286
('Ostrožin',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4287
('Ostrvica',53201,'Lički Osik','LIČKO-SENJSKA',now(),now(),1),
#4288
('Osunja',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#4289
('Ošljak',23273,'Preko','ZADARSKA',now(),now(),1),
#4290
('Ošlje',20205,'Topolo','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4291
('Oštarije',47302,'Oštarije','KARLOVAČKA',now(),now(),1),
#4292
('Oštarski Stanovi',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#4293
('Oštri Vrh',35420,'Staro Petrovo Selo','BRODSKO-POSAVSKA',now(),now(),1),
#4294
('Oštri Zid',43233,'Trnovitički Popovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4295
('Oštrice',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#4296
('Oštrobradić',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#4297
('Otavice',22322,'Ružić','ŠIBENSKO-KNINSKA',now(),now(),1),
#4298
('Oteš',53212,'Klanac','LIČKO-SENJSKA',now(),now(),1),
#4299
('Otišić',21236,'Vrlika','SPLITSKO-DALMATINSKA',now(),now(),1),
#4300
('Otkopi',43505,'Končanica (Končenice)','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4301
('Otočac',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#4302
('Otočka',48331,'Gola','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4303
('Otok',21238,'Otok (Dalmacija)','SPLITSKO-DALMATINSKA',now(),now(),1),
#4304
('Otok',32252,'Otok','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4305
('Otok',40323,'Prelog','MEĐIMURSKA',now(),now(),1),
#4306
('Otok Duba',20357,'Blace','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4307
('Otok na Dobri',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#4308
('Otok Nartski',10361,'Sesvete-Kraljevec','GRAD ZAGREB',now(),now(),1),
#4309
('Otok Oštarijski',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#4310
('Otok Svibovski',10361,'Sesvete-Kraljevec','GRAD ZAGREB',now(),now(),1),
#4311
('Otok Virje',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#4312
('Oton',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#4313
('Oton',23210,'Biograd na moru','ZADARSKA',now(),now(),1),
#4314
('Otrčkovec',10381,'Bedenica','ZAGREBAČKA',now(),now(),1),
#4315
('Otrić',23440,'Gračac','ZADARSKA',now(),now(),1),
#4316
('Otrić Seoci',20342,'Otrić Seoci','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4317
('Otrovanec',33405,'Pitomača','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4318
('Otruševec',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#4319
('Ovčara',31431,'Čepin','OSJEČKO-BARANJSKA',now(),now(),1),
#4320
('Ovčara',31416,'Levanjska Varoš','OSJEČKO-BARANJSKA',now(),now(),1),
#4321
('Ovčare',34335,'Vetovo','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4322
('Ovrlja',21238,'Otok (Dalmacija)','SPLITSKO-DALMATINSKA',now(),now(),1),
#4323
('Ozalj',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#4324
('Ozdakovci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4325
('Ožegovci',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4326
('Pačetin',32222,'Bršadin','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4327
('Pađane',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#4328
('Pag',23250,'Pag','ZADARSKA',now(),now(),1),
#4329
('Pagubice',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#4330
('Pajari',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#4331
('Pajkovići',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#4332
('Paka',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#4333
('Paka',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4334
('Paklenica',44330,'Novska','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4335
('Pakoštane',23211,'Pakoštane','ZADARSKA',now(),now(),1),
#4336
('Pakovo Selo',22320,'Drniš','ŠIBENSKO-KNINSKA',now(),now(),1),
#4337
('Pakrac',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4338
('Pakrani',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4339
('Palača',31214,'Laslovo (Szentl&#225;szl&#243;)','OSJEČKO-BARANJSKA',now(),now(),1),
#4340
('Paladini',52420,'Buzet','ISTARSKA',now(),now(),1),
#4341
('Palagruža',21485,'Komiža','SPLITSKO-DALMATINSKA',now(),now(),1),
#4342
('Palančani',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4343
('Palanka',23440,'Gračac','ZADARSKA',now(),now(),1),
#4344
('Palanjek',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4345
('Palanjek Pokupski',44273,'Sela','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4346
('Palešnik',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4347
('Palinovec',40320,'Donji Kraljevec','MEĐIMURSKA',now(),now(),1),
#4348
('Palit',51280,'Rab','PRIMORSKO-GORANSKA',now(),now(),1),
#4349
('Palovec',40321,'Mala Subotica','MEĐIMURSKA',now(),now(),1),
#4350
('Palje Brdo',20218,'Pločice','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4351
('Paljevina',31423,'Bračevci','OSJEČKO-BARANJSKA',now(),now(),1),
#4352
('Paljevine',43247,'Narta','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4353
('Paljugi',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#4354
('Paljuv',23312,'Novigrad (Dalmacija)','ZADARSKA',now(),now(),1),
#4355
('Pamići',52341,'Žminj','ISTARSKA',now(),now(),1),
#4356
('Panjani',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4357
('Papići',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4358
('Papinec',42205,'Vidovec','VARAŽDINSKA',now(),now(),1),
#4359
('Paradiž',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#4360
('Parčić',22321,'Siverić','ŠIBENSKO-KNINSKA',now(),now(),1),
#4361
('Parčić',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#4362
('Parčići',23420,'Benkovac','ZADARSKA',now(),now(),1),
#4363
('Parg',51306,'Čabar','PRIMORSKO-GORANSKA',now(),now(),1),
#4364
('Paruževac',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#4365
('Paruževina',10362,'Kašina','GRAD ZAGREB',now(),now(),1),
#4366
('Pasadur',20290,'Lastovo','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4367
('Pasanska Gorica',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4368
('Pasikovci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4369
('Pasjak',51214,'Šapjane','PRIMORSKO-GORANSKA',now(),now(),1),
#4370
('Pašin Potok',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#4371
('Pašman',23262,'Pašman','ZADARSKA',now(),now(),1),
#4372
('Pašnik',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#4373
('Patkovac',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4374
('Pauci',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#4375
('Paučje',31416,'Levanjska Varoš','OSJEČKO-BARANJSKA',now(),now(),1),
#4376
('Paukovac',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4377
('Paukovec',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#4378
('Paulin Dvor',31215,'Ernestinovo','OSJEČKO-BARANJSKA',now(),now(),1),
#4379
('Paulin Kloštar',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4380
('Paulovac',43226,'Veliko Trojstvo','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4381
('Paunovac',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4382
('Paušinci',33514,'Čačinci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4383
('Paveki',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#4384
('Pavičići',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#4385
('Pavićini',52208,'Krnica','ISTARSKA',now(),now(),1),
#4386
('Pavković Selo',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#4387
('Pavkovići',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#4388
('Pavlanci',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#4389
('Pavličani',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4390
('Pavlovac',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4391
('Pavlovac',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#4392
('Pavlovac Vrebački',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#4393
('Pavlovci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4394
('Pavlovci',35410,'Nova Kapela','BRODSKO-POSAVSKA',now(),now(),1),
#4395
('Pavlovčani',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#4396
('Pavlovec Pregradski',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4397
('Pavlovec Ravenski',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4398
('Pavlovec Zabočki',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4399
('Pavučnjak',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#4400
('Paz',52434,'Boljun','ISTARSKA',now(),now(),1),
#4401
('Pazdelj',22203,'Rogoznica','ŠIBENSKO-KNINSKA',now(),now(),1),
#4402
('Pazin',52000,'Pazin','ISTARSKA',now(),now(),1),
#4403
('Pažurovec',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4404
('Pčelić',33410,'Suhopolje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4405
('Pece',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4406
('Pece',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#4407
('Pecka',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4408
('Pecki',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4409
('Pećane',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#4410
('Pećarići',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#4411
('Pećca',51243,'Tribalj','PRIMORSKO-GORANSKA',now(),now(),1),
#4412
('Pećišće',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#4413
('Pećno',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#4414
('Pećurkovo Brdo',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#4415
('Pedalj',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4416
('Pedinka',23234,'Vir','ZADARSKA',now(),now(),1),
#4417
('Pehardovac',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#4418
('Pejkovići',21255,'Zadvarje','SPLITSKO-DALMATINSKA',now(),now(),1),
#4419
('Peklenica',40315,'Mursko Središče','MEĐIMURSKA',now(),now(),1),
#4420
('Pengari',52420,'Buzet','ISTARSKA',now(),now(),1),
#4421
('Peničići',52420,'Buzet','ISTARSKA',now(),now(),1),
#4422
('Pepelana',33410,'Suhopolje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4423
('Peračko Blato',20340,'Ploče','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4424
('Peravec',10316,'Lijevi Dubrovčak','ZAGREBAČKA',now(),now(),1),
#4425
('Perci',52420,'Buzet','ISTARSKA',now(),now(),1),
#4426
('Perci',52465,'Tar (Torre)','ISTARSKA',now(),now(),1),
#4427
('Perenci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4428
('Peresiji',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#4429
('Perići',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#4430
('Perići',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#4431
('Perini',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#4432
('Perjasica',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#4433
('Perković',22205,'Perković','ŠIBENSKO-KNINSKA',now(),now(),1),
#4434
('Permani',51213,'Jurdani','PRIMORSKO-GORANSKA',now(),now(),1),
#4435
('Perna',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4436
('Pernat',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#4437
('Peroj',52215,'Vodnjan (Dignano)','ISTARSKA',now(),now(),1),
#4438
('Perovići',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#4439
('Peršaves',49251,'Mače','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4440
('Perušić',53202,'Perušić','LIČKO-SENJSKA',now(),now(),1),
#4441
('Perušić Benkovački',23420,'Benkovac','ZADARSKA',now(),now(),1),
#4442
('Peruški',52208,'Krnica','ISTARSKA',now(),now(),1),
#4443
('Pesak',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#4444
('Pesek',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4445
('Peskovec',10341,'Lonjica','ZAGREBAČKA',now(),now(),1),
#4446
('Pešćenica',44272,'Lekenik','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4447
('Pešćenica Vinička',42207,'Vinica','VARAŽDINSKA',now(),now(),1),
#4448
('Pešćenik',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4449
('Pešćeno',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4450
('Petehi',52207,'Barban','ISTARSKA',now(),now(),1),
#4451
('Peteranec',48321,'Peteranec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4452
('Petina',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#4453
('Petkov Breg',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#4454
('Petkovac',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4455
('Petkovec Toplički',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#4456
('Petlovac',31321,'Petlovac','OSJEČKO-BARANJSKA',now(),now(),1),
#4457
('Petrača',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4458
('Petrakovo Brdo',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#4459
('Petrčane',23231,'Petrčane','ZADARSKA',now(),now(),1),
#4460
('Petričko Selo',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#4461
('Petrijanec',42206,'Petrijanec','VARAŽDINSKA',now(),now(),1),
#4462
('Petrijevci',31208,'Petrijevci','OSJEČKO-BARANJSKA',now(),now(),1),
#4463
('Petrinovići',51242,'Drivenik','PRIMORSKO-GORANSKA',now(),now(),1),
#4464
('Petrinja',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4465
('Petrinjci',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4466
('Petrova Gora',49253,'Lobor','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4467
('Petrova Poljana',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#4468
('Petrova Slatina',31215,'Ernestinovo','OSJEČKO-BARANJSKA',now(),now(),1),
#4469
('Petrovac',44272,'Lekenik','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4470
('Petrovci',32229,'Petrovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4471
('Petrovec',10418,'Dubranec','ZAGREBAČKA',now(),now(),1),
#4472
('Petrovići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#4473
('Petrovija',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#4474
('Petrovina',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#4475
('Petrovina Turopoljska',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#4476
('Petrovo Selo',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4477
('Petrovsko',49234,'Petrovsko','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4478
('Petrunići',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#4479
('Petruš Vrh',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#4480
('Petruševec',49254,'Belec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4481
('Pićan',52332,'Pićan','ISTARSKA',now(),now(),1),
#4482
('Pifari',52341,'Žminj','ISTARSKA',now(),now(),1),
#4483
('Pihovec',42203,'Jalžabet','VARAŽDINSKA',now(),now(),1),
#4484
('Pijavičino',20243,'Kuna','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4485
('Pila',49244,'Stubičke Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4486
('Pilatovci',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#4487
('Piljenice',44322,'Lipovljani','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4488
('Pinezići',51500,'Krk','PRIMORSKO-GORANSKA',now(),now(),1),
#4489
('Pinežići',52206,'Marčana','ISTARSKA',now(),now(),1),
#4490
('Pirakovec',10341,'Lonjica','ZAGREBAČKA',now(),now(),1),
#4491
('Piramatovci',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#4492
('Pirelići',52427,'Livade (Levade)','ISTARSKA',now(),now(),1),
#4493
('Pirovac',22213,'Pirovac','ŠIBENSKO-KNINSKA',now(),now(),1),
#4494
('Pirovište',51323,'Lič','PRIMORSKO-GORANSKA',now(),now(),1),
#4495
('Pisak',21318,'Mimice','SPLITSKO-DALMATINSKA',now(),now(),1),
#4496
('Pisarovina',10451,'Pisarovina','ZAGREBAČKA',now(),now(),1),
#4497
('Piščetke',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#4498
('Pišćanovec',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#4499
('Pišćet',22203,'Rogoznica','ŠIBENSKO-KNINSKA',now(),now(),1),
#4500
('Piškorevci',31417,'Piškorevci','OSJEČKO-BARANJSKA',now(),now(),1),
#4501
('Piškovec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4502
('Piškovica',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#4503
('Pitomača',33405,'Pitomača','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4504
('Pitve',21465,'Jelsa','SPLITSKO-DALMATINSKA',now(),now(),1),
#4505
('Pivare',35435,'Stara Gradiška','BRODSKO-POSAVSKA',now(),now(),1),
#4506
('Pivnica Slavonska',33533,'Pivnica Slavonska','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4507
('Pješčanica',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4508
('Plajzi',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#4509
('Planica',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#4510
('Planina Donja',10362,'Kašina','GRAD ZAGREB',now(),now(),1),
#4511
('Planina Gornja',10362,'Kašina','GRAD ZAGREB',now(),now(),1),
#4512
('Planina Kunićka',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#4513
('Planina Skradska',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#4514
('Plano',21220,'Trogir','SPLITSKO-DALMATINSKA',now(),now(),1),
#4515
('Plastovo',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#4516
('Plaški',47304,'Plaški','KARLOVAČKA',now(),now(),1),
#4517
('Plat',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4518
('Plavci',10457,'Sošice','ZAGREBAČKA',now(),now(),1),
#4519
('Plavić',49296,'Zagorska Sela','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4520
('Plavnice Gornje',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4521
('Plavnice Stare',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4522
('Plavno',22301,'Golubić','ŠIBENSKO-KNINSKA',now(),now(),1),
#4523
('Plavšinac',48325,'Novigrad Podravski','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4524
('Plemenitaš',51328,'Lukovdol','PRIMORSKO-GORANSKA',now(),now(),1),
#4525
('Plemenšćina',42244,'Klenovnik','VARAŽDINSKA',now(),now(),1),
#4526
('Plesmo',44325,'Krapje','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4527
('Pleš',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#4528
('Plešce',51303,'Plešce','PRIMORSKO-GORANSKA',now(),now(),1),
#4529
('Plešići',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#4530
('Plešivica',51329,'Severin na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#4531
('Plešivica',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#4532
('Plešivica',40314,'Selnica','MEĐIMURSKA',now(),now(),1),
#4533
('Pleškovec',40311,'Lopatinec','MEĐIMURSKA',now(),now(),1),
#4534
('Pleternica',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4535
('Pleternički Mihaljevci',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4536
('Plina Jezero',20340,'Ploče','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4537
('Plisko Polje',21480,'Vis','SPLITSKO-DALMATINSKA',now(),now(),1),
#4538
('Plišići',51242,'Drivenik','PRIMORSKO-GORANSKA',now(),now(),1),
#4539
('Plitvica Selo',53231,'Plitvička Jezera','LIČKO-SENJSKA',now(),now(),1),
#4540
('Plitvica Voćanska',42245,'Donja Voća','VARAŽDINSKA',now(),now(),1),
#4541
('Plitvička Jezera',53231,'Plitvička Jezera','LIČKO-SENJSKA',now(),now(),1),
#4542
('Plitvički Ljeskovac',53231,'Plitvička Jezera','LIČKO-SENJSKA',now(),now(),1),
#4543
('Ploče',20340,'Ploče','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4544
('Pločice',20218,'Pločice','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4545
('Plomin',52234,'Plomin','ISTARSKA',now(),now(),1),
#4546
('Plomin Luka',52234,'Plomin','ISTARSKA',now(),now(),1),
#4547
('Plosna',51223,'Škrljevo','PRIMORSKO-GORANSKA',now(),now(),1),
#4548
('Ploštine',34552,'Badljevina','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4549
('Plovanija',52460,'Buje (Buie)','ISTARSKA',now(),now(),1),
#4550
('Pluska',10296,'Luka','ZAGREBAČKA',now(),now(),1),
#4551
('Pobjenik',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4552
('Pobrđani',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4553
('Pobrđani',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4554
('Pobrežje',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4555
('Pobri',51211,'Matulji','PRIMORSKO-GORANSKA',now(),now(),1),
#4556
('Počekaji',52420,'Buzet','ISTARSKA',now(),now(),1),
#4557
('Počitelj',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#4558
('Podaca',21335,'Podaca','SPLITSKO-DALMATINSKA',now(),now(),1),
#4559
('Podašpilje',21208,'Kučiće','SPLITSKO-DALMATINSKA',now(),now(),1),
#4560
('Podbablje Gornje',21262,'Kamenmost','SPLITSKO-DALMATINSKA',now(),now(),1),
#4561
('Podbilo',53271,'Krivi Put','LIČKO-SENJSKA',now(),now(),1),
#4562
('Podbitoraj',47313,'Drežnica','KARLOVAČKA',now(),now(),1),
#4563
('Podbrđani Vojkovački',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4564
('Podbrđe',44317,'Popovača','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4565
('Podbrest',40322,'Orehovica','MEĐIMURSKA',now(),now(),1),
#4566
('Podbrezovica',49225,'Đurmanec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4567
('Podbrežje',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#4568
('Podcrkavlje',35201,'Podcrkavlje','BRODSKO-POSAVSKA',now(),now(),1),
#4569
('Podčudnič',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#4570
('Podevčevo',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#4571
('Podgače',52422,'Lanišće','ISTARSKA',now(),now(),1),
#4572
('Podgaj Petrovski',49234,'Petrovsko','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4573
('Podgajci Podravski',31552,'Podgajci Podravski','OSJEČKO-BARANJSKA',now(),now(),1),
#4574
('Podgajci Posavski',32258,'Posavski Podgajci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4575
('Podgajec',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4576
('Podgarić',43233,'Trnovitički Popovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4577
('Podglavica',22203,'Rogoznica','ŠIBENSKO-KNINSKA',now(),now(),1),
#4578
('Podgora',21327,'Podgora','SPLITSKO-DALMATINSKA',now(),now(),1),
#4579
('Podgora',20232,'Slano','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4580
('Podgora',49295,'Kumrovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4581
('Podgora Krapinska',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4582
('Podgora Turkovska',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#4583
('Podgorač',31433,'Podgorač','OSJEČKO-BARANJSKA',now(),now(),1),
#4584
('Podgorani',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#4585
('Podgorci',43211,'Predavac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4586
('Podgori',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#4587
('Podgorje',20250,'Orebić','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4588
('Podgorje',34335,'Vetovo','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4589
('Podgorje',33000,'Virovitica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4590
('Podgorje',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4591
('Podgorje Bednjansko',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#4592
('Podgorje Bistričko',49246,'Marija Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4593
('Podgorje Bračevačko',31433,'Podgorač','OSJEČKO-BARANJSKA',now(),now(),1),
#4594
('Podgorje Jamničko',10451,'Pisarovina','ZAGREBAČKA',now(),now(),1),
#4595
('Podgorje Krnjačko',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#4596
('Podgradina',20355,'Opuzen','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4597
('Podgradina',23242,'Posedarje','ZADARSKA',now(),now(),1),
#4598
('Podgrađe',23420,'Benkovac','ZADARSKA',now(),now(),1),
#4599
('Podgrađe',21207,'Kostanje','SPLITSKO-DALMATINSKA',now(),now(),1),
#4600
('Podgrađe',32245,'Nijemci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4601
('Podgrađe',49246,'Marija Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4602
('Podgrađe Podokićko',10435,'Sveti Martin pod Okićem','ZAGREBAČKA',now(),now(),1),
#4603
('Podgraj',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#4604
('Podhum',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#4605
('Podhumlje',21405,'Milna','SPLITSKO-DALMATINSKA',now(),now(),1),
#4606
('Podhumlje',21483,'Podšpilje','SPLITSKO-DALMATINSKA',now(),now(),1),
#4607
('Podi',21242,'Grab','SPLITSKO-DALMATINSKA',now(),now(),1),
#4608
('Podimoć',20231,'Doli','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4609
('Podine',22206,'Boraja','ŠIBENSKO-KNINSKA',now(),now(),1),
#4610
('Podine',23452,'Karin','ZADARSKA',now(),now(),1),
#4611
('Podjales',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#4612
('Podkilavac',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#4613
('Podkuk',52420,'Buzet','ISTARSKA',now(),now(),1),
#4614
('Podlapača',53236,'Podlapača','LIČKO-SENJSKA',now(),now(),1),
#4615
('Podlug',23420,'Benkovac','ZADARSKA',now(),now(),1),
#4616
('Podlužan',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#4617
('Podmelnica',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#4618
('Podmelnik',51252,'Klenovica','PRIMORSKO-GORANSKA',now(),now(),1),
#4619
('Podobuče',20250,'Orebić','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4620
('Podolec',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#4621
('Podolje',31303,'Popovac','OSJEČKO-BARANJSKA',now(),now(),1),
#4622
('Podorljak',22203,'Rogoznica','ŠIBENSKO-KNINSKA',now(),now(),1),
#4623
('Podosoje',21236,'Vrlika','SPLITSKO-DALMATINSKA',now(),now(),1),
#4624
('Podosoje',21261,'Runović','SPLITSKO-DALMATINSKA',now(),now(),1),
#4625
('Podoštra',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#4626
('Podpićan',52333,'Podpićan','ISTARSKA',now(),now(),1),
#4627
('Podprolog',21277,'Veliki Prolog','SPLITSKO-DALMATINSKA',now(),now(),1),
#4628
('Podravlje',31000,'Osijek','OSJEČKO-BARANJSKA',now(),now(),1),
#4629
('Podravska Moslavina',31530,'Podravska Moslavina','OSJEČKO-BARANJSKA',now(),now(),1),
#4630
('Podravske Sesvete',48363,'Podravske Sesvete','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4631
('Podrebar',52420,'Buzet','ISTARSKA',now(),now(),1),
#4632
('Podrebar',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#4633
('Podrinje',32213,'Markušica','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4634
('Podrujnica',20341,'Kula Norinska','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4635
('Podrute',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#4636
('Podrvanj',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#4637
('Podsedlo',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#4638
('Podselje',21480,'Vis','SPLITSKO-DALMATINSKA',now(),now(),1),
#4639
('Podskoči',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#4640
('Podslemski Lazi',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#4641
('Podsopalj Belgradski',51243,'Tribalj','PRIMORSKO-GORANSKA',now(),now(),1),
#4642
('Podsopalj Drivenički',51243,'Tribalj','PRIMORSKO-GORANSKA',now(),now(),1),
#4643
('Podsreće',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4644
('Podstena',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#4645
('Podstene',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#4646
('Podstene',51303,'Plešce','PRIMORSKO-GORANSKA',now(),now(),1),
#4647
('Podstrana',21312,'Podstrana','SPLITSKO-DALMATINSKA',now(),now(),1),
#4648
('Podstrana',53213,'Donje Pazarište','LIČKO-SENJSKA',now(),now(),1),
#4649
('Podstražje',21480,'Vis','SPLITSKO-DALMATINSKA',now(),now(),1),
#4650
('Podšpilje',21483,'Podšpilje','SPLITSKO-DALMATINSKA',now(),now(),1),
#4651
('Podtisovac',51316,'Lokve','PRIMORSKO-GORANSKA',now(),now(),1),
#4652
('Podturen',40317,'Podturen','MEĐIMURSKA',now(),now(),1),
#4653
('Podugrinac',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#4654
('Poduljin',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#4655
('Podum',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#4656
('Podumci',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#4657
('Podumol',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#4658
('Podunavlje',31327,'Bilje','OSJEČKO-BARANJSKA',now(),now(),1),
#4659
('Podvinje',35107,'Podvinje','BRODSKO-POSAVSKA',now(),now(),1),
#4660
('Podvinje Miholečko',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4661
('Podvorec',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#4662
('Podvornica',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#4663
('Podvožić',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#4664
('Podvrh',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#4665
('Podvršje',23248,'Ražanac','ZADARSKA',now(),now(),1),
#4666
('Podvrško',35404,'Cernik','BRODSKO-POSAVSKA',now(),now(),1),
#4667
('Podvučnik',51328,'Lukovdol','PRIMORSKO-GORANSKA',now(),now(),1),
#4668
('Pofuki',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4669
('Pogančec',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#4670
('Poganovci',31432,'Budimci','OSJEČKO-BARANJSKA',now(),now(),1),
#4671
('Pojatno',10294,'Donja Pušća','ZAGREBAČKA',now(),now(),1),
#4672
('Pokasin',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#4673
('Poklek',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#4674
('Pokojec',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4675
('Pokrovnik',22221,'Lozovac','ŠIBENSKO-KNINSKA',now(),now(),1),
#4676
('Pokupsko',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#4677
('Pokupsko Vratečko',44273,'Sela','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4678
('Polača',23423,'Polača','ZADARSKA',now(),now(),1),
#4679
('Polača',22310,'Kijevo','ŠIBENSKO-KNINSKA',now(),now(),1),
#4680
('Polače',20226,'Goveđari','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4681
('Police',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4682
('Police Pirišće',47282,'Kamanje','KARLOVAČKA',now(),now(),1),
#4683
('Poličnik',23241,'Poličnik','ZADARSKA',now(),now(),1),
#4684
('Pologi',10293,'Dubravica','ZAGREBAČKA',now(),now(),1),
#4685
('Poloje',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4686
('Polojski Varoš',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#4687
('Polonje',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#4688
('Polonje Tomaševečko',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#4689
('Polubaše',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#4690
('Polum',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4691
('Poljana',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#4692
('Poljana',51326,'Vrbovsko','PRIMORSKO-GORANSKA',now(),now(),1),
#4693
('Poljana',23273,'Preko','ZADARSKA',now(),now(),1),
#4694
('Poljana',34543,'Poljana','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4695
('Poljana Biškupečka',42201,'Beretinec','VARAŽDINSKA',now(),now(),1),
#4696
('Poljana Čička',10415,'Novo Čiče','ZAGREBAČKA',now(),now(),1),
#4697
('Poljana Križevačka',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4698
('Poljana Lekenička',44272,'Lekenik','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4699
('Poljana Sutlanska',49296,'Zagorska Sela','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4700
('Poljana Vojnićka',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#4701
('Poljanak',53231,'Plitvička Jezera','LIČKO-SENJSKA',now(),now(),1),
#4702
('Poljanci',35213,'Oprisavci','BRODSKO-POSAVSKA',now(),now(),1),
#4703
('Poljančani',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4704
('Poljane',51414,'Ičići','PRIMORSKO-GORANSKA',now(),now(),1),
#4705
('Poljane',35428,'Dragalić','BRODSKO-POSAVSKA',now(),now(),1),
#4706
('Poljanec',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#4707
('Poljani',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4708
('Poljanica Bistranska',10298,'Donja Bistra','ZAGREBAČKA',now(),now(),1),
#4709
('Poljanica Bistrička',49246,'Marija Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4710
('Poljanica Okićka',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#4711
('Poljanska',34330,'Velika','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4712
('Poljanski Lug',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#4713
('Polje',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#4714
('Polje',51515,'Šilo','PRIMORSKO-GORANSKA',now(),now(),1),
#4715
('Polje',23287,'Veli Rat','ZADARSKA',now(),now(),1),
#4716
('Polje Ćepić',52232,'Kršan','ISTARSKA',now(),now(),1),
#4717
('Polje Krapinsko',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4718
('Polje Ozaljsko',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#4719
('Poljica',21466,'Zastražišće','SPLITSKO-DALMATINSKA',now(),now(),1),
#4720
('Poljica',21263,'Krivodol','SPLITSKO-DALMATINSKA',now(),now(),1),
#4721
('Poljica',21222,'Marina','SPLITSKO-DALMATINSKA',now(),now(),1),
#4722
('Poljica',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#4723
('Poljica',23235,'Vrsi','ZADARSKA',now(),now(),1),
#4724
('Poljica Kozička',21275,'Dragljane','SPLITSKO-DALMATINSKA',now(),now(),1),
#4725
('Poljica-Brig',23235,'Vrsi','ZADARSKA',now(),now(),1),
#4726
('Poljice',20215,'Gruda','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4727
('Poljice',53234,'Udbina','LIČKO-SENJSKA',now(),now(),1),
#4728
('Pomena',20226,'Goveđari','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4729
('Pomer',52100,'Pula (Pola)','ISTARSKA',now(),now(),1),
#4730
('Pomperovec',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4731
('Ponikvari',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4732
('Ponikve',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#4733
('Ponikve',51223,'Škrljevo','PRIMORSKO-GORANSKA',now(),now(),1),
#4734
('Ponikve  (Opć. Ogulin)',51329,'Severin na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#4735
('Ponor',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#4736
('Ponor Korenički',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#4737
('Ponorac',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#4738
('Ponorac Perjasički',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#4739
('Ponori',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#4740
('Poplat',20270,'Vela Luka','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4741
('Popova Luka',20246,'Janjina','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4742
('Popovac',33522,'Voćin','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4743
('Popovac',31303,'Popovac','OSJEČKO-BARANJSKA',now(),now(),1),
#4744
('Popovac Subocki',44330,'Novska','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4745
('Popovača',44317,'Popovača','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4746
('Popovača Pazariška',53213,'Donje Pazarište','LIČKO-SENJSKA',now(),now(),1),
#4747
('Popovci',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4748
('Popovec',10360,'Sesvete','GRAD ZAGREB',now(),now(),1),
#4749
('Popovec Kalnički',48269,'Kalnik','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4750
('Popović Brdo',47212,'Skakavac','KARLOVAČKA',now(),now(),1),
#4751
('Popovići',20215,'Gruda','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4752
('Popovići',23420,'Benkovac','ZADARSKA',now(),now(),1),
#4753
('Popovići Žumberački',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#4754
('Popovo Selo',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#4755
('Porat',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#4756
('Poreč',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#4757
('Poreč',34343,'Bektež','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4758
('Poredje',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4759
('Porozina',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#4760
('Posavski Bregi',10311,'Posavski Bregi','ZAGREBAČKA',now(),now(),1),
#4761
('Posedarje',23242,'Posedarje','ZADARSKA',now(),now(),1),
#4762
('Postira',21410,'Postira','SPLITSKO-DALMATINSKA',now(),now(),1),
#4763
('Postranje',21264,'Donji Proložac','SPLITSKO-DALMATINSKA',now(),now(),1),
#4764
('Potcetin',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#4765
('Pothum Plaščanski',47304,'Plaški','KARLOVAČKA',now(),now(),1),
#4766
('Potirna',20270,'Vela Luka','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4767
('Potkobiljak',51323,'Lič','PRIMORSKO-GORANSKA',now(),now(),1),
#4768
('Potkonje',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#4769
('Potnjani',31423,'Bračevci','OSJEČKO-BARANJSKA',now(),now(),1),
#4770
('Potočani',34330,'Velika','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4771
('Potočani',43532,'Đulovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4772
('Potočec',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#4773
('Potočnica',53291,'Novalja','LIČKO-SENJSKA',now(),now(),1),
#4774
('Potok',43232,'Berek','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4775
('Potok',44317,'Popovača','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4776
('Potok Bosiljevski',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#4777
('Potok Kalnički',48269,'Kalnik','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4778
('Potok Muslinski',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#4779
('Potok Tounjski',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#4780
('Potomje',20244,'Potomje','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4781
('Potplaninsko',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#4782
('Potpoletnica',21255,'Zadvarje','SPLITSKO-DALMATINSKA',now(),now(),1),
#4783
('Potravlje',21233,'Hrvace','SPLITSKO-DALMATINSKA',now(),now(),1),
#4784
('Povelić',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4785
('Povile',51250,'Novi Vinodolski','PRIMORSKO-GORANSKA',now(),now(),1),
#4786
('Povlja',21413,'Povlja','SPLITSKO-DALMATINSKA',now(),now(),1),
#4787
('Povljana',23249,'Povljana','ZADARSKA',now(),now(),1),
#4788
('Pozla Gora',20278,'Nova Sela','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4789
('Poznanovec',49222,'Poznanovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4790
('Pozorac',21222,'Marina','SPLITSKO-DALMATINSKA',now(),now(),1),
#4791
('Požar',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#4792
('Požari',33000,'Virovitica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4793
('Požarkovec',49214,'Veliko Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4794
('Požarnica',51303,'Plešce','PRIMORSKO-GORANSKA',now(),now(),1),
#4795
('Požega',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4796
('Požeški Brđani',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4797
('Požun',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#4798
('Pračana',52420,'Buzet','ISTARSKA',now(),now(),1),
#4799
('Prapatnica',21201,'Prgomet','SPLITSKO-DALMATINSKA',now(),now(),1),
#4800
('Prapatnica',21276,'Vrgorac','SPLITSKO-DALMATINSKA',now(),now(),1),
#4801
('Prapoče',52422,'Lanišće','ISTARSKA',now(),now(),1),
#4802
('Praporčan',40314,'Selnica','MEĐIMURSKA',now(),now(),1),
#4803
('Praputnjak',51225,'Praputnjak','PRIMORSKO-GORANSKA',now(),now(),1),
#4804
('Prašćari',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#4805
('Prašćevac',10344,'Farkaševac','ZAGREBAČKA',now(),now(),1),
#4806
('Prautina',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#4807
('Pražnica',21424,'Pražnica','SPLITSKO-DALMATINSKA',now(),now(),1),
#4808
('Prebukovje',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#4809
('Prečec',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#4810
('Prečno',10372,'Oborovo','ZAGREBAČKA',now(),now(),1),
#4811
('Predavac',43211,'Predavac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4812
('Predavec',10312,'Kloštar Ivanić','ZAGREBAČKA',now(),now(),1),
#4813
('Predavec Križevački',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4814
('Predošćica',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#4815
('Pregrada',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4816
('Prekno',42205,'Vidovec','VARAŽDINSKA',now(),now(),1),
#4817
('Preko',23273,'Preko','ZADARSKA',now(),now(),1),
#4818
('Prekobrdo',43211,'Predavac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4819
('Prekopa',40312,'Štrigova','MEĐIMURSKA',now(),now(),1),
#4820
('Prekopa',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4821
('Prekopakra',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4822
('Prekoračani',33514,'Čačinci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4823
('Prekrižje Plešivičko',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#4824
('Prekvršje',10362,'Kašina','GRAD ZAGREB',now(),now(),1),
#4825
('Prelog',40323,'Prelog','MEĐIMURSKA',now(),now(),1),
#4826
('Prelošćica',44202,'Topolovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4827
('Premantura',52100,'Pula (Pola)','ISTARSKA',now(),now(),1),
#4828
('Premuda',23294,'Premuda','ZADARSKA',now(),now(),1),
#4829
('Prepolno',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#4830
('Prepuštovec',10362,'Kašina','GRAD ZAGREB',now(),now(),1),
#4831
('Prepuštovec',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4832
('Presečno',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#4833
('Presečno Visočko',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#4834
('Preseka',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#4835
('Preseka',40306,'Macinec','MEĐIMURSKA',now(),now(),1),
#4836
('Preseka Oborovska',10372,'Oborovo','ZAGREBAČKA',now(),now(),1),
#4837
('Preseka Ozaljska',47282,'Kamanje','KARLOVAČKA',now(),now(),1),
#4838
('Preseka Petrovska',49234,'Petrovsko','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4839
('Presika',52220,'Labin','ISTARSKA',now(),now(),1),
#4840
('Presika',51326,'Vrbovsko','PRIMORSKO-GORANSKA',now(),now(),1),
#4841
('Preslatinci',31418,'Drenje','OSJEČKO-BARANJSKA',now(),now(),1),
#4842
('Prespa',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4843
('Pretetinec',40305,'Nedelišće','MEĐIMURSKA',now(),now(),1),
#4844
('Pretkovec',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4845
('Pretoki',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#4846
('Previž',52402,'Cerovlje','ISTARSKA',now(),now(),1),
#4847
('Prevlaka',10372,'Oborovo','ZAGREBAČKA',now(),now(),1),
#4848
('Prevršac',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4849
('Prezid',51307,'Prezid','PRIMORSKO-GORANSKA',now(),now(),1),
#4850
('Prgomelje',43252,'Prgomelje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4851
('Prgomelje',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4852
('Prgomelje',34553,'Bučje','POŽEŠKO-SLAVONSKA',now(),now(),1),
#4853
('Prgomet',21201,'Prgomet','SPLITSKO-DALMATINSKA',now(),now(),1),
#4854
('Prhati',52207,'Barban','ISTARSKA',now(),now(),1),
#4855
('Prhati',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#4856
('Prhci',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#4857
('Prhoć',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#4858
('Prhovec',40312,'Štrigova','MEĐIMURSKA',now(),now(),1),
#4859
('Prhutova Draga',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#4860
('Pribanjci',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#4861
('Pribić',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#4862
('Pribić Crkveni',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#4863
('Pribislavec',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#4864
('Pribiševci',31511,'Đurđenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#4865
('Pribude',21206,'Donje Ogorje','SPLITSKO-DALMATINSKA',now(),now(),1),
#4866
('Pribude',21229,'Crivac','SPLITSKO-DALMATINSKA',now(),now(),1),
#4867
('Pribudić',23440,'Gračac','ZADARSKA',now(),now(),1),
#4868
('Pričac',35257,'Lužani','BRODSKO-POSAVSKA',now(),now(),1),
#4869
('Pridraga',23226,'Pridraga','ZADARSKA',now(),now(),1),
#4870
('Pridvorje',31418,'Drenje','OSJEČKO-BARANJSKA',now(),now(),1),
#4871
('Pridvorje',20217,'Pridvorje','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4872
('Prigorec',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#4873
('Prigorje',49225,'Đurmanec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4874
('Prigorje 30-32',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4875
('Prigorje Brdovečko',10291,'Prigorje Brdovečko','ZAGREBAČKA',now(),now(),1),
#4876
('Prijeboj',53231,'Plitvička Jezera','LIČKO-SENJSKA',now(),now(),1),
#4877
('Prijeka',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4878
('Prijevor',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4879
('Prikraj',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#4880
('Prikraj Križevački',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4881
('Priles',42233,'Sveti Đurđ','VARAŽDINSKA',now(),now(),1),
#4882
('Prilesje',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#4883
('Prilipje',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#4884
('Primorski Dolac',21227,'Primorski Dolac','SPLITSKO-DALMATINSKA',now(),now(),1),
#4885
('Primošten',22202,'Primošten','ŠIBENSKO-KNINSKA',now(),now(),1),
#4886
('Primošten Burnji/dio/',22202,'Primošten','ŠIBENSKO-KNINSKA',now(),now(),1),
#4887
('Priselci',47286,'Mahično','KARLOVAČKA',now(),now(),1),
#4888
('Prisjeka',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#4889
('Prisoje',21232,'Dicmo','SPLITSKO-DALMATINSKA',now(),now(),1),
#4890
('Pristanište',20226,'Goveđari','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4891
('Pristava',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4892
('Pristava Krapinska',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4893
('Pristeg',23420,'Benkovac','ZADARSKA',now(),now(),1),
#4894
('Prišlin',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4895
('Privlaka',32251,'Privlaka','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4896
('Privlaka',23233,'Privlaka (Dalmacija)','ZADARSKA',now(),now(),1),
#4897
('Prizna',53287,'Jablanac','LIČKO-SENJSKA',now(),now(),1),
#4898
('Prkačini',52341,'Žminj','ISTARSKA',now(),now(),1),
#4899
('Prkos',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4900
('Prkos',23223,'Škabrnja','ZADARSKA',now(),now(),1),
#4901
('Prkos Ivanićki',10313,'Graberje Ivaničko','ZAGREBAČKA',now(),now(),1),
#4902
('Prkos Lasinjski',47206,'Lasinja','KARLOVAČKA',now(),now(),1),
#4903
('Prkovci',32282,'Retkovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4904
('Prljevo',23440,'Gračac','ZADARSKA',now(),now(),1),
#4905
('Prnjarovac',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4906
('Prnjavor',43211,'Predavac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4907
('Prnjavor',35216,'Prnjavor','BRODSKO-POSAVSKA',now(),now(),1),
#4908
('Prnjavor Čuntićki',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4909
('Prnjavor Lepavinski',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4910
('Proboj',23250,'Pag','ZADARSKA',now(),now(),1),
#4911
('Prodani',52420,'Buzet','ISTARSKA',now(),now(),1),
#4912
('Prodin Dol',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#4913
('Prodol',52208,'Krnica','ISTARSKA',now(),now(),1),
#4914
('Prokike',53260,'Brinje','LIČKO-SENJSKA',now(),now(),1),
#4915
('Prokljuvani',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4916
('Prokljuvani',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4917
('Promajna',21323,'Promajna','SPLITSKO-DALMATINSKA',now(),now(),1),
#4918
('Prosenik',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4919
('Prosenik Gubaševski',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4920
('Prosenik Začretski',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4921
('Prosenik Začretski 1-5',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4922
('Prosika',22213,'Pirovac','ŠIBENSKO-KNINSKA',now(),now(),1),
#4923
('Prosinec',10293,'Dubravica','ZAGREBAČKA',now(),now(),1),
#4924
('Protulipa',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#4925
('Prović',23422,'Stankovci','ZADARSKA',now(),now(),1),
#4926
('Prozor',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#4927
('Prozorje',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#4928
('Prožura',20224,'Maranovići','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4929
('Prožurska Luka',20224,'Maranovići','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4930
('Pršleti',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#4931
('Pršurići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#4932
('Prud',20352,'Vid','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4933
('Prudnice',10291,'Prigorje Brdovečko','ZAGREBAČKA',now(),now(),1),
#4934
('Prugovac',48362,'Kloštar Podravski','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4935
('Prugovo',21231,'Klis','SPLITSKO-DALMATINSKA',now(),now(),1),
#4936
('Prvan Selo',53202,'Perušić','LIČKO-SENJSKA',now(),now(),1),
#4937
('Prvča',35400,'Nova Gradiška','BRODSKO-POSAVSKA',now(),now(),1),
#4938
('Prvić Luka',22233,'Prvić Luka','ŠIBENSKO-KNINSKA',now(),now(),1),
#4939
('Prvić Šepurine',22234,'Prvić Šepurine','ŠIBENSKO-KNINSKA',now(),now(),1),
#4940
('Prvinci',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#4941
('Prvonožina',10418,'Dubranec','ZAGREBAČKA',now(),now(),1),
#4942
('Przinovac',20357,'Blace','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4943
('Pucak',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#4944
('Pucići',52341,'Žminj','ISTARSKA',now(),now(),1),
#4945
('Pučišća',21412,'Pučišća','SPLITSKO-DALMATINSKA',now(),now(),1),
#4946
('Puhovo',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#4947
('Puklica',43532,'Đulovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4948
('Pula',52100,'Pula (Pola)','ISTARSKA',now(),now(),1),
#4949
('Puljane',22303,'Oklaj','ŠIBENSKO-KNINSKA',now(),now(),1),
#4950
('Punat',51521,'Punat','PRIMORSKO-GORANSKA',now(),now(),1),
#4951
('Punikve',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#4952
('Punitovci',31424,'Punitovci','OSJEČKO-BARANJSKA',now(),now(),1),
#4953
('Punta Križa',51554,'Nerezine','PRIMORSKO-GORANSKA',now(),now(),1),
#4954
('Puntera',52207,'Barban','ISTARSKA',now(),now(),1),
#4955
('Pupelica',43227,'Šandrovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4956
('Pupnat',20274,'Pupnat','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4957
('Purga Bednjanska',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#4958
('Purgarija Ćepić',52232,'Kršan','ISTARSKA',now(),now(),1),
#4959
('Puričani',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#4960
('Puska',44325,'Krapje','SISAČKO-MOSLAVAČKA',now(),now(),1),
#4961
('Pustakovec',48314,'Koprivnički Ivanec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4962
('Pusti',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#4963
('Pustike',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#4964
('Pustodol',49240,'Donja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4965
('Pustodol Orehovički',49228,'Brestovec Orehovički','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4966
('Pustodol Začretski',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4967
('Pušava',49294,'Kraljevec na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4968
('Pušća',49296,'Zagorska Sela','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4969
('Pušćine',40305,'Nedelišće','MEĐIMURSKA',now(),now(),1),
#4970
('Pušina',33514,'Čačinci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#4971
('Puškarići',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#4972
('Putičanje',22213,'Pirovac','ŠIBENSKO-KNINSKA',now(),now(),1),
#4973
('Putini',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#4974
('Putišići',21205,'Donji Dolac','SPLITSKO-DALMATINSKA',now(),now(),1),
#4975
('Putkovec',49225,'Đurmanec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4976
('Putniković',20248,'Putniković','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4977
('Rab',51280,'Rab','PRIMORSKO-GORANSKA',now(),now(),1),
#4978
('Raba',20356,'Klek','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4979
('Rabac',52221,'Rabac','ISTARSKA',now(),now(),1),
#4980
('Rabinja',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#4981
('Račak',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#4982
('Račice',52420,'Buzet','ISTARSKA',now(),now(),1),
#4983
('Račički Brijeg',52420,'Buzet','ISTARSKA',now(),now(),1),
#4984
('Račinovci',32262,'Račinovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#4985
('Račišće',20264,'Račišće','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#4986
('Račja Vas',52422,'Lanišće','ISTARSKA',now(),now(),1),
#4987
('Radakovo',49294,'Kraljevec na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#4988
('Radatovići',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#4989
('Radeljevo Selo',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#4990
('Radešić',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#4991
('Radetići',52444,'Tinjan','ISTARSKA',now(),now(),1),
#4992
('Radići',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#4993
('Radići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#4994
('Radigojna',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#4995
('Radikovci',31543,'Miholjački Poreč','OSJEČKO-BARANJSKA',now(),now(),1),
#4996
('Radina Gorica',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#4997
('Radina Vas',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#4998
('Radini',52474,'Brtonigla (Verteneglio)','ISTARSKA',now(),now(),1),
#4999
('Radinovo Brdo',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#5000
('Radljevac',22301,'Golubić','ŠIBENSKO-KNINSKA',now(),now(),1),
#5001
('Radmani',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#5002
('Radmanovac',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#5003
('Radnovac',34308,'Jakšić','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5004
('Radoboj',49232,'Radoboj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5005
('Radočaj Brodski',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#5006
('Radočaji',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#5007
('Radoišće',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#5008
('Radojčići',47313,'Drežnica','KARLOVAČKA',now(),now(),1),
#5009
('Radonić',22221,'Lozovac','ŠIBENSKO-KNINSKA',now(),now(),1),
#5010
('Radonja',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#5011
('Radonja Luka',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5012
('Radosavci',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5013
('Radoševići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#5014
('Radoši kod Višnjana',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#5015
('Radoši kod Žbandaja',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#5016
('Radošić',21202,'Lećevica','SPLITSKO-DALMATINSKA',now(),now(),1),
#5017
('Radošić',21230,'Sinj','SPLITSKO-DALMATINSKA',now(),now(),1),
#5018
('Radošinovci',23422,'Stankovci','ZADARSKA',now(),now(),1),
#5019
('Radovan',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#5020
('Radovanci',34330,'Velika','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5021
('Radovani',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#5022
('Radovanje',35250,'Oriovac','BRODSKO-POSAVSKA',now(),now(),1),
#5023
('Radovčići',20215,'Gruda','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5024
('Radovec',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#5025
('Radovec Polje',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#5026
('Radovin',23248,'Ražanac','ZADARSKA',now(),now(),1),
#5027
('Raduč',53244,'Lovinac','LIČKO-SENJSKA',now(),now(),1),
#5028
('Radučić',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#5029
('Radulec',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#5030
('Radunić',21206,'Donje Ogorje','SPLITSKO-DALMATINSKA',now(),now(),1),
#5031
('Rađenovci',44323,'Rajić','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5032
('Rafaeli',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#5033
('Raić',43252,'Prgomelje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5034
('Rajakovići',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#5035
('Rajčići',44323,'Rajić','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5036
('Rajevo Selo',32261,'Rajevo Selo','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#5037
('Rajić',44323,'Rajić','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5038
('Rajić Brdo',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#5039
('Rajino Polje',33514,'Čačinci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5040
('Rajki',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#5041
('Rajki',52207,'Barban','ISTARSKA',now(),now(),1),
#5042
('Rajsavac',34308,'Jakšić','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5043
('Rakalj',52208,'Krnica','ISTARSKA',now(),now(),1),
#5044
('Rakitje',10437,'Bestovje','ZAGREBAČKA',now(),now(),1),
#5045
('Rakitnica',48350,'Đurđevac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5046
('Rakitovec',10419,'Vukovina','ZAGREBAČKA',now(),now(),1),
#5047
('Rakitovica',31543,'Miholjački Poreč','OSJEČKO-BARANJSKA',now(),now(),1),
#5048
('Rakotule',52423,'Karojba','ISTARSKA',now(),now(),1),
#5049
('Rakov Potok',10436,'Rakov Potok','ZAGREBAČKA',now(),now(),1),
#5050
('Rakovačko Selište',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#5051
('Rakovci',52445,'Baderna','ISTARSKA',now(),now(),1),
#5052
('Rakovec',42222,'Ljubeščica','VARAŽDINSKA',now(),now(),1),
#5053
('Rakovec',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#5054
('Rakovec Tomaševečki',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5055
('Rakovica',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#5056
('Ramanovci',34334,'Kaptol','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5057
('Ramljane',21229,'Crivac','SPLITSKO-DALMATINSKA',now(),now(),1),
#5058
('Ramljane',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#5059
('Ramljani',53224,'Ličko Lešće','LIČKO-SENJSKA',now(),now(),1),
#5060
('Randići',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#5061
('Rapain Klanac',53260,'Brinje','LIČKO-SENJSKA',now(),now(),1),
#5062
('Rapanji',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#5063
('Rapavel',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#5064
('Rasinja',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5065
('Raskrižje',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#5066
('Raskrižje Tihovo',51300,'Delnice','PRIMORSKO-GORANSKA',now(),now(),1),
#5067
('Raslina',22215,'Zaton','ŠIBENSKO-KNINSKA',now(),now(),1),
#5068
('Rasna',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5069
('Rasohe',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#5070
('Rasopasno',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#5071
('Rastičevo',23440,'Gračac','ZADARSKA',now(),now(),1),
#5072
('Rastoka',53211,'Smiljan','LIČKO-SENJSKA',now(),now(),1),
#5073
('Rastoke',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#5074
('Rastoki',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#5075
('Rastovac',21270,'Zagvozd','SPLITSKO-DALMATINSKA',now(),now(),1),
#5076
('Rastovac',21228,'Blizna Donja','SPLITSKO-DALMATINSKA',now(),now(),1),
#5077
('Rastovac',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5078
('Rastovac',43231,'Ivanska','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5079
('Rastovac Budački',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#5080
('Rastovača',53231,'Plitvička Jezera','LIČKO-SENJSKA',now(),now(),1),
#5081
('Rastušje',35107,'Podvinje','BRODSKO-POSAVSKA',now(),now(),1),
#5082
('Raša',52223,'Raša','ISTARSKA',now(),now(),1),
#5083
('Raščane',21273,'Župa','SPLITSKO-DALMATINSKA',now(),now(),1),
#5084
('Raščane Gornje',21273,'Župa','SPLITSKO-DALMATINSKA',now(),now(),1),
#5085
('Raščani',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5086
('Rašpor',52422,'Lanišće','ISTARSKA',now(),now(),1),
#5087
('Raštević',23420,'Benkovac','ZADARSKA',now(),now(),1),
#5088
('Ratkov Dol',31416,'Levanjska Varoš','OSJEČKO-BARANJSKA',now(),now(),1),
#5089
('Ratkovac',35429,'Gornji Bogićevci','BRODSKO-POSAVSKA',now(),now(),1),
#5090
('Ratkovec',49250,'Zlatar','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5091
('Ratkovica',34315,'Ratkovica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5092
('Ratulje',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#5093
('Rausovac',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5094
('Rava',23283,'Rava','ZADARSKA',now(),now(),1),
#5095
('Ravan',35252,'Sibinj','BRODSKO-POSAVSKA',now(),now(),1),
#5096
('Ravča',21276,'Vrgorac','SPLITSKO-DALMATINSKA',now(),now(),1),
#5097
('Ravna Gora',51314,'Ravna Gora','PRIMORSKO-GORANSKA',now(),now(),1),
#5098
('Ravneš',43274,'Severin','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5099
('Ravni',52220,'Labin','ISTARSKA',now(),now(),1),
#5100
('Ravni Dabar',53206,'Brušane','LIČKO-SENJSKA',now(),now(),1),
#5101
('Ravnica',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#5102
('Ravnice',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#5103
('Ravnice',49214,'Veliko Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5104
('Ravnice Desinićke',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5105
('Ravninsko',49225,'Đurmanec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5106
('Ravno Brezje',49295,'Kumrovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5107
('Ravno Rašće',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5108
('Razbojište',31433,'Podgorač','OSJEČKO-BARANJSKA',now(),now(),1),
#5109
('Razdrto',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#5110
('Razdrto Tuheljsko',49295,'Kumrovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5111
('Razloge',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#5112
('Razloški Okrug',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#5113
('Razljev',10315,'Novoselec','ZAGREBAČKA',now(),now(),1),
#5114
('Razvođe',22303,'Oklaj','ŠIBENSKO-KNINSKA',now(),now(),1),
#5115
('Razvor',49295,'Kumrovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5116
('Ražanac',23248,'Ražanac','ZADARSKA',now(),now(),1),
#5117
('Ražanj',22203,'Rogoznica','ŠIBENSKO-KNINSKA',now(),now(),1),
#5118
('Rebić',53234,'Udbina','LIČKO-SENJSKA',now(),now(),1),
#5119
('Rebići',52207,'Barban','ISTARSKA',now(),now(),1),
#5120
('Rebrovići',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#5121
('Rečica',47203,'Rečica','KARLOVAČKA',now(),now(),1),
#5122
('Rečica Kriška',10315,'Novoselec','ZAGREBAČKA',now(),now(),1),
#5123
('Redovje',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#5124
('Reka',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5125
('Remetinec',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#5126
('Remetinec',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#5127
('Removac',43532,'Đulovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5128
('Rendulići',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#5129
('Repaš',48327,'Molve','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5130
('Repićevo Selo',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5131
('Repinec',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#5132
('Repišće',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#5133
('Repno',49254,'Belec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5134
('Repovec',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5135
('Repušnica',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5136
('Resnatac',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#5137
('Resnik',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5138
('Resnik Bosiljevski',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#5139
('Rešetar',53233,'Ličko Petrovo Selo','LIČKO-SENJSKA',now(),now(),1),
#5140
('Rešetarevo',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#5141
('Rešetari',35403,'Rešetari','BRODSKO-POSAVSKA',now(),now(),1),
#5142
('Reškovci',43211,'Predavac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5143
('Reštovo',47282,'Kamanje','KARLOVAČKA',now(),now(),1),
#5144
('Reštovo Žumberačko',10457,'Sošice','ZAGREBAČKA',now(),now(),1),
#5145
('Retkovci',32282,'Retkovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#5146
('Retkovec Svibovečki',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#5147
('Rezovac',33000,'Virovitica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5148
('Rezovačke Krčevine',33000,'Virovitica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5149
('Režanci',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#5150
('Ribari',47212,'Skakavac','KARLOVAČKA',now(),now(),1),
#5151
('Ribić Breg',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#5152
('Ribnica',10415,'Novo Čiče','ZAGREBAČKA',now(),now(),1),
#5153
('Ribnik',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#5154
('Ribnjaci',43283,'Kaniška Iva','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5155
('Ribnjačka',43273,'Bulinac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5156
('Ribnjak',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5157
('Ribnjak',31225,'Breznica Našička','OSJEČKO-BARANJSKA',now(),now(),1),
#5158
('Ričice',53244,'Lovinac','LIČKO-SENJSKA',now(),now(),1),
#5159
('Ričice',21267,'Ričice','SPLITSKO-DALMATINSKA',now(),now(),1),
#5160
('Ričina',51243,'Tribalj','PRIMORSKO-GORANSKA',now(),now(),1),
#5161
('Riđane',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#5162
('Riđica',20234,'Orašac','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5163
('Rijeka',51000,'Rijeka','PRIMORSKO-GORANSKA',now(),now(),1),
#5164
('Rijeka Koprivnička',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5165
('Rijeka Voćanska',42245,'Donja Voća','VARAŽDINSKA',now(),now(),1),
#5166
('Rijenci',33517,'Mikleuš','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5167
('Rim',52425,'Roč','ISTARSKA',now(),now(),1),
#5168
('Rim',51329,'Severin na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#5169
('Rimnjak',52420,'Buzet','ISTARSKA',now(),now(),1),
#5170
('Rinkovec',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#5171
('Ripenda Kosi',52220,'Labin','ISTARSKA',now(),now(),1),
#5172
('Ripenda Kras',52220,'Labin','ISTARSKA',now(),now(),1),
#5173
('Ripenda Verbanci',52220,'Labin','ISTARSKA',now(),now(),1),
#5174
('Risika',51516,'Vrbnik','PRIMORSKO-GORANSKA',now(),now(),1),
#5175
('Risvica',49295,'Kumrovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5176
('Rit',33407,'Gornje Bazje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5177
('Rivalno',42232,'Donji Martijanec','VARAŽDINSKA',now(),now(),1),
#5178
('Rivanj',23291,'Sestrunj','ZADARSKA',now(),now(),1),
#5179
('Rizvanuša',53206,'Brušane','LIČKO-SENJSKA',now(),now(),1),
#5180
('Robađe',40312,'Štrigova','MEĐIMURSKA',now(),now(),1),
#5181
('Roč',52425,'Roč','ISTARSKA',now(),now(),1),
#5182
('Ročko Polje',52425,'Roč','ISTARSKA',now(),now(),1),
#5183
('Rodaljice',23420,'Benkovac','ZADARSKA',now(),now(),1),
#5184
('Rodin Potok',33410,'Suhopolje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5185
('Rogačić',21480,'Vis','SPLITSKO-DALMATINSKA',now(),now(),1),
#5186
('Rogi',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#5187
('Rogočana',52220,'Labin','ISTARSKA',now(),now(),1),
#5188
('Rogotin',20343,'Rogotin','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5189
('Rogovac',33404,'Špišić Bukovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5190
('Rogovići',52465,'Tar (Torre)','ISTARSKA',now(),now(),1),
#5191
('Rogoznica',22203,'Rogoznica','ŠIBENSKO-KNINSKA',now(),now(),1),
#5192
('Rogoža',43282,'Veliko Vukovje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5193
('Rogulje',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5194
('Rogulje',34553,'Bučje','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5195
('Rogulje',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5196
('Rojci',52464,'Kaštelir (Castelliere)','ISTARSKA',now(),now(),1),
#5197
('Rojnići',52207,'Barban','ISTARSKA',now(),now(),1),
#5198
('Rokovci',32271,'Rokovci Andrijaševci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#5199
('Ropa',20225,'Babino Polje','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5200
('Ropci',51243,'Tribalj','PRIMORSKO-GORANSKA',now(),now(),1),
#5201
('Rosopajnik',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#5202
('Rosulje',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5203
('Rošini',52446,'Nova Vas','ISTARSKA',now(),now(),1),
#5204
('Roškići',52464,'Kaštelir (Castelliere)','ISTARSKA',now(),now(),1),
#5205
('Rovanjska',23450,'Obrovac','ZADARSKA',now(),now(),1),
#5206
('Rovanjska',23244,'Starigrad Paklenica','ZADARSKA',now(),now(),1),
#5207
('Rovci',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5208
('Rovinj',52210,'Rovinj (Rovigno)','ISTARSKA',now(),now(),1),
#5209
('Rovinjsko Selo',52210,'Rovinj (Rovigno)','ISTARSKA',now(),now(),1),
#5210
('Rovišće',43212,'Rovišće','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5211
('Roviška',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5212
('Rovištanci',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5213
('Rovno',49234,'Petrovsko','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5214
('Rozga',10293,'Dubravica','ZAGREBAČKA',now(),now(),1),
#5215
('Rozmajerovac',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#5216
('Rožat',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5217
('Roždanik',44323,'Rajić','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5218
('Rože',21245,'Tijarica','SPLITSKO-DALMATINSKA',now(),now(),1),
#5219
('Roženica',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#5220
('Rožići',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#5221
('Rožmanići',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#5222
('Rtić',51328,'Lukovdol','PRIMORSKO-GORANSKA',now(),now(),1),
#5223
('Rtina',23248,'Ražanac','ZADARSKA',now(),now(),1),
#5224
('Rubeši',51215,'Kastav','PRIMORSKO-GORANSKA',now(),now(),1),
#5225
('Ruča',10411,'Orle','ZAGREBAČKA',now(),now(),1),
#5226
('Ruda',21242,'Grab','SPLITSKO-DALMATINSKA',now(),now(),1),
#5227
('Rudani',52341,'Žminj','ISTARSKA',now(),now(),1),
#5228
('Rudanovac',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#5229
('Rude',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#5230
('Rude Pribićke',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#5231
('Rudeži',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5232
('Rudina',21460,'Stari Grad','SPLITSKO-DALMATINSKA',now(),now(),1),
#5233
('Rudine',51514,'Dobrinj','PRIMORSKO-GORANSKA',now(),now(),1),
#5234
('Rudinka',53203,'Kosinj','LIČKO-SENJSKA',now(),now(),1),
#5235
('Rudopolje',53223,'Vrhovine','LIČKO-SENJSKA',now(),now(),1),
#5236
('Rudopolje Bruvanjsko',23440,'Gračac','ZADARSKA',now(),now(),1),
#5237
('Rugvica',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#5238
('Rujevac',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5239
('Rujevo',47282,'Kamanje','KARLOVAČKA',now(),now(),1),
#5240
('Rukavac',51211,'Matulji','PRIMORSKO-GORANSKA',now(),now(),1),
#5241
('Rukavac',21480,'Vis','SPLITSKO-DALMATINSKA',now(),now(),1),
#5242
('Rukljevina',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#5243
('Rumin',21233,'Hrvace','SPLITSKO-DALMATINSKA',now(),now(),1),
#5244
('Runović',21261,'Runović','SPLITSKO-DALMATINSKA',now(),now(),1),
#5245
('Rupa',51214,'Šapjane','PRIMORSKO-GORANSKA',now(),now(),1),
#5246
('Rupalj',23241,'Poličnik','ZADARSKA',now(),now(),1),
#5247
('Rupe',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#5248
('Rupeni',52445,'Baderna','ISTARSKA',now(),now(),1),
#5249
('Rusnica',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5250
('Rušani',33411,'Gradina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5251
('Ruščica',35208,'Ruščica','BRODSKO-POSAVSKA',now(),now(),1),
#5252
('Ruševac',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5253
('Ruševac',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5254
('Ruševica',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#5255
('Ruševo',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5256
('Ruševo Krmpotsko',51252,'Klenovica','PRIMORSKO-GORANSKA',now(),now(),1),
#5257
('Ruškovac',43232,'Berek','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5258
('Ruškovica',44316,'Velika Ludina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5259
('Ružić',22322,'Ružić','ŠIBENSKO-KNINSKA',now(),now(),1),
#5260
('Ružić Selo',51226,'Hreljin','PRIMORSKO-GORANSKA',now(),now(),1),
#5261
('Ružići',52231,'Nedešćina','ISTARSKA',now(),now(),1),
#5262
('Ružići',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#5263
('Ružići',51213,'Jurdani','PRIMORSKO-GORANSKA',now(),now(),1),
#5264
('Ržišće',52231,'Nedešćina','ISTARSKA',now(),now(),1),
#5265
('Sabljaki Modruški',47303,'Josipdol','KARLOVAČKA',now(),now(),1),
#5266
('Sabljići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#5267
('Saborsko',47306,'Saborsko','KARLOVAČKA',now(),now(),1),
#5268
('Sadikovac',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#5269
('Sadilovac',47246,'Drežnik Grad','KARLOVAČKA',now(),now(),1),
#5270
('Saftići',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#5271
('Salajci',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#5272
('Salakovci',52220,'Labin','ISTARSKA',now(),now(),1),
#5273
('Salambati',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#5274
('Salež',52420,'Buzet','ISTARSKA',now(),now(),1),
#5275
('Sali',23281,'Sali','ZADARSKA',now(),now(),1),
#5276
('Salinovec',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#5277
('Salnik',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#5278
('Salopek Luke',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#5279
('Salopeki Modruški',47303,'Josipdol','KARLOVAČKA',now(),now(),1),
#5280
('Samarica',43232,'Berek','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5281
('Samatovci',31222,'Bizovac','OSJEČKO-BARANJSKA',now(),now(),1),
#5282
('Samci',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5283
('Samobor',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#5284
('Samoborec',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#5285
('Samoborski Otok',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#5286
('Santalezi',52231,'Nedešćina','ISTARSKA',now(),now(),1),
#5287
('Santrići',21255,'Zadvarje','SPLITSKO-DALMATINSKA',now(),now(),1),
#5288
('Sapavac',23234,'Vir','ZADARSKA',now(),now(),1),
#5289
('Sapci',35212,'Garčin','BRODSKO-POSAVSKA',now(),now(),1),
#5290
('Sapina Doca',22203,'Rogoznica','ŠIBENSKO-KNINSKA',now(),now(),1),
#5291
('Saplunara',20224,'Maranovići','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5292
('Sapna',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5293
('Sarovo',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#5294
('Saršoni',51216,'Viškovo','PRIMORSKO-GORANSKA',now(),now(),1),
#5295
('Sarvaš',31000,'Osijek','OSJEČKO-BARANJSKA',now(),now(),1),
#5296
('Sasi',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#5297
('Sasovac',43272,'Nova Rača','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5298
('Sastavak',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#5299
('Satnica',31222,'Bizovac','OSJEČKO-BARANJSKA',now(),now(),1),
#5300
('Satnica Đakovačka',31421,'Satnica Đakovačka','OSJEČKO-BARANJSKA',now(),now(),1),
#5301
('Satrić',21233,'Hrvace','SPLITSKO-DALMATINSKA',now(),now(),1),
#5302
('Savar',23285,'Brbinj','ZADARSKA',now(),now(),1),
#5303
('Savršćak',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#5304
('Savska Cesta',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#5305
('Savska Ves',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#5306
('Savski Bok',35400,'Nova Gradiška','BRODSKO-POSAVSKA',now(),now(),1),
#5307
('Savski Marof',10291,'Prigorje Brdovečko','ZAGREBAČKA',now(),now(),1),
#5308
('Savudrija',52475,'Savudrija (Salvore)','ISTARSKA',now(),now(),1),
#5309
('Sažije',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5310
('Sedalce',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#5311
('Sedlarica',33405,'Pitomača','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5312
('Sedramić',22320,'Drniš','ŠIBENSKO-KNINSKA',now(),now(),1),
#5313
('Seget',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#5314
('Seget Donji',21220,'Trogir','SPLITSKO-DALMATINSKA',now(),now(),1),
#5315
('Seget Gornji',21220,'Trogir','SPLITSKO-DALMATINSKA',now(),now(),1),
#5316
('Seget Vranjica',21220,'Trogir','SPLITSKO-DALMATINSKA',now(),now(),1),
#5317
('Segovina',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#5318
('Seketin',42204,'Turčin','VARAŽDINSKA',now(),now(),1),
#5319
('Sekirevo Selo',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5320
('Sekirišće',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5321
('Sekulići',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#5322
('Sekulinci',33522,'Voćin','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5323
('Sela',44273,'Sela','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5324
('Sela Bosiljevska',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#5325
('Sela Ravenska',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5326
('Sela Žakanjska',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#5327
('Selakova Poljana',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#5328
('Selanec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5329
('Selca',52420,'Buzet','ISTARSKA',now(),now(),1),
#5330
('Selca',21425,'Selca','SPLITSKO-DALMATINSKA',now(),now(),1),
#5331
('Selca kod Bogomolja',21467,'Gdinj','SPLITSKO-DALMATINSKA',now(),now(),1),
#5332
('Selca kod Starog Grada',21460,'Stari Grad','SPLITSKO-DALMATINSKA',now(),now(),1),
#5333
('Selce',51266,'Selce','PRIMORSKO-GORANSKA',now(),now(),1),
#5334
('Selce Žumberačko',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#5335
('Selci',31222,'Bizovac','OSJEČKO-BARANJSKA',now(),now(),1),
#5336
('Selci Đakovački',31415,'Selci Đakovački','OSJEČKO-BARANJSKA',now(),now(),1),
#5337
('Selci Križovljanski',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#5338
('Selina',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#5339
('Seline',23244,'Starigrad Paklenica','ZADARSKA',now(),now(),1),
#5340
('Selišće Sunjsko',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5341
('Selište',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5342
('Selište Kostajničko',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5343
('Selna',35212,'Garčin','BRODSKO-POSAVSKA',now(),now(),1),
#5344
('Selnica',40314,'Selnica','MEĐIMURSKA',now(),now(),1),
#5345
('Selnica',49246,'Marija Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5346
('Selnica',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#5347
('Selnica Miholečka',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5348
('Selnica Podravska',48317,'Legrad','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5349
('Selnica Psarjevačka',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#5350
('Selnik',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#5351
('Selnik',42243,'Maruševec','VARAŽDINSKA',now(),now(),1),
#5352
('Selno',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5353
('Selo',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#5354
('Selsko Brdo',10451,'Pisarovina','ZAGREBAČKA',now(),now(),1),
#5355
('Seljaci',52420,'Buzet','ISTARSKA',now(),now(),1),
#5356
('Seljanec',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#5357
('Semeljci',31402,'Semeljci','OSJEČKO-BARANJSKA',now(),now(),1),
#5358
('Semičevići',51243,'Tribalj','PRIMORSKO-GORANSKA',now(),now(),1),
#5359
('Semić',52426,'Lupoglav','ISTARSKA',now(),now(),1),
#5360
('Senj',52420,'Buzet','ISTARSKA',now(),now(),1),
#5361
('Senj',53270,'Senj','LIČKO-SENJSKA',now(),now(),1),
#5362
('Senjska Draga',53270,'Senj','LIČKO-SENJSKA',now(),now(),1),
#5363
('Seoca',21254,'Blato na Cetini','SPLITSKO-DALMATINSKA',now(),now(),1),
#5364
('Seoce',35410,'Nova Kapela','BRODSKO-POSAVSKA',now(),now(),1),
#5365
('Seoci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5366
('Seočani',47313,'Drežnica','KARLOVAČKA',now(),now(),1),
#5367
('Seona',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#5368
('Sertić Poljana',53231,'Plitvička Jezera','LIČKO-SENJSKA',now(),now(),1),
#5369
('Sestrunj',23291,'Sestrunj','ZADARSKA',now(),now(),1),
#5370
('Sesvete',34312,'Sesvete (kod Požege)','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5371
('Sesvete',10360,'Sesvete','GRAD ZAGREB',now(),now(),1),
#5372
('Sesvete Ludbreške',42233,'Sveti Đurđ','VARAŽDINSKA',now(),now(),1),
#5373
('Sesvetski Kraljevec',10361,'Sesvete-Kraljevec','GRAD ZAGREB',now(),now(),1),
#5374
('Setuš',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5375
('Severin',43274,'Severin','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5376
('Severin na Kupi',51329,'Severin na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#5377
('Severovci',48350,'Đurđevac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5378
('Sevid',21222,'Marina','SPLITSKO-DALMATINSKA',now(),now(),1),
#5379
('Sibenik',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5380
('Sibić',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5381
('Sibinj',35252,'Sibinj','BRODSKO-POSAVSKA',now(),now(),1),
#5382
('Sibinj Krmpotski',51252,'Klenovica','PRIMORSKO-GORANSKA',now(),now(),1),
#5383
('Sibokovac',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5384
('Siča',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#5385
('Sičane',21232,'Dicmo','SPLITSKO-DALMATINSKA',now(),now(),1),
#5386
('Sičice',35423,'Vrbje','BRODSKO-POSAVSKA',now(),now(),1),
#5387
('Siće',35410,'Nova Kapela','BRODSKO-POSAVSKA',now(),now(),1),
#5388
('Sigetac Novski',44330,'Novska','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5389
('Sigetec',48321,'Peteranec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5390
('Sigetec Ludbreški',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#5391
('Sikirevci',35224,'Sikirevci','BRODSKO-POSAVSKA',now(),now(),1),
#5392
('Sikovo',23207,'Sveti Filip i Jakov','ZADARSKA',now(),now(),1),
#5393
('Silaš',31214,'Laslovo (Szentl&#225;szl&#243;)','OSJEČKO-BARANJSKA',now(),now(),1),
#5394
('Silba',23295,'Silba','ZADARSKA',now(),now(),1),
#5395
('Sinac',53224,'Ličko Lešće','LIČKO-SENJSKA',now(),now(),1),
#5396
('Sinlije',35404,'Cernik','BRODSKO-POSAVSKA',now(),now(),1),
#5397
('Sinožići',52445,'Baderna','ISTARSKA',now(),now(),1),
#5398
('Sinj',21230,'Sinj','SPLITSKO-DALMATINSKA',now(),now(),1),
#5399
('Sirač',43541,'Sirač','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5400
('Sirotići',52420,'Buzet','ISTARSKA',now(),now(),1),
#5401
('Sirova Katalena',48350,'Đurđevac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5402
('Sisak',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5403
('Sisak-Caprag',44010,'Sisak-Caprag','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5404
('Siščani',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5405
('Sitno Donje',22205,'Perković','ŠIBENSKO-KNINSKA',now(),now(),1),
#5406
('Siverić',22321,'Siverić','ŠIBENSKO-KNINSKA',now(),now(),1),
#5407
('Sivica',40317,'Podturen','MEĐIMURSKA',now(),now(),1),
#5408
('Sječevac',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#5409
('Sjeničak Lasinjski',47212,'Skakavac','KARLOVAČKA',now(),now(),1),
#5410
('Sjeverovac',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5411
('Skakavac',47212,'Skakavac','KARLOVAČKA',now(),now(),1),
#5412
('Skela',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5413
('Skenderovci',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5414
('Skenderovci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5415
('Skitača',52222,'Koromačno','ISTARSKA',now(),now(),1),
#5416
('Skoblić Brdo',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#5417
('Skrad',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#5418
('Skradin',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#5419
('Skradinsko Polje',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#5420
('Skradnik',47302,'Oštarije','KARLOVAČKA',now(),now(),1),
#5421
('Skradsko Selo',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#5422
('Skrbčići',51500,'Krk','PRIMORSKO-GORANSKA',now(),now(),1),
#5423
('Skrivena Luka',20290,'Lastovo','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5424
('Skukani',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#5425
('Skupica',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#5426
('Slabinja',44450,'Hrvatska Dubica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5427
('Sladojevački Lug',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5428
('Sladojevci',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5429
('Slakovci',32242,'Slakovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#5430
('Slakovec',40305,'Nedelišće','MEĐIMURSKA',now(),now(),1),
#5431
('Slana',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5432
('Slani Dol',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#5433
('Slani Potok',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5434
('Slano',20232,'Slano','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5435
('Slanje',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#5436
('Slapnica',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#5437
('Slapno',47281,'Mali Erjavec','KARLOVAČKA',now(),now(),1),
#5438
('Slatina',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#5439
('Slatina',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5440
('Slatina',23234,'Vir','ZADARSKA',now(),now(),1),
#5441
('Slatina Pokupska',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5442
('Slatina Svedruška',49234,'Petrovsko','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5443
('Slatine',21224,'Slatine','SPLITSKO-DALMATINSKA',now(),now(),1),
#5444
('Slatinik Drenjski',31418,'Drenje','OSJEČKO-BARANJSKA',now(),now(),1),
#5445
('Slatinski Drenovac',33514,'Čačinci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5446
('Slavagora',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#5447
('Slavetić',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#5448
('Slavica',51322,'Fužine','PRIMORSKO-GORANSKA',now(),now(),1),
#5449
('Slavonske Bare',33513,'Zdenci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5450
('Slavonski Brod',35000,'Slavonski Brod','BRODSKO-POSAVSKA',now(),now(),1),
#5451
('Slavonski Kobaš',35255,'Slavonski Kobaš','BRODSKO-POSAVSKA',now(),now(),1),
#5452
('Slavonski Šamac',35220,'Slavonski Šamac','BRODSKO-POSAVSKA',now(),now(),1),
#5453
('Slavsko Polje',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5454
('Sleme Skradsko',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#5455
('Slemenice',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#5456
('Slime',21255,'Zadvarje','SPLITSKO-DALMATINSKA',now(),now(),1),
#5457
('Slivarsko',42245,'Donja Voća','VARAŽDINSKA',now(),now(),1),
#5458
('Slivnica',23247,'Vinjerac','ZADARSKA',now(),now(),1),
#5459
('Slivno',21272,'Slivno','SPLITSKO-DALMATINSKA',now(),now(),1),
#5460
('Slivno',22205,'Perković','ŠIBENSKO-KNINSKA',now(),now(),1),
#5461
('Slivno Ravno',20356,'Klek','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5462
('Slivonja Jarek',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5463
('Slobodna Vlast',31416,'Levanjska Varoš','OSJEČKO-BARANJSKA',now(),now(),1),
#5464
('Slobodnica',35252,'Sibinj','BRODSKO-POSAVSKA',now(),now(),1),
#5465
('Sloboština',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5466
('Slokovec',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#5467
('Slovinci',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5468
('Slovinska Kovačica',43272,'Nova Rača','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5469
('Slum',52420,'Buzet','ISTARSKA',now(),now(),1),
#5470
('Slunj',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#5471
('Slunjska Selnica',47212,'Skakavac','KARLOVAČKA',now(),now(),1),
#5472
('Slunjski Moravci',47241,'Cerovac Vukmanički','KARLOVAČKA',now(),now(),1),
#5473
('Slušnica',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#5474
('Sljeme',10000,'Zagreb','GRAD ZAGREB',now(),now(),1),
#5475
('Sljeme',51322,'Fužine','PRIMORSKO-GORANSKA',now(),now(),1),
#5476
('Smerovišće',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#5477
('Smilčić',23420,'Benkovac','ZADARSKA',now(),now(),1),
#5478
('Smiljan',53211,'Smiljan','LIČKO-SENJSKA',now(),now(),1),
#5479
('Smiljansko Polje',53211,'Smiljan','LIČKO-SENJSKA',now(),now(),1),
#5480
('Smišljak',51329,'Severin na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#5481
('Smišljak',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#5482
('Smoković',23222,'Zemunik','ZADARSKA',now(),now(),1),
#5483
('Smokovljani',20231,'Doli','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5484
('Smokovo',51264,'Jadranovo','PRIMORSKO-GORANSKA',now(),now(),1),
#5485
('Smokrić',53244,'Lovinac','LIČKO-SENJSKA',now(),now(),1),
#5486
('Smokvica',20272,'Smokvica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5487
('Smokvica',23249,'Povljana','ZADARSKA',now(),now(),1),
#5488
('Smokvica Krmpotska',51252,'Klenovica','PRIMORSKO-GORANSKA',now(),now(),1),
#5489
('Smokvina',20231,'Doli','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5490
('Smolići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#5491
('Smolonje',21253,'Gata','SPLITSKO-DALMATINSKA',now(),now(),1),
#5492
('Smoljanac',53231,'Plitvička Jezera','LIČKO-SENJSKA',now(),now(),1),
#5493
('Smoljanci',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#5494
('Smoljanovci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5495
('Smrdelje',22305,'Kistanje','ŠIBENSKO-KNINSKA',now(),now(),1),
#5496
('Smrečje',51304,'Gerovo','PRIMORSKO-GORANSKA',now(),now(),1),
#5497
('Smrekari',51303,'Plešce','PRIMORSKO-GORANSKA',now(),now(),1),
#5498
('Smrtić',35429,'Gornji Bogićevci','BRODSKO-POSAVSKA',now(),now(),1),
#5499
('Smude',33522,'Voćin','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5500
('Snašići',52220,'Labin','ISTARSKA',now(),now(),1),
#5501
('Snos',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#5502
('Soblinec',10360,'Sesvete','GRAD ZAGREB',now(),now(),1),
#5503
('Sobočani',10312,'Kloštar Ivanić','ZAGREBAČKA',now(),now(),1),
#5504
('Soboli',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#5505
('Sobra',20225,'Babino Polje','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5506
('Sočanica',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5507
('Sokoli',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#5508
('Sokolovac',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5509
('Sokolovac',31309,'Kneževi Vinogradi','OSJEČKO-BARANJSKA',now(),now(),1),
#5510
('Sokolovac',43506,'Dežanovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5511
('Soldatići',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#5512
('Solin',21210,'Solin','SPLITSKO-DALMATINSKA',now(),now(),1),
#5513
('Soline',20226,'Goveđari','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5514
('Soline',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5515
('Soline',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#5516
('Soline',51514,'Dobrinj','PRIMORSKO-GORANSKA',now(),now(),1),
#5517
('Soline',23287,'Veli Rat','ZADARSKA',now(),now(),1),
#5518
('Soljani',32255,'Soljani','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#5519
('Sonković',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#5520
('Sop',10361,'Sesvete-Kraljevec','GRAD ZAGREB',now(),now(),1),
#5521
('Sop Bukevski',10411,'Orle','ZAGREBAČKA',now(),now(),1),
#5522
('Sopač',51316,'Lokve','PRIMORSKO-GORANSKA',now(),now(),1),
#5523
('Sopaljska',51260,'Crikvenica','PRIMORSKO-GORANSKA',now(),now(),1),
#5524
('Sopčić Vrh',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#5525
('Sopjanska Greda',33525,'Sopje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5526
('Sopje',33525,'Sopje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5527
('Sopot',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5528
('Sopote',10457,'Sošice','ZAGREBAČKA',now(),now(),1),
#5529
('Sošice',10457,'Sošice','ZAGREBAČKA',now(),now(),1),
#5530
('Sošići',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#5531
('Sotin',32232,'Sotin','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#5532
('Sovari',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5533
('Sovinjak',52420,'Buzet','ISTARSKA',now(),now(),1),
#5534
('Sovinjska Brda',52420,'Buzet','ISTARSKA',now(),now(),1),
#5535
('Sovinjsko Polje',52420,'Buzet','ISTARSKA',now(),now(),1),
#5536
('Sovjak',33410,'Suhopolje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5537
('Sovski Dol',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5538
('Spahići',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#5539
('Sparagovići',20230,'Ston','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5540
('Sparednjak',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#5541
('Spinčići',51215,'Kastav','PRIMORSKO-GORANSKA',now(),now(),1),
#5542
('Split',21000,'Split','SPLITSKO-DALMATINSKA',now(),now(),1),
#5543
('Splitska',21410,'Postira','SPLITSKO-DALMATINSKA',now(),now(),1),
#5544
('Sračak',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#5545
('Sračinec',42209,'Sračinec','VARAŽDINSKA',now(),now(),1),
#5546
('Srb (Gornji i Donji)',23445,'Srb','ZADARSKA',now(),now(),1),
#5547
('Srdinac',48325,'Novigrad Podravski','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5548
('Srebreno',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5549
('Srebrenjak',10431,'Sveta Nedjelja','ZAGREBAČKA',now(),now(),1),
#5550
('Srebrnići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#5551
('Sredanci',35214,'Donji Andrijevci','BRODSKO-POSAVSKA',now(),now(),1),
#5552
('Sredice Gornje',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5553
('Srednja Diklenica',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5554
('Srednja Draga',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#5555
('Srednja Gora',53234,'Udbina','LIČKO-SENJSKA',now(),now(),1),
#5556
('Srednja Krašićevica',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#5557
('Srednja Meminska',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5558
('Srednja Velika',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#5559
('Srednjak',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#5560
('Srednje Mokrice',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5561
('Srednje Prilišće',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#5562
('Srednje Selo',21430,'Grohote','SPLITSKO-DALMATINSKA',now(),now(),1),
#5563
('Srednje Selo',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#5564
('Srednje Selo',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5565
('Srednji Borki',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5566
('Srednji Dubovec',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5567
('Srednji Grahovljani',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5568
('Srednji Lipovac',35410,'Nova Kapela','BRODSKO-POSAVSKA',now(),now(),1),
#5569
('Srednji Mosti',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5570
('Srednji Poloj',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#5571
('Sreser',20246,'Janjina','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5572
('Srijane',21205,'Donji Dolac','SPLITSKO-DALMATINSKA',now(),now(),1),
#5573
('Srijedska',43231,'Ivanska','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5574
('Srijem',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5575
('Srijemske Laze',32242,'Slakovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#5576
('Srima',22211,'Vodice','ŠIBENSKO-KNINSKA',now(),now(),1),
#5577
('Srinjine',21292,'Srinjine','SPLITSKO-DALMATINSKA',now(),now(),1),
#5578
('Sroki',51216,'Viškovo','PRIMORSKO-GORANSKA',now(),now(),1),
#5579
('Sršići',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#5580
('Sršići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#5581
('Stabanj',23423,'Polača','ZADARSKA',now(),now(),1),
#5582
('Stajnica',53262,'Jezerane','LIČKO-SENJSKA',now(),now(),1),
#5583
('Stančić',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#5584
('Stančići',43252,'Prgomelje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5585
('Stanetinec',40312,'Štrigova','MEĐIMURSKA',now(),now(),1),
#5586
('Stanica Roč',52425,'Roč','ISTARSKA',now(),now(),1),
#5587
('Staničići Žumberački',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#5588
('Stanić',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#5589
('Stanić Polje',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5590
('Stanići',21310,'Omiš','SPLITSKO-DALMATINSKA',now(),now(),1),
#5591
('Stanići',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5592
('Stanići kod Nove Vasi',52446,'Nova Vas','ISTARSKA',now(),now(),1),
#5593
('Staniši',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#5594
('Stanišovi',52222,'Koromačno','ISTARSKA',now(),now(),1),
#5595
('Staništa',53288,'Karlobag','LIČKO-SENJSKA',now(),now(),1),
#5596
('Stankovac',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5597
('Stankovci',23422,'Stankovci','ZADARSKA',now(),now(),1),
#5598
('Stankovci',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#5599
('Stanković',20250,'Orebić','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5600
('Stankovo',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#5601
('Stara Baška',51521,'Punat','PRIMORSKO-GORANSKA',now(),now(),1),
#5602
('Stara Diklenica',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5603
('Stara Drenčina',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5604
('Stara Gradiška',35435,'Stara Gradiška','BRODSKO-POSAVSKA',now(),now(),1),
#5605
('Stara Jošava',33515,'Orahovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5606
('Stara Kapela',35410,'Nova Kapela','BRODSKO-POSAVSKA',now(),now(),1),
#5607
('Stara Kapela',10343,'Nova Kapela','ZAGREBAČKA',now(),now(),1),
#5608
('Stara Krivaja',43532,'Đulovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5609
('Stara Kršlja',47245,'Rakovica','KARLOVAČKA',now(),now(),1),
#5610
('Stara Lipa',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5611
('Stara Ljeskovica',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5612
('Stara Marča',10312,'Kloštar Ivanić','ZAGREBAČKA',now(),now(),1),
#5613
('Stara Novalja',53291,'Novalja','LIČKO-SENJSKA',now(),now(),1),
#5614
('Stara Ploščica',43232,'Berek','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5615
('Stara Rača',43272,'Nova Rača','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5616
('Stara Subocka',44330,'Novska','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5617
('Stara Sušica',51314,'Ravna Gora','PRIMORSKO-GORANSKA',now(),now(),1),
#5618
('Stara Vas',23249,'Povljana','ZADARSKA',now(),now(),1),
#5619
('Stara Ves Košnička',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5620
('Stara Ves Petrovska',49234,'Petrovsko','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5621
('Stara Ves Ravenska',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5622
('Starci',35420,'Staro Petrovo Selo','BRODSKO-POSAVSKA',now(),now(),1),
#5623
('Starčevljani',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5624
('Stari Bošnjani',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5625
('Stari Brod',44273,'Sela','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5626
('Stari Farkašić',44273,'Sela','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5627
('Stari Glog',10343,'Nova Kapela','ZAGREBAČKA',now(),now(),1),
#5628
('Stari Golubovec',49253,'Lobor','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5629
('Stari Grabovac',44330,'Novska','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5630
('Stari Grad',21460,'Stari Grad','SPLITSKO-DALMATINSKA',now(),now(),1),
#5631
('Stari Grad Žumberački',10457,'Sošice','ZAGREBAČKA',now(),now(),1),
#5632
('Stari Gradac',33405,'Pitomača','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5633
('Stari Jankovci',32241,'Stari Jankovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#5634
('Stari Laz',51314,'Ravna Gora','PRIMORSKO-GORANSKA',now(),now(),1),
#5635
('Stari Lazi',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#5636
('Stari Majur',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5637
('Stari Mikanovci',32284,'Stari Mikanovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#5638
('Stari Pavljani',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5639
('Stari Perkovci',35210,'Vrpolje','BRODSKO-POSAVSKA',now(),now(),1),
#5640
('Stari Skucani',43203,'Kapela','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5641
('Stari Slatnik',35253,'Brodski Stupnik','BRODSKO-POSAVSKA',now(),now(),1),
#5642
('Stari Zdenkovac',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5643
('Starići',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#5644
('Starigrad',53284,'Sveti Juraj','LIČKO-SENJSKA',now(),now(),1),
#5645
('Starigrad',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5646
('Starigrad',23244,'Starigrad Paklenica','ZADARSKA',now(),now(),1),
#5647
('Starin',33523,'Čađavica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5648
('Starine',43246,'Štefanje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5649
('Starjak',10257,'Brezovica','GRAD ZAGREB',now(),now(),1),
#5650
('Staro Čiče',10419,'Vukovina','ZAGREBAČKA',now(),now(),1),
#5651
('Staro Petrovo Polje',33507,'Crnac','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5652
('Staro Petrovo Selo',35420,'Staro Petrovo Selo','BRODSKO-POSAVSKA',now(),now(),1),
#5653
('Staro Pračno',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5654
('Staro Selo',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5655
('Staro Selo',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#5656
('Staro Selo Topusko',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5657
('Staro Štefanje',43246,'Štefanje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5658
('Staro Topolje',35214,'Donji Andrijevci','BRODSKO-POSAVSKA',now(),now(),1),
#5659
('Starogradački Marof',33405,'Pitomača','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5660
('Staševica',20345,'Staševica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5661
('Staza',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5662
('Stažnjevec',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#5663
('Stepčići',52234,'Plomin','ISTARSKA',now(),now(),1),
#5664
('Stilja',21276,'Vrgorac','SPLITSKO-DALMATINSKA',now(),now(),1),
#5665
('Stinica',53287,'Jablanac','LIČKO-SENJSKA',now(),now(),1),
#5666
('Stipan',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5667
('Stipanovci',31433,'Podgorač','OSJEČKO-BARANJSKA',now(),now(),1),
#5668
('Stipernica',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5669
('Stobreč',21311,'Stobreč','SPLITSKO-DALMATINSKA',now(),now(),1),
#5670
('Stojavnica',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#5671
('Stojčinovac',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5672
('Stojdraga',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#5673
('Stojmerić',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#5674
('Stolac',53270,'Senj','LIČKO-SENJSKA',now(),now(),1),
#5675
('Stomorska',21432,'Stomorska','SPLITSKO-DALMATINSKA',now(),now(),1),
#5676
('Ston',20230,'Ston','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5677
('Stončica',21480,'Vis','SPLITSKO-DALMATINSKA',now(),now(),1),
#5678
('Strahinje',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5679
('Strahinje Radobojsko',49232,'Radoboj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5680
('Strahoninec',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#5681
('Strana',52420,'Buzet','ISTARSKA',now(),now(),1),
#5682
('Stranići kod Svetog Lovreča',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#5683
('Strašnik',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5684
('Stravča',20210,'Cavtat','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5685
('Straža',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#5686
('Straža Krapinska',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5687
('Stražanac',43505,'Končanica (Končenice)','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5688
('Stražbenica',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5689
('Stražeman',34330,'Velika','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5690
('Strelec',40321,'Mala Subotica','MEĐIMURSKA',now(),now(),1),
#5691
('Strelečko',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5692
('Strezojevo',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#5693
('Strgari',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#5694
('Striježevica',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5695
('Strilčići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#5696
('Strizirep',21245,'Tijarica','SPLITSKO-DALMATINSKA',now(),now(),1),
#5697
('Strizivojna',31410,'Strizivojna','OSJEČKO-BARANJSKA',now(),now(),1),
#5698
('Strižičevac',34543,'Poljana','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5699
('Strmačka',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#5700
('Strmec',10020,'Zagreb-Novi Zagreb','GRAD ZAGREB',now(),now(),1),
#5701
('Strmec',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#5702
('Strmec',49214,'Veliko Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5703
('Strmec Bukevski',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#5704
('Strmec Humski',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5705
('Strmec Podravski',42206,'Petrijanec','VARAŽDINSKA',now(),now(),1),
#5706
('Strmec Pribićki',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#5707
('Strmec Remetinečki',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#5708
('Strmec Samoborski',10434,'Strmec Samoborski','ZAGREBAČKA',now(),now(),1),
#5709
('Strmec Stubički',49244,'Stubičke Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5710
('Strmec Sutlanski',49294,'Kraljevec na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5711
('Strmen',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5712
('Strmendolac',21240,'Trilj','SPLITSKO-DALMATINSKA',now(),now(),1),
#5713
('Strmica',22301,'Golubić','ŠIBENSKO-KNINSKA',now(),now(),1),
#5714
('Strošinci',32256,'Strošinci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#5715
('Strpančići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#5716
('Struga',42233,'Sveti Đurđ','VARAŽDINSKA',now(),now(),1),
#5717
('Struga Banska',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5718
('Struga Nartska',10361,'Sesvete-Kraljevec','GRAD ZAGREB',now(),now(),1),
#5719
('Stružani',35213,'Oprisavci','BRODSKO-POSAVSKA',now(),now(),1),
#5720
('Stružec',44317,'Popovača','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5721
('Stružec Posavski',10411,'Orle','ZAGREBAČKA',now(),now(),1),
#5722
('Stubalj',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5723
('Stubica',51326,'Vrbovsko','PRIMORSKO-GORANSKA',now(),now(),1),
#5724
('Stubička Slatina',49243,'Oroslavje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5725
('Stubičke Toplice',49244,'Stubičke Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5726
('Studena',51217,'Klana','PRIMORSKO-GORANSKA',now(),now(),1),
#5727
('Studenci',53202,'Perušić','LIČKO-SENJSKA',now(),now(),1),
#5728
('Studenci',21265,'Studenci','SPLITSKO-DALMATINSKA',now(),now(),1),
#5729
('Stupa',20205,'Topolo','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5730
('Stupe',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#5731
('Stupnički Kuti',35254,'Bebrina','BRODSKO-POSAVSKA',now(),now(),1),
#5732
('Stupno',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5733
('Stupovača',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5734
('Subocka',34551,'Lipik','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5735
('Subotica Podravska',48311,'Kunovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5736
('Sučići',51417,'Mošćenička Draga','PRIMORSKO-GORANSKA',now(),now(),1),
#5737
('Sućuraj',21469,'Sućuraj','SPLITSKO-DALMATINSKA',now(),now(),1),
#5738
('Sudaraž',31300,'Beli Manastir','OSJEČKO-BARANJSKA',now(),now(),1),
#5739
('Sudovčina',42232,'Donji Martijanec','VARAŽDINSKA',now(),now(),1),
#5740
('Sudovec',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5741
('Suđurađ',20223,'Šipanjska Luka','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5742
('Suha Katalena',48362,'Kloštar Podravski','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5743
('Suha Mlaka',33507,'Crnac','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5744
('Suhač',21230,'Sinj','SPLITSKO-DALMATINSKA',now(),now(),1),
#5745
('Suhaja',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5746
('Suhodol Budački',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#5747
('Suhodol Zelinski',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#5748
('Suhopolje',33410,'Suhopolje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5749
('Suhor',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#5750
('Suhovare',23241,'Poličnik','ZADARSKA',now(),now(),1),
#5751
('Suknovci',22303,'Oklaj','ŠIBENSKO-KNINSKA',now(),now(),1),
#5752
('Sukošan',23206,'Sukošan','ZADARSKA',now(),now(),1),
#5753
('Sulkovci',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5754
('Sumartin',21425,'Selca','SPLITSKO-DALMATINSKA',now(),now(),1),
#5755
('Sunger',51315,'Mrkopalj','PRIMORSKO-GORANSKA',now(),now(),1),
#5756
('Sunja',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5757
('Supetar',21400,'Supetar','SPLITSKO-DALMATINSKA',now(),now(),1),
#5758
('Supetarska Draga',51280,'Rab','PRIMORSKO-GORANSKA',now(),now(),1),
#5759
('Susak',51561,'Susak','PRIMORSKO-GORANSKA',now(),now(),1),
#5760
('Sustjepan',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5761
('Suša',10411,'Orle','ZAGREBAČKA',now(),now(),1),
#5762
('Sušac',20290,'Lastovo','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5763
('Sušanj Cesarički',53288,'Karlobag','LIČKO-SENJSKA',now(),now(),1),
#5764
('Sušci',21232,'Dicmo','SPLITSKO-DALMATINSKA',now(),now(),1),
#5765
('Sušići',52425,'Roč','ISTARSKA',now(),now(),1),
#5766
('Sušik',51243,'Tribalj','PRIMORSKO-GORANSKA',now(),now(),1),
#5767
('Sušine',31511,'Đurđenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#5768
('Sušobreg donji 1-96,141-dalje',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5769
('Sutina',21247,'Neorić','SPLITSKO-DALMATINSKA',now(),now(),1),
#5770
('Sutinske Toplice',49251,'Mače','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5771
('Sutivan',21403,'Sutivan','SPLITSKO-DALMATINSKA',now(),now(),1),
#5772
('Sutomišćica',23273,'Preko','ZADARSKA',now(),now(),1),
#5773
('Suvaja',23445,'Srb','ZADARSKA',now(),now(),1),
#5774
('Suvoj',44203,'Gušće','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5775
('Suza',31308,'Suza (Cs&#250;za)','OSJEČKO-BARANJSKA',now(),now(),1),
#5776
('Sužan',51514,'Dobrinj','PRIMORSKO-GORANSKA',now(),now(),1),
#5777
('Svedruža',49234,'Petrovsko','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5778
('Sveta Ana',48350,'Đurđevac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5779
('Sveta Helena',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5780
('Sveta Helena',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#5781
('Sveta Jelena',51418,'Brseč','PRIMORSKO-GORANSKA',now(),now(),1),
#5782
('Sveta Katarina',52332,'Pićan','ISTARSKA',now(),now(),1),
#5783
('Sveta Lucija',52428,'Oprtalj (Portole)','ISTARSKA',now(),now(),1),
#5784
('Sveta Marija',23250,'Pag','ZADARSKA',now(),now(),1),
#5785
('Sveta Marija',40326,'Sveta Marija','MEĐIMURSKA',now(),now(),1),
#5786
('Sveta Marija na Krasu',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#5787
('Sveta Marina',52220,'Labin','ISTARSKA',now(),now(),1),
#5788
('Sveta Nedjelja',10431,'Sveta Nedjelja','ZAGREBAČKA',now(),now(),1),
#5789
('Sveta Nedjelja',21465,'Jelsa','SPLITSKO-DALMATINSKA',now(),now(),1),
#5790
('Sveti Andrija',21485,'Komiža','SPLITSKO-DALMATINSKA',now(),now(),1),
#5791
('Sveti Anton',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#5792
('Sveti Anton',51417,'Mošćenička Draga','PRIMORSKO-GORANSKA',now(),now(),1),
#5793
('Sveti Bartol',52424,'Motovun (Montana)','ISTARSKA',now(),now(),1),
#5794
('Sveti Bartul',52220,'Labin','ISTARSKA',now(),now(),1),
#5795
('Sveti Donat',52420,'Buzet','ISTARSKA',now(),now(),1),
#5796
('Sveti Đurađ',31552,'Podgajci Podravski','OSJEČKO-BARANJSKA',now(),now(),1),
#5797
('Sveti Đurađ',33000,'Virovitica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5798
('Sveti Đurđ',42233,'Sveti Đurđ','VARAŽDINSKA',now(),now(),1),
#5799
('Sveti Filip i Jakov',23207,'Sveti Filip i Jakov','ZADARSKA',now(),now(),1),
#5800
('Sveti Ilija',42214,'Sveti Ilija','VARAŽDINSKA',now(),now(),1),
#5801
('Sveti Ivan',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#5802
('Sveti Ivan',52420,'Buzet','ISTARSKA',now(),now(),1),
#5803
('Sveti Ivan',52428,'Oprtalj (Portole)','ISTARSKA',now(),now(),1),
#5804
('Sveti Ivan',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#5805
('Sveti Ivan Dobrinjski',51514,'Dobrinj','PRIMORSKO-GORANSKA',now(),now(),1),
#5806
('Sveti Ivan Zelina',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#5807
('Sveti Ivan Žabno',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5808
('Sveti Jakov',51554,'Nerezine','PRIMORSKO-GORANSKA',now(),now(),1),
#5809
('Sveti Juraj',53284,'Sveti Juraj','LIČKO-SENJSKA',now(),now(),1),
#5810
('Sveti Juraj u Trnju',40323,'Prelog','MEĐIMURSKA',now(),now(),1),
#5811
('Sveti Križ',40321,'Mala Subotica','MEĐIMURSKA',now(),now(),1),
#5812
('Sveti Križ',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5813
('Sveti Križ',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5814
('Sveti Križ Začretje',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5815
('Sveti Lovreč',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#5816
('Sveti Marko',53202,'Perušić','LIČKO-SENJSKA',now(),now(),1),
#5817
('Sveti Marko',23250,'Pag','ZADARSKA',now(),now(),1),
#5818
('Sveti Martin',52231,'Nedešćina','ISTARSKA',now(),now(),1),
#5819
('Sveti Martin',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5820
('Sveti Martin',21312,'Podstrana','SPLITSKO-DALMATINSKA',now(),now(),1),
#5821
('Sveti Martin na Muri',40313,'Sveti Martin na Muri','MEĐIMURSKA',now(),now(),1),
#5822
('Sveti Martin pod Okićem',10435,'Sveti Martin pod Okićem','ZAGREBAČKA',now(),now(),1),
#5823
('Sveti Matej',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5824
('Sveti Mikula',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#5825
('Sveti Petar',51417,'Mošćenička Draga','PRIMORSKO-GORANSKA',now(),now(),1),
#5826
('Sveti Petar',51559,'Beli','PRIMORSKO-GORANSKA',now(),now(),1),
#5827
('Sveti Petar',23207,'Sveti Filip i Jakov','ZADARSKA',now(),now(),1),
#5828
('Sveti Petar Čvrstec',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5829
('Sveti Petar Čvrstec (1 zaselak)',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5830
('Sveti Petar Čvrstec (tri zaselka)',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5831
('Sveti Petar Ludbreški',42231,'Mali Bukovec','VARAŽDINSKA',now(),now(),1),
#5832
('Sveti Petar Mrežnički',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#5833
('Sveti Petar Orehovec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5834
('Sveti Petar u šumi',52404,'Sveti Petar u šumi','ISTARSKA',now(),now(),1),
#5835
('Sveti Rok',53244,'Lovinac','LIČKO-SENJSKA',now(),now(),1),
#5836
('Sveti Urban',40312,'Štrigova','MEĐIMURSKA',now(),now(),1),
#5837
('Sveti Vid',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#5838
('Sveti Vid Dobrinjski',51514,'Dobrinj','PRIMORSKO-GORANSKA',now(),now(),1),
#5839
('Sveti Vid Miholjice',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#5840
('Svetice',47281,'Mali Erjavec','KARLOVAČKA',now(),now(),1),
#5841
('Svetičko Hrašće',47281,'Mali Erjavec','KARLOVAČKA',now(),now(),1),
#5842
('Svetinja',34308,'Jakšić','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5843
('Svetoblažje',31411,'Trnava','OSJEČKO-BARANJSKA',now(),now(),1),
#5844
('Svetojurski Vrh',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5845
('Svetonedjeljski Breg',10431,'Sveta Nedjelja','ZAGREBAČKA',now(),now(),1),
#5846
('Svetvinčenat',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#5847
('Svib',21256,'Cista Provo','SPLITSKO-DALMATINSKA',now(),now(),1),
#5848
('Svibje',10361,'Sesvete-Kraljevec','GRAD ZAGREB',now(),now(),1),
#5849
('Svibovec',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#5850
('Svibovec Podravski',42209,'Sračinec','VARAŽDINSKA',now(),now(),1),
#5851
('Svilaj',35213,'Oprisavci','BRODSKO-POSAVSKA',now(),now(),1),
#5852
('Svilna',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5853
('Svinca',21222,'Marina','SPLITSKO-DALMATINSKA',now(),now(),1),
#5854
('Svinica Krstinjska',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#5855
('Svinišće',21208,'Kučiće','SPLITSKO-DALMATINSKA',now(),now(),1),
#5856
('Svinjarec',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#5857
('Svinjarevci',32242,'Slakovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#5858
('Svirče',21462,'Vrbanj','SPLITSKO-DALMATINSKA',now(),now(),1),
#5859
('Svojić',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#5860
('Svračica',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5861
('Svračkovo Selo',53236,'Podlapača','LIČKO-SENJSKA',now(),now(),1),
#5862
('Svrževo',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#5863
('Šag',31550,'Valpovo','OSJEČKO-BARANJSKA',now(),now(),1),
#5864
('Šagovina Cernička',35404,'Cernik','BRODSKO-POSAVSKA',now(),now(),1),
#5865
('Šagovina Mašička',35429,'Gornji Bogićevci','BRODSKO-POSAVSKA',now(),now(),1),
#5866
('Šagudovec',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5867
('Šajini',52207,'Barban','ISTARSKA',now(),now(),1),
#5868
('Šakanlije',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5869
('Šalamunić',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#5870
('Šalamunovec',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5871
('Šalovec',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#5872
('Šandorovec',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#5873
('Šandrovac',43227,'Šandrovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5874
('Šapjane',51214,'Šapjane','PRIMORSKO-GORANSKA',now(),now(),1),
#5875
('Šaptinovci',31511,'Đurđenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#5876
('Šarari',51244,'Grižane','PRIMORSKO-GORANSKA',now(),now(),1),
#5877
('Šarengrad',32234,'Šarengrad','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#5878
('Šarić Struga',20343,'Rogotin','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5879
('Šarići',52206,'Marčana','ISTARSKA',now(),now(),1),
#5880
('Šartovac',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5881
('Šaš',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5882
('Šaša',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#5883
('Šaševa',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5884
('Šaševo',33523,'Čađavica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5885
('Šašinovec',10360,'Sesvete','GRAD ZAGREB',now(),now(),1),
#5886
('Šatornja',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5887
('Ščepanje',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#5888
('Šćapovec',10312,'Kloštar Ivanić','ZAGREBAČKA',now(),now(),1),
#5889
('Šćitarjevo',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#5890
('Šćrbinec',49254,'Belec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5891
('Šćulac',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#5892
('Šćulci',52420,'Buzet','ISTARSKA',now(),now(),1),
#5893
('Šebreki',47286,'Mahično','KARLOVAČKA',now(),now(),1),
#5894
('Šećerana',31300,'Beli Manastir','OSJEČKO-BARANJSKA',now(),now(),1),
#5895
('Šeganovac',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#5896
('Šegestin',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5897
('Šegotići',52208,'Krnica','ISTARSKA',now(),now(),1),
#5898
('Šeketino Brdo',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#5899
('Šelovec',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#5900
('Šemovci',48350,'Đurđevac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5901
('Šemovec',42202,'Trnovec Bartolovečki','VARAŽDINSKA',now(),now(),1),
#5902
('Šemovec Breški',10310,'Ivanić-Grad','ZAGREBAČKA',now(),now(),1),
#5903
('Šenkovec',10292,'Šenkovec','ZAGREBAČKA',now(),now(),1),
#5904
('Šenkovec',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#5905
('Šeovci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5906
('Šeovica',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5907
('Šepci Podstenski',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#5908
('Šeraje',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#5909
('Šestak Brdo',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#5910
('Šestanovac',21250,'Šestanovac','SPLITSKO-DALMATINSKA',now(),now(),1),
#5911
('Ševalj',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#5912
('Šibenik',22000,'Šibenik','ŠIBENSKO-KNINSKA',now(),now(),1),
#5913
('Šibenik/dio-Zablaće/',22030,'Šibenik-Zablaće','ŠIBENSKO-KNINSKA',now(),now(),1),
#5914
('Šibice',10290,'Zaprešić','GRAD ZAGREB',now(),now(),1),
#5915
('Šibine',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5916
('Šibovac',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5917
('Šijanec',42205,'Vidovec','VARAŽDINSKA',now(),now(),1),
#5918
('Šije',51313,'Kupjak','PRIMORSKO-GORANSKA',now(),now(),1),
#5919
('Šilo',51515,'Šilo','PRIMORSKO-GORANSKA',now(),now(),1),
#5920
('Šiljakovina',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#5921
('Šilješki',20210,'Cavtat','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5922
('Šiljki',47285,'Radatovići','KARLOVAČKA',now(),now(),1),
#5923
('Šiljkovača',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#5924
('Šimatovo',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#5925
('Šimići',51242,'Drivenik','PRIMORSKO-GORANSKA',now(),now(),1),
#5926
('Šimljana',43232,'Berek','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5927
('Šimljanica',43232,'Berek','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5928
('Šimljanik',43233,'Trnovitički Popovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5929
('Šimraki',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#5930
('Šimunci',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5931
('Šimunčevec',10360,'Sesvete','GRAD ZAGREB',now(),now(),1),
#5932
('Šimuni',23251,'Kolan','ZADARSKA',now(),now(),1),
#5933
('Šinkovica Bednjanska',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#5934
('Šinkovica Šaška',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#5935
('Šipački Breg',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#5936
('Šipanjska Luka',20223,'Šipanjska Luka','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5937
('Šipki',49253,'Lobor','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5938
('Šiptari',43211,'Predavac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5939
('Širinci',35429,'Gornji Bogićevci','BRODSKO-POSAVSKA',now(),now(),1),
#5940
('Širine',31300,'Beli Manastir','OSJEČKO-BARANJSKA',now(),now(),1),
#5941
('Širinec',10314,'Križ','ZAGREBAČKA',now(),now(),1),
#5942
('Širitovci',22324,'Drinovci','ŠIBENSKO-KNINSKA',now(),now(),1),
#5943
('Široka Glavica',22203,'Rogoznica','ŠIBENSKO-KNINSKA',now(),now(),1),
#5944
('Široka Kula',53201,'Lički Osik','LIČKO-SENJSKA',now(),now(),1),
#5945
('Široka Rijeka',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#5946
('Široke',22204,'Široke','ŠIBENSKO-KNINSKA',now(),now(),1),
#5947
('Široko Polje',31403,'Vuka','OSJEČKO-BARANJSKA',now(),now(),1),
#5948
('Široko Selo',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5949
('Šišan',52204,'Ližnjan (Lisignano)','ISTARSKA',now(),now(),1),
#5950
('Šišinec',44273,'Sela','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5951
('Šiškovci',32272,'Cerna','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#5952
('Šišljavić',47204,'Šišljavić','KARLOVAČKA',now(),now(),1),
#5953
('Šivati',52341,'Žminj','ISTARSKA',now(),now(),1),
#5954
('Škabrnja',23223,'Škabrnja','ZADARSKA',now(),now(),1),
#5955
('Škalić Zagorski',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5956
('Škalnica',51217,'Klana','PRIMORSKO-GORANSKA',now(),now(),1),
#5957
('Škaljevica',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#5958
('Škare',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#5959
('Škarićevo',49224,'Lepajci','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5960
('Škarnik',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#5961
('Škodinovac',43531,'Veliki Bastaji','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5962
('Škopljak',52403,'Gračišće','ISTARSKA',now(),now(),1),
#5963
('Škrabutnik',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5964
('Škriljevec',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#5965
('Škrinjari',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5966
('Škrip',21410,'Postira','SPLITSKO-DALMATINSKA',now(),now(),1),
#5967
('Škrljevo',51223,'Škrljevo','PRIMORSKO-GORANSKA',now(),now(),1),
#5968
('Škropeti',52423,'Karojba','ISTARSKA',now(),now(),1),
#5969
('Škuljari',52420,'Buzet','ISTARSKA',now(),now(),1),
#5970
('Škvaransko',52222,'Koromačno','ISTARSKA',now(),now(),1),
#5971
('Šljivnjak',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#5972
('Šljivoševci',31542,'Magadenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#5973
('Šljivovac',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#5974
('Šmrika',51263,'Šmrika','PRIMORSKO-GORANSKA',now(),now(),1),
#5975
('Šnjegovići',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5976
('Šodići',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#5977
('Šodolovci',31215,'Ernestinovo','OSJEČKO-BARANJSKA',now(),now(),1),
#5978
('Šoići',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#5979
('Šopot',23420,'Benkovac','ZADARSKA',now(),now(),1),
#5980
('Šopron',48269,'Kalnik','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5981
('Šorgi',52428,'Oprtalj (Portole)','ISTARSKA',now(),now(),1),
#5982
('Šorići',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#5983
('Španat',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5984
('Španovica',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#5985
('Špehari',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#5986
('Špičkovina',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#5987
('Špigelski Breg',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#5988
('Špiranec',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5989
('Špišić Bukovica',33404,'Špišić Bukovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#5990
('Štaglinec',48000,'Koprivnica','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#5991
('Štakorovec',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#5992
('Štakorovica',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#5993
('Štale',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#5994
('Štedrica',20205,'Topolo','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#5995
('Štefanci',51328,'Lukovdol','PRIMORSKO-GORANSKA',now(),now(),1),
#5996
('Štefanec',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#5997
('Štefanec Bartolovečki',42202,'Trnovec Bartolovečki','VARAŽDINSKA',now(),now(),1),
#5998
('Štefanje',43246,'Štefanje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#5999
('Šterna',52428,'Oprtalj (Portole)','ISTARSKA',now(),now(),1),
#6000
('Štifanići',52445,'Baderna','ISTARSKA',now(),now(),1),
#6001
('Štikada',53244,'Lovinac','LIČKO-SENJSKA',now(),now(),1),
#6002
('Štikovo',22321,'Siverić','ŠIBENSKO-KNINSKA',now(),now(),1),
#6003
('Štirkovac',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#6004
('Štitar',32274,'Štitar','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#6005
('Štitnjak',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6006
('Štivan',51556,'Martinšćica','PRIMORSKO-GORANSKA',now(),now(),1),
#6007
('Štivica',35420,'Staro Petrovo Selo','BRODSKO-POSAVSKA',now(),now(),1),
#6008
('Štokovci',52342,'Svetvinčenat','ISTARSKA',now(),now(),1),
#6009
('Štrigova',40312,'Štrigova','MEĐIMURSKA',now(),now(),1),
#6010
('Štrigovec',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6011
('Štrmac',52220,'Labin','ISTARSKA',now(),now(),1),
#6012
('Štrped',52420,'Buzet','ISTARSKA',now(),now(),1),
#6013
('Štrucljevo',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6014
('Štrukovec',40314,'Selnica','MEĐIMURSKA',now(),now(),1),
#6015
('Štuparje',49234,'Petrovsko','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6016
('Štuti',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#6017
('Šulinec',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#6018
('Šumanovci',34308,'Jakšić','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6019
('Šumarina',31300,'Beli Manastir','OSJEČKO-BARANJSKA',now(),now(),1),
#6020
('Šumber',52231,'Nedešćina','ISTARSKA',now(),now(),1),
#6021
('Šumećani',10313,'Graberje Ivaničko','ZAGREBAČKA',now(),now(),1),
#6022
('Šumeće',35254,'Bebrina','BRODSKO-POSAVSKA',now(),now(),1),
#6023
('Šumeđe',33515,'Orahovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6024
('Šumet',21263,'Krivodol','SPLITSKO-DALMATINSKA',now(),now(),1),
#6025
('Šumet',20236,'Mokošica','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6026
('Šumetlica',35404,'Cernik','BRODSKO-POSAVSKA',now(),now(),1),
#6027
('Šupera',51260,'Crikvenica','PRIMORSKO-GORANSKA',now(),now(),1),
#6028
('Šuplja Lipa',43505,'Končanica (Končenice)','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6029
('Šurdovec',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#6030
('Šušelj Brijeg',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6031
('Šušica',23275,'Ugljan','ZADARSKA',now(),now(),1),
#6032
('Šušnjar I',23452,'Karin','ZADARSKA',now(),now(),1),
#6033
('Šušnjar II',23452,'Karin','ZADARSKA',now(),now(),1),
#6034
('Šušnjari',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6035
('Šušnjari',10314,'Križ','ZAGREBAČKA',now(),now(),1),
#6036
('Šušnjevci',35211,'Trnjani','BRODSKO-POSAVSKA',now(),now(),1),
#6037
('Šušnjevica',52233,'Šušnjevica','ISTARSKA',now(),now(),1),
#6038
('Šušnjići',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#6039
('Švajcarnica',31326,'Darda','OSJEČKO-BARANJSKA',now(),now(),1),
#6040
('Švaljkovec',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6041
('Švica',53220,'Otočac','LIČKO-SENJSKA',now(),now(),1),
#6042
('Švrakarica',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6043
('Taborište',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6044
('Tadini',52464,'Kaštelir (Castelliere)','ISTARSKA',now(),now(),1),
#6045
('Tanac',44324,'Jasenovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6046
('Tankaraca',20270,'Vela Luka','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6047
('Tar',52465,'Tar (Torre)','ISTARSKA',now(),now(),1),
#6048
('Tarno',10310,'Ivanić-Grad','ZAGREBAČKA',now(),now(),1),
#6049
('Tatar Varoš',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#6050
('Tatinica',20226,'Goveđari','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6051
('Tedrovec',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#6052
('Tekić',34308,'Jakšić','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6053
('Temovec',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6054
('Tenja',31207,'Tenja','OSJEČKO-BARANJSKA',now(),now(),1),
#6055
('Teodorovac',31511,'Đurđenovac','OSJEČKO-BARANJSKA',now(),now(),1),
#6056
('Tepljuh',22321,'Siverić','ŠIBENSKO-KNINSKA',now(),now(),1),
#6057
('Terezino Polje',33407,'Gornje Bazje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6058
('Tiborjanci',31554,'Gat','OSJEČKO-BARANJSKA',now(),now(),1),
#6059
('Tići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#6060
('Tihočaj',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#6061
('Tijarica',21245,'Tijarica','SPLITSKO-DALMATINSKA',now(),now(),1),
#6062
('Tikveš',31309,'Kneževi Vinogradi','OSJEČKO-BARANJSKA',now(),now(),1),
#6063
('Timarci',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6064
('Tinj',23423,'Polača','ZADARSKA',now(),now(),1),
#6065
('Tinjan',52444,'Tinjan','ISTARSKA',now(),now(),1),
#6066
('Tisanić Jarek',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6067
('Tisno',22240,'Tisno','ŠIBENSKO-KNINSKA',now(),now(),1),
#6068
('Tisovac',34553,'Bučje','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6069
('Tisovac',35420,'Staro Petrovo Selo','BRODSKO-POSAVSKA',now(),now(),1),
#6070
('Tisovac',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6071
('Tisovac Žumberački',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#6072
('Tišina Erdedska',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6073
('Tišina Kaptolska',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6074
('Tiškovac Lički',23445,'Srb','ZADARSKA',now(),now(),1),
#6075
('Tkalci',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6076
('Tkalec Breznički',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#6077
('Tkon',23212,'Tkon','ZADARSKA',now(),now(),1),
#6078
('Tociljevac',43272,'Nova Rača','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6079
('Točak',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#6080
('Točak Perjasički',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#6081
('Točionik',20231,'Doli','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6082
('Tolić',53236,'Podlapača','LIČKO-SENJSKA',now(),now(),1),
#6083
('Tomaš',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6084
('Tomašanci',31422,'Gorjani','OSJEČKO-BARANJSKA',now(),now(),1),
#6085
('Tomaševci',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#6086
('Tomaševec',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#6087
('Tomaševec',49290,'Klanjec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6088
('Tomaševec Biškupečki',42204,'Turčin','VARAŽDINSKA',now(),now(),1),
#6089
('Tomašica',43280,'Garešnica','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6090
('Tomašići',47262,'Generalski Stol','KARLOVAČKA',now(),now(),1),
#6091
('Tomašnica',47281,'Mali Erjavec','KARLOVAČKA',now(),now(),1),
#6092
('Tomica',35107,'Podvinje','BRODSKO-POSAVSKA',now(),now(),1),
#6093
('Tomići',47313,'Drežnica','KARLOVAČKA',now(),now(),1),
#6094
('Tomići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#6095
('Tomingaj',23440,'Gračac','ZADARSKA',now(),now(),1),
#6096
('Tominovac',34340,'Kutjevo','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6097
('Tomislavovac',20248,'Putniković','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6098
('Tomišići',52341,'Žminj','ISTARSKA',now(),now(),1),
#6099
('Tompojevci',32238,'Čakovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#6100
('Tončići',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#6101
('Topid',52220,'Labin','ISTARSKA',now(),now(),1),
#6102
('Toplice',10453,'Gorica Svetojanska','ZAGREBAČKA',now(),now(),1),
#6103
('Topličica',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6104
('Topličica',42220,'Novi Marof','VARAŽDINSKA',now(),now(),1),
#6105
('Topoline',31224,'Koška','OSJEČKO-BARANJSKA',now(),now(),1),
#6106
('Topolo',20205,'Topolo','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6107
('Topolovac',44202,'Topolovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6108
('Topolovec',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#6109
('Topolovec Pisarovinski',10451,'Pisarovina','ZAGREBAČKA',now(),now(),1),
#6110
('Topolovica',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#6111
('Topolovica',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6112
('Topolje',10316,'Lijevi Dubrovčak','ZAGREBAČKA',now(),now(),1),
#6113
('Topolje',31304,'Duboševica','OSJEČKO-BARANJSKA',now(),now(),1),
#6114
('Topusko',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6115
('Toranj',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6116
('Toranj',34330,'Velika','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6117
('Torčec',48322,'Drnje','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6118
('Tordinci',32214,'Tordinci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#6119
('Torjanci',31322,'Baranjsko Petrovo Selo','OSJEČKO-BARANJSKA',now(),now(),1),
#6120
('Torovi',23234,'Vir','ZADARSKA',now(),now(),1),
#6121
('Totovec',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#6122
('Tounj',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#6123
('Tovarnik',32249,'Tovarnik','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#6124
('Trakošćan',42254,'Trakošćan','VARAŽDINSKA',now(),now(),1),
#6125
('Trapari',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6126
('Trbounje',22320,'Drniš','ŠIBENSKO-KNINSKA',now(),now(),1),
#6127
('Trbovići',47313,'Drežnica','KARLOVAČKA',now(),now(),1),
#6128
('Trebež',44203,'Gušće','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6129
('Trebovec',10310,'Ivanić-Grad','ZAGREBAČKA',now(),now(),1),
#6130
('Treglava',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6131
('Trema',48214,'Sveti Ivan Žabno','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6132
('Tremušnjak',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6133
('Trenkovo',34330,'Velika','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6134
('Trepča',44410,'Gvozd','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6135
('Trešćerovac',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#6136
('Treštanovci',34308,'Jakšić','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6137
('Trg',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#6138
('Trget',52224,'Trget','ISTARSKA',now(),now(),1),
#6139
('Trgetari',52224,'Trget','ISTARSKA',now(),now(),1),
#6140
('Trgovi',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6141
('Trgovišće',49283,'Hraščina-Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6142
('Tri porte',20270,'Vela Luka','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6143
('Tribalj',51243,'Tribalj','PRIMORSKO-GORANSKA',now(),now(),1),
#6144
('Tribalj Gornji',51243,'Tribalj','PRIMORSKO-GORANSKA',now(),now(),1),
#6145
('Triban',52460,'Buje (Buie)','ISTARSKA',now(),now(),1),
#6146
('Tribanj',23245,'Tribanj','ZADARSKA',now(),now(),1),
#6147
('Tribežić',22202,'Primošten','ŠIBENSKO-KNINSKA',now(),now(),1),
#6148
('Tribulje',51514,'Dobrinj','PRIMORSKO-GORANSKA',now(),now(),1),
#6149
('Tribunj',22212,'Tribunj','ŠIBENSKO-KNINSKA',now(),now(),1),
#6150
('Trilj',21240,'Trilj','SPLITSKO-DALMATINSKA',now(),now(),1),
#6151
('Trinajstići',51215,'Kastav','PRIMORSKO-GORANSKA',now(),now(),1),
#6152
('Trn',20357,'Blace','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6153
('Trnakovac',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#6154
('Trnava',35429,'Gornji Bogićevci','BRODSKO-POSAVSKA',now(),now(),1),
#6155
('Trnava',31411,'Trnava','OSJEČKO-BARANJSKA',now(),now(),1),
#6156
('Trnava Cabunska',33412,'Cabuna','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6157
('Trnavac',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#6158
('Trnbusi',21254,'Blato na Cetini','SPLITSKO-DALMATINSKA',now(),now(),1),
#6159
('Trnova',20232,'Slano','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6160
('Trnovac',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#6161
('Trnovac',34330,'Velika','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6162
('Trnovac Glinski',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6163
('Trnovac Sokolovački',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6164
('Trnovec',40306,'Macinec','MEĐIMURSKA',now(),now(),1),
#6165
('Trnovec Bartolovečki',42202,'Trnovec Bartolovečki','VARAŽDINSKA',now(),now(),1),
#6166
('Trnovec Desinićki',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6167
('Trnovi',47222,'Cetingrad','KARLOVAČKA',now(),now(),1),
#6168
('Trnovica',20231,'Doli','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6169
('Trnovica',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#6170
('Trnovitički Popovac',43233,'Trnovitički Popovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6171
('Trnovo',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#6172
('Trnjani',35211,'Trnjani','BRODSKO-POSAVSKA',now(),now(),1),
#6173
('Trnjanski Kuti',35213,'Oprisavci','BRODSKO-POSAVSKA',now(),now(),1),
#6174
('Trnje',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#6175
('Trogir',21220,'Trogir','SPLITSKO-DALMATINSKA',now(),now(),1),
#6176
('Trojeglava',43506,'Dežanovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6177
('Trojstveni Markovac',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6178
('Trojvrh',47303,'Josipdol','KARLOVAČKA',now(),now(),1),
#6179
('Trolokve',21201,'Prgomet','SPLITSKO-DALMATINSKA',now(),now(),1),
#6180
('Trombal',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#6181
('Tropeti',51306,'Čabar','PRIMORSKO-GORANSKA',now(),now(),1),
#6182
('Trošmarija',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#6183
('Trpanj',20240,'Trpanj','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6184
('Trpinja',32224,'Trpinja','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#6185
('Trstenik',20245,'Trstenik','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6186
('Trstenik',52420,'Buzet','ISTARSKA',now(),now(),1),
#6187
('Trstenik Nartski',10361,'Sesvete-Kraljevec','GRAD ZAGREB',now(),now(),1),
#6188
('Trstenik Pušćanski',10299,'Marija Gorica','ZAGREBAČKA',now(),now(),1),
#6189
('Trsteno',20233,'Trsteno','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6190
('Trsteno',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6191
('Tršće',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#6192
('Trški Lazi',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#6193
('Trški Vrh',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6194
('Trtnik Glinski',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6195
('Trupinjak',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#6196
('Trviž',52000,'Pazin','ISTARSKA',now(),now(),1),
#6197
('Tržić',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#6198
('Tržić Primišljanski',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#6199
('Tržić Tounjski',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#6200
('Tučenik',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#6201
('Tučepi',21325,'Tučepi','SPLITSKO-DALMATINSKA',now(),now(),1),
#6202
('Tudorovica',20270,'Vela Luka','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6203
('Tugare',21252,'Tugare','SPLITSKO-DALMATINSKA',now(),now(),1),
#6204
('Tugonica',49246,'Marija Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6205
('Tuhelj',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6206
('Tuheljske Toplice',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6207
('Tuhovec',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#6208
('Tuk',43212,'Rovišće','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6209
('Tuk',51326,'Vrbovsko','PRIMORSKO-GORANSKA',now(),now(),1),
#6210
('Tuk Bjelopoljski',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#6211
('Tuk Mrkopaljski',51315,'Mrkopalj','PRIMORSKO-GORANSKA',now(),now(),1),
#6212
('Tuk Vojni',51315,'Mrkopalj','PRIMORSKO-GORANSKA',now(),now(),1),
#6213
('Tuliševica',51415,'Lovran','PRIMORSKO-GORANSKA',now(),now(),1),
#6214
('Tulnik',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6215
('Tupčina',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#6216
('Tupkovec',40312,'Štrigova','MEĐIMURSKA',now(),now(),1),
#6217
('Tupljak',52333,'Podpićan','ISTARSKA',now(),now(),1),
#6218
('Turanovac',33406,'Lukač','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6219
('Turanj',23207,'Sveti Filip i Jakov','ZADARSKA',now(),now(),1),
#6220
('Turčenica',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6221
('Turčević Polje',43531,'Veliki Bastaji','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6222
('Turčić',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#6223
('Turčin',42204,'Turčin','VARAŽDINSKA',now(),now(),1),
#6224
('Turčišće',40318,'Dekanovec','MEĐIMURSKA',now(),now(),1),
#6225
('Turjaci',21230,'Sinj','SPLITSKO-DALMATINSKA',now(),now(),1),
#6226
('Turjanski',53223,'Vrhovine','LIČKO-SENJSKA',now(),now(),1),
#6227
('Turke',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#6228
('Turkovčina',10381,'Bedenica','ZAGREBAČKA',now(),now(),1),
#6229
('Turkovići Ogulinski',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#6230
('Turnašica',33405,'Pitomača','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6231
('Turnić',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6232
('Turnišće',49282,'Konjščina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6233
('Turnišće Desinićko',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6234
('Turnišće Klanečko',49214,'Veliko Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6235
('Turnovo',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6236
('Turopolje',10417,'Buševec','ZAGREBAČKA',now(),now(),1),
#6237
('Tusti Vrh',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#6238
('Tustica',23207,'Sveti Filip i Jakov','ZADARSKA',now(),now(),1),
#6239
('Tušilović',47241,'Cerovac Vukmanički','KARLOVAČKA',now(),now(),1),
#6240
('Tuškani',47286,'Mahično','KARLOVAČKA',now(),now(),1),
#6241
('Tuštevac',20357,'Blace','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6242
('Tužno',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#6243
('Tvrda Reka',43202,'Zrinski Topolovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6244
('Tvrđavica',31000,'Osijek','OSJEČKO-BARANJSKA',now(),now(),1),
#6245
('Uble',20290,'Lastovo','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6246
('Udbina',53234,'Udbina','LIČKO-SENJSKA',now(),now(),1),
#6247
('Udbinja',47241,'Cerovac Vukmanički','KARLOVAČKA',now(),now(),1),
#6248
('Udetin',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6249
('Udovičić',21242,'Grab','SPLITSKO-DALMATINSKA',now(),now(),1),
#6250
('Ugarci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6251
('Ugljan',23275,'Ugljan','ZADARSKA',now(),now(),1),
#6252
('Ugljane',21243,'Ugljane','SPLITSKO-DALMATINSKA',now(),now(),1),
#6253
('Uglješ',31326,'Darda','OSJEČKO-BARANJSKA',now(),now(),1),
#6254
('Ugrini',51253,'Bribir','PRIMORSKO-GORANSKA',now(),now(),1),
#6255
('Ugrini',52420,'Buzet','ISTARSKA',now(),now(),1),
#6256
('Uljanički Brijeg',43507,'Uljanik','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6257
('Uljanik',43507,'Uljanik','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6258
('Umag',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#6259
('Umčani',21277,'Veliki Prolog','SPLITSKO-DALMATINSKA',now(),now(),1),
#6260
('Umetići',44431,'Donji Kukuruzari','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6261
('Umljanovići',22322,'Ružić','ŠIBENSKO-KNINSKA',now(),now(),1),
#6262
('Umol',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#6263
('Unčani',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6264
('Unešić',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#6265
('Unije',51562,'Unije','PRIMORSKO-GORANSKA',now(),now(),1),
#6266
('Urinj',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#6267
('Uskoci',35435,'Stara Gradiška','BRODSKO-POSAVSKA',now(),now(),1),
#6268
('Uskoplje',20210,'Cavtat','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6269
('Ustrine',51555,'Belej','PRIMORSKO-GORANSKA',now(),now(),1),
#6270
('Uštica',44324,'Jasenovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6271
('Utinja',47241,'Cerovac Vukmanički','KARLOVAČKA',now(),now(),1),
#6272
('Utinja Vrelo',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#6273
('Utiskani',43231,'Ivanska','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6274
('Utolica',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6275
('Uzdolje',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#6276
('Vabriga',52465,'Tar (Torre)','ISTARSKA',now(),now(),1),
#6277
('Vačani',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#6278
('Vadalj',22204,'Široke','ŠIBENSKO-KNINSKA',now(),now(),1),
#6279
('Vadediji',52341,'Žminj','ISTARSKA',now(),now(),1),
#6280
('Vadina',10296,'Luka','ZAGREBAČKA',now(),now(),1),
#6281
('Vadreš',52207,'Barban','ISTARSKA',now(),now(),1),
#6282
('Vaganac',53212,'Klanac','LIČKO-SENJSKA',now(),now(),1),
#6283
('Vagovina',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6284
('Vajin Vrh',47303,'Josipdol','KARLOVAČKA',now(),now(),1),
#6285
('Valenovac',31512,'Feričanci','OSJEČKO-BARANJSKA',now(),now(),1),
#6286
('Valentići',52464,'Kaštelir (Castelliere)','ISTARSKA',now(),now(),1),
#6287
('Valentinovo',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6288
('Valetić',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#6289
('Valica',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#6290
('Valići',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#6291
('Valkarin',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#6292
('Valpovo',31550,'Valpovo','OSJEČKO-BARANJSKA',now(),now(),1),
#6293
('Valtura',52100,'Pula (Pola)','ISTARSKA',now(),now(),1),
#6294
('Valun',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#6295
('Vanići',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6296
('Vantačići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#6297
('Varaštovac',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#6298
('Varaždin',42000,'Varaždin','VARAŽDINSKA',now(),now(),1),
#6299
('Varaždin Breg',42204,'Turčin','VARAŽDINSKA',now(),now(),1),
#6300
('Varaždinske Toplice',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#6301
('Vardarac',31327,'Bilje','OSJEČKO-BARANJSKA',now(),now(),1),
#6302
('Vardica',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#6303
('Varivode',22305,'Kistanje','ŠIBENSKO-KNINSKA',now(),now(),1),
#6304
('Varoš Bosiljevski',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#6305
('Varož',52341,'Žminj','ISTARSKA',now(),now(),1),
#6306
('Vasine Laze',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6307
('Vaška',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6308
('Važminec',51559,'Beli','PRIMORSKO-GORANSKA',now(),now(),1),
#6309
('Večeslavec',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6310
('Vedašići',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#6311
('Vedrine',21240,'Trilj','SPLITSKO-DALMATINSKA',now(),now(),1),
#6312
('Vedro Polje',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6313
('Vejaki',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#6314
('Vela Luka',20270,'Vela Luka','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6315
('Vela Traba',52000,'Pazin','ISTARSKA',now(),now(),1),
#6316
('Vela Učka',51414,'Ičići','PRIMORSKO-GORANSKA',now(),now(),1),
#6317
('Vela Voda',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#6318
('Vele Drage',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#6319
('Vele Mune',51212,'Vele Mune','PRIMORSKO-GORANSKA',now(),now(),1),
#6320
('Vele Srakane',51550,'Mali Lošinj','PRIMORSKO-GORANSKA',now(),now(),1),
#6321
('Veleniki',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#6322
('Veleševec',10411,'Orle','ZAGREBAČKA',now(),now(),1),
#6323
('Veleškovec',49247,'Zlatar Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6324
('Veli Brgud',51213,'Jurdani','PRIMORSKO-GORANSKA',now(),now(),1),
#6325
('Veli Dol',51241,'Križišće','PRIMORSKO-GORANSKA',now(),now(),1),
#6326
('Veli Golji',52220,'Labin','ISTARSKA',now(),now(),1),
#6327
('Veli Iž',23284,'Veli Iž','ZADARSKA',now(),now(),1),
#6328
('Veli Lošinj',51551,'Veli Lošinj','PRIMORSKO-GORANSKA',now(),now(),1),
#6329
('Veli Mlun',52420,'Buzet','ISTARSKA',now(),now(),1),
#6330
('Veli Rat',23287,'Veli Rat','ZADARSKA',now(),now(),1),
#6331
('Veli Turini',52220,'Labin','ISTARSKA',now(),now(),1),
#6332
('Velić',21240,'Trilj','SPLITSKO-DALMATINSKA',now(),now(),1),
#6333
('Velići',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#6334
('Velika',34330,'Velika','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6335
('Velika Babina Gora',33533,'Pivnica Slavonska','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6336
('Velika Barna',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6337
('Velika Branjska',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6338
('Velika Bršljanica',43282,'Veliko Vukovje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6339
('Velika Buna',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#6340
('Velika Crkvina',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#6341
('Velika Črešnjevica',33405,'Pitomača','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6342
('Velika Dapčevica',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6343
('Velika Erpenja',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6344
('Velika Glava',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#6345
('Velika Gora',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#6346
('Velika Gora',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6347
('Velika Gorica',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#6348
('Velika Gradusa',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6349
('Velika Horvatska',49216,'Desinić','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6350
('Velika Hrastilnica',10314,'Križ','ZAGREBAČKA',now(),now(),1),
#6351
('Velika Jamnička',10451,'Pisarovina','ZAGREBAČKA',now(),now(),1),
#6352
('Velika Jasenovača',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6353
('Velika Jazbina',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#6354
('Velika Jelsa',47000,'Karlovac','KARLOVAČKA',now(),now(),1),
#6355
('Velika Klisa',33533,'Pivnica Slavonska','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6356
('Velika Kopanica',35221,'Velika Kopanica','BRODSKO-POSAVSKA',now(),now(),1),
#6357
('Velika Kosnica',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#6358
('Velika Lamljana',23272,'Kali','ZADARSKA',now(),now(),1),
#6359
('Velika Lešnica',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#6360
('Velika Loza',20226,'Goveđari','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6361
('Velika Ludina',44316,'Velika Ludina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6362
('Velika Milešina',21206,'Donje Ogorje','SPLITSKO-DALMATINSKA',now(),now(),1),
#6363
('Velika Mlaka',10408,'Velika Mlaka','ZAGREBAČKA',now(),now(),1),
#6364
('Velika Mlinska',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6365
('Velika Mučna',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6366
('Velika Ostrna',10370,'Dugo Selo','ZAGREBAČKA',now(),now(),1),
#6367
('Velika Paka',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#6368
('Velika Peratovica',43290,'Grubišno Polje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6369
('Velika Petrovagorska',49253,'Lobor','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6370
('Velika Pisanica',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6371
('Velika Plana',53213,'Donje Pazarište','LIČKO-SENJSKA',now(),now(),1),
#6372
('Velika Popina',23440,'Gračac','ZADARSKA',now(),now(),1),
#6373
('Velika Rakovica',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#6374
('Velika Rasinjica',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6375
('Velika Solina',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6376
('Velika Trapinska',33410,'Suhopolje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6377
('Velika Trnava',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6378
('Velika Trnovitica',43284,'Hercegovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6379
('Velika Ves',49224,'Lepajci','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6380
('Velika Veternička',49252,'Mihovljan','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6381
('Velika Vranovina',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6382
('Velike Brisnice',53284,'Sveti Juraj','LIČKO-SENJSKA',now(),now(),1),
#6383
('Velike Sesvete',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6384
('Veliki Banovac',34552,'Badljevina','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6385
('Veliki Bastaji',43531,'Veliki Bastaji','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6386
('Veliki Bilač',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6387
('Veliki Botinovac',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6388
('Veliki Brezovec',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#6389
('Veliki Bročanac',21231,'Klis','SPLITSKO-DALMATINSKA',now(),now(),1),
#6390
('Veliki Budići',34550,'Pakrac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6391
('Veliki Budići',34553,'Bučje','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6392
('Veliki Bukovec',49251,'Mače','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6393
('Veliki Bukovec',42231,'Mali Bukovec','VARAŽDINSKA',now(),now(),1),
#6394
('Veliki Erjavec',47281,'Mali Erjavec','KARLOVAČKA',now(),now(),1),
#6395
('Veliki Gorenec',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#6396
('Veliki Grabičani',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6397
('Veliki Gradac',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6398
('Veliki Grđevac',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6399
('Veliki Jadrč',51329,'Severin na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#6400
('Veliki Komor',49251,'Mače','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6401
('Veliki Komor 64-66 i150-159',49228,'Brestovec Orehovički','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6402
('Veliki Kozinac',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#6403
('Veliki Lipovec',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#6404
('Veliki Lovrečan',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#6405
('Veliki Miletinac',43531,'Veliki Bastaji','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6406
('Veliki Modrušpotok',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#6407
('Veliki Obljaj',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6408
('Veliki Otok',48317,'Legrad','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6409
('Veliki Pašijan',43280,'Garešnica','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6410
('Veliki Poganac',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6411
('Veliki Potočec',48260,'Križevci','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6412
('Veliki Prokop',43233,'Trnovitički Popovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6413
('Veliki Prolog',21277,'Veliki Prolog','SPLITSKO-DALMATINSKA',now(),now(),1),
#6414
('Veliki Rastovac',33507,'Crnac','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6415
('Veliki Raven',48265,'Raven','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6416
('Veliki Šušnjar',44204,'Jabukovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6417
('Veliki Vareški',52208,'Krnica','ISTARSKA',now(),now(),1),
#6418
('Veliki Vrh',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#6419
('Veliki Vrh Kamanjski',47282,'Kamanje','KARLOVAČKA',now(),now(),1),
#6420
('Veliki Zdenci',43293,'Veliki Zdenci','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6421
('Veliki Žitnik',53212,'Klanac','LIČKO-SENJSKA',now(),now(),1),
#6422
('Veliko Brdo',21300,'Makarska','SPLITSKO-DALMATINSKA',now(),now(),1),
#6423
('Veliko Korenovo',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6424
('Veliko Krčevo',44430,'Hrvatska Kostajnica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6425
('Veliko Polje',33407,'Gornje Bazje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6426
('Veliko Polje',10010,'Zagreb-Sloboština','GRAD ZAGREB',now(),now(),1),
#6427
('Veliko Selce',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#6428
('Veliko Svinjičko',44203,'Gušće','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6429
('Veliko Trgovišće',49214,'Veliko Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6430
('Veliko Trojstvo',43226,'Veliko Trojstvo','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6431
('Veliko Vukovje',43282,'Veliko Vukovje','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6432
('Velim',23422,'Stankovci','ZADARSKA',now(),now(),1),
#6433
('Velimirovac',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#6434
('Velinci',49295,'Kumrovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6435
('Veliškovci',31554,'Gat','OSJEČKO-BARANJSKA',now(),now(),1),
#6436
('Velo Grablje',21450,'Hvar','SPLITSKO-DALMATINSKA',now(),now(),1),
#6437
('Velušić',22320,'Drniš','ŠIBENSKO-KNINSKA',now(),now(),1),
#6438
('Veljaki',52232,'Kršan','ISTARSKA',now(),now(),1),
#6439
('Veljane',23420,'Benkovac','ZADARSKA',now(),now(),1),
#6440
('Veljun',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#6441
('Veljun Primorski',53271,'Krivi Put','LIČKO-SENJSKA',now(),now(),1),
#6442
('Veljunska Glina',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#6443
('Veljunski Ponorac',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#6444
('Venac Mrežnički',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#6445
('Venje',34340,'Kutjevo','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6446
('Veprinac',51414,'Ičići','PRIMORSKO-GORANSKA',now(),now(),1),
#6447
('Vera',32224,'Trpinja','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#6448
('Verunić',23287,'Veli Rat','ZADARSKA',now(),now(),1),
#6449
('Vesela',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6450
('Veselići',47272,'Ribnik','KARLOVAČKA',now(),now(),1),
#6451
('Veternica/dio/1-16',49252,'Mihovljan','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6452
('Veternica/dio/17-dalje',49255,'Novi Golubovec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6453
('Vetovo',34335,'Vetovo','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6454
('Vezac',22204,'Široke','ŠIBENSKO-KNINSKA',now(),now(),1),
#6455
('Vezišće',10315,'Novoselec','ZAGREBAČKA',now(),now(),1),
#6456
('Vežnaveri',52446,'Nova Vas','ISTARSKA',now(),now(),1),
#6457
('Viča Sela',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6458
('Vid',20352,'Vid','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6459
('Vidalići',53296,'Zubovići','LIČKO-SENJSKA',now(),now(),1),
#6460
('Videkić Selo',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#6461
('Vidonje',20350,'Metković','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6462
('Vidovac Cesarički',53288,'Karlobag','LIČKO-SENJSKA',now(),now(),1),
#6463
('Vidovci',34000,'Požega','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6464
('Vidovec',42205,'Vidovec','VARAŽDINSKA',now(),now(),1),
#6465
('Vidovec Krapinski',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6466
('Vidovec Petrovski',49224,'Lepajci','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6467
('Vidovići',51556,'Martinšćica','PRIMORSKO-GORANSKA',now(),now(),1),
#6468
('Vidrenjak',44316,'Velika Ludina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6469
('Vidulini',52341,'Žminj','ISTARSKA',now(),now(),1),
#6470
('Viganj',20267,'Kućište','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6471
('Vijenac Barilovićki',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#6472
('Vikend naselje',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#6473
('Vilanci',49215,'Tuhelj','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6474
('Vilanija',52470,'Umag (Umago)','ISTARSKA',now(),now(),1),
#6475
('Viletinec',42250,'Lepoglava','VARAŽDINSKA',now(),now(),1),
#6476
('Vilić Selo',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6477
('Viljevo',31531,'Viljevo','OSJEČKO-BARANJSKA',now(),now(),1),
#6478
('Vina',21276,'Vrgorac','SPLITSKO-DALMATINSKA',now(),now(),1),
#6479
('Vinagora',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6480
('Vinalić',21236,'Vrlika','SPLITSKO-DALMATINSKA',now(),now(),1),
#6481
('Vinež',52220,'Labin','ISTARSKA',now(),now(),1),
#6482
('Vinica',42207,'Vinica','VARAŽDINSKA',now(),now(),1),
#6483
('Vinica Breg',42207,'Vinica','VARAŽDINSKA',now(),now(),1),
#6484
('Vinično',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#6485
('Vinine',21243,'Ugljane','SPLITSKO-DALMATINSKA',now(),now(),1),
#6486
('Vinipotok',49253,'Lobor','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6487
('Vinišće',21226,'Vinišće','SPLITSKO-DALMATINSKA',now(),now(),1),
#6488
('Vinivrh',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#6489
('Vinkovački Banovci',32247,'Banovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#6490
('Vinkovci',32100,'Vinkovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#6491
('Vinkovec /dio/',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#6492
('Vinkovec /dio/',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#6493
('Vinogradci',31554,'Gat','OSJEČKO-BARANJSKA',now(),now(),1),
#6494
('Vinogradi Ludbreški',42230,'Ludbreg','VARAŽDINSKA',now(),now(),1),
#6495
('Vinovac',21228,'Blizna Donja','SPLITSKO-DALMATINSKA',now(),now(),1),
#6496
('Vinski Vrh',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#6497
('Vinterovec',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6498
('Vinjerac',23247,'Vinjerac','ZADARSKA',now(),now(),1),
#6499
('Vir',23234,'Vir','ZADARSKA',now(),now(),1),
#6500
('Viranec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6501
('Virje',48326,'Virje','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6502
('Virje Križovljansko',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#6503
('Virovitica',33000,'Virovitica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6504
('Vis',21480,'Vis','SPLITSKO-DALMATINSKA',now(),now(),1),
#6505
('Visočane',23241,'Poličnik','ZADARSKA',now(),now(),1),
#6506
('Visočani',20231,'Doli','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6507
('Visoće',10457,'Sošice','ZAGREBAČKA',now(),now(),1),
#6508
('Visoka',22323,'Unešić','ŠIBENSKO-KNINSKA',now(),now(),1),
#6509
('Visoka Greda',35400,'Nova Gradiška','BRODSKO-POSAVSKA',now(),now(),1),
#6510
('Visoko',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#6511
('Visovi',43211,'Predavac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6512
('Visuć',53234,'Udbina','LIČKO-SENJSKA',now(),now(),1),
#6513
('Višći Vrh',10456,'Kalje','ZAGREBAČKA',now(),now(),1),
#6514
('Viškovci',31401,'Viškovci','OSJEČKO-BARANJSKA',now(),now(),1),
#6515
('Viškovci',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6516
('Viškovići',52222,'Koromačno','ISTARSKA',now(),now(),1),
#6517
('Viškovo',51216,'Viškovo','PRIMORSKO-GORANSKA',now(),now(),1),
#6518
('Višnjan',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#6519
('Višnjevac',43226,'Veliko Trojstvo','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6520
('Višnjevac',31220,'Višnjevac','OSJEČKO-BARANJSKA',now(),now(),1),
#6521
('Višnjevac Podvrški',10432,'Bregana','ZAGREBAČKA',now(),now(),1),
#6522
('Višnjevec',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6523
('Višnjica',21276,'Vrgorac','SPLITSKO-DALMATINSKA',now(),now(),1),
#6524
('Višnjica',33520,'Slatina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6525
('Višnjica Uštička',44324,'Jasenovac','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6526
('Višnjić Brdo',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#6527
('Vitaljina',20218,'Pločice','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6528
('Vitešinec',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#6529
('Vitunj',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#6530
('Vivodina',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#6531
('Vižanovec',49254,'Belec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6532
('Vižinada',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#6533
('Vižintini',52428,'Oprtalj (Portole)','ISTARSKA',now(),now(),1),
#6534
('Vižintini Vrhi',52429,'Grožnjan (Grisignana)','ISTARSKA',now(),now(),1),
#6535
('Vižovlje',49214,'Veliko Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6536
('Vladimirovac',33411,'Gradina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6537
('Vladislavci',31404,'Vladislavci','OSJEČKO-BARANJSKA',now(),now(),1),
#6538
('Vladisovo',35420,'Staro Petrovo Selo','BRODSKO-POSAVSKA',now(),now(),1),
#6539
('Vlahović',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6540
('Vlaislav',48325,'Novigrad Podravski','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6541
('Vlaka',21275,'Dragljane','SPLITSKO-DALMATINSKA',now(),now(),1),
#6542
('Vlaka/lij.ob.Male Neretve/',20355,'Opuzen','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6543
('Vlašić Brdo',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#6544
('Vlašići',23249,'Povljana','ZADARSKA',now(),now(),1),
#6545
('Vlaškovec',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#6546
('Vlatkovac',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6547
('Voćarica',44330,'Novska','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6548
('Voćin',33522,'Voćin','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6549
('Vode',51304,'Gerovo','PRIMORSKO-GORANSKA',now(),now(),1),
#6550
('Vodena Draga',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#6551
('Vodena glava',23440,'Gračac','ZADARSKA',now(),now(),1),
#6552
('Vodice',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#6553
('Vodice',52420,'Buzet','ISTARSKA',now(),now(),1),
#6554
('Vodice',22211,'Vodice','ŠIBENSKO-KNINSKA',now(),now(),1),
#6555
('Vodnjan',52215,'Vodnjan (Dignano)','ISTARSKA',now(),now(),1),
#6556
('Vodostaj',47000,'Karlovac','KARLOVAČKA',now(),now(),1),
#6557
('Vodoteč',53260,'Brinje','LIČKO-SENJSKA',now(),now(),1),
#6558
('Vodovađa',20216,'Dubravka','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6559
('Vođinci',32283,'Vođinci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#6560
('Vojakovac',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6561
('Vojišnica',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#6562
('Vojlovica',33514,'Čačinci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6563
('Vojnić',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#6564
('Vojnić Breg 1-20 i 22-dalje',49228,'Brestovec Orehovički','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6565
('Vojnić Breg kbr 21',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6566
('Vojnić Sinjski',21240,'Trilj','SPLITSKO-DALMATINSKA',now(),now(),1),
#6567
('Vojnovac',47303,'Josipdol','KARLOVAČKA',now(),now(),1),
#6568
('Vojnovec Kalnički',48269,'Kalnik','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6569
('Vojnovec Loborski',49253,'Lobor','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6570
('Vojnović Brdo',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#6571
('Vojsak',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6572
('Vojvodinec',48312,'Rasinja','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6573
('Volarice',53284,'Sveti Juraj','LIČKO-SENJSKA',now(),now(),1),
#6574
('Volavec',49245,'Gornja Stubica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6575
('Volavje',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#6576
('Volinja',44435,'Divuša','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6577
('Voloder',44318,'Voloder','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6578
('Voljevec Riječki',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6579
('Vorkapić',44415,'Topusko','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6580
('Voštane',21245,'Tijarica','SPLITSKO-DALMATINSKA',now(),now(),1),
#6581
('Vošteni',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#6582
('Vozilići',52234,'Plomin','ISTARSKA',now(),now(),1),
#6583
('Vrabač',21242,'Grab','SPLITSKO-DALMATINSKA',now(),now(),1),
#6584
('Vrana',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#6585
('Vrana',23211,'Pakoštane','ZADARSKA',now(),now(),1),
#6586
('Vraneševci',33523,'Čađavica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6587
('Vranić',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6588
('Vranići kod Višnjana',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#6589
('Vranići kod Vižinade',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#6590
('Vranik',53244,'Lovinac','LIČKO-SENJSKA',now(),now(),1),
#6591
('Vrankovec',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6592
('Vranojelje',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#6593
('Vranov Dol',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#6594
('Vranovača',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#6595
('Vranovci',35209,'Bukovlje','BRODSKO-POSAVSKA',now(),now(),1),
#6596
('Vranovine',53212,'Klanac','LIČKO-SENJSKA',now(),now(),1),
#6597
('Vranja',52434,'Boljun','ISTARSKA',now(),now(),1),
#6598
('Vranjak Žumberački',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#6599
('Vranje Selo',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#6600
('Vranjic',21210,'Solin','SPLITSKO-DALMATINSKA',now(),now(),1),
#6601
('Vrata',51322,'Fužine','PRIMORSKO-GORANSKA',now(),now(),1),
#6602
('Vrataruša',53271,'Krivi Put','LIČKO-SENJSKA',now(),now(),1),
#6603
('Vratečko',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6604
('Vratišinec',40315,'Mursko Središče','MEĐIMURSKA',now(),now(),1),
#6605
('Vratnik',53273,'Vratnik','LIČKO-SENJSKA',now(),now(),1),
#6606
('Vratnik Samoborski',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#6607
('Vratno Donje',42207,'Vinica','VARAŽDINSKA',now(),now(),1),
#6608
('Vratno Otok',42208,'Cestica','VARAŽDINSKA',now(),now(),1),
#6609
('Vrbanci',47201,'Draganići','KARLOVAČKA',now(),now(),1),
#6610
('Vrbani',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#6611
('Vrbanovec',42232,'Donji Martijanec','VARAŽDINSKA',now(),now(),1),
#6612
('Vrbanska Draga',47281,'Mali Erjavec','KARLOVAČKA',now(),now(),1),
#6613
('Vrbanj',21462,'Vrbanj','SPLITSKO-DALMATINSKA',now(),now(),1),
#6614
('Vrbanja',32254,'Vrbanja','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#6615
('Vrbica',32284,'Stari Mikanovci','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#6616
('Vrbica',43226,'Veliko Trojstvo','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6617
('Vrbišnica',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6618
('Vrbje',35423,'Vrbje','BRODSKO-POSAVSKA',now(),now(),1),
#6619
('Vrbnik',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#6620
('Vrbnik',51516,'Vrbnik','PRIMORSKO-GORANSKA',now(),now(),1),
#6621
('Vrbno',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#6622
('Vrboska',21463,'Vrboska','SPLITSKO-DALMATINSKA',now(),now(),1),
#6623
('Vrbova',35414,'Vrbova','BRODSKO-POSAVSKA',now(),now(),1),
#6624
('Vrbovac',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6625
('Vrbovec',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#6626
('Vrbovec Samoborski',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#6627
('Vrbovečki Pavlovec',10340,'Vrbovec','ZAGREBAČKA',now(),now(),1),
#6628
('Vrbovljani',35430,'Okučani','BRODSKO-POSAVSKA',now(),now(),1),
#6629
('Vrbovo',49283,'Hraščina-Trgovišće','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6630
('Vrbovo Posavsko',10411,'Orle','ZAGREBAČKA',now(),now(),1),
#6631
('Vrbovsko',51326,'Vrbovsko','PRIMORSKO-GORANSKA',now(),now(),1),
#6632
('Vrčići',23249,'Povljana','ZADARSKA',now(),now(),1),
#6633
('Vrčin Dol',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6634
('Vrebac',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#6635
('Vrećari',52231,'Nedešćina','ISTARSKA',now(),now(),1),
#6636
('Vrelo Koreničko',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#6637
('Vrgada',23210,'Biograd na moru','ZADARSKA',now(),now(),1),
#6638
('Vrgorac',21276,'Vrgorac','SPLITSKO-DALMATINSKA',now(),now(),1),
#6639
('Vrh',51500,'Krk','PRIMORSKO-GORANSKA',now(),now(),1),
#6640
('Vrh',47201,'Draganići','KARLOVAČKA',now(),now(),1),
#6641
('Vrh',52420,'Buzet','ISTARSKA',now(),now(),1),
#6642
('Vrh Brodski',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#6643
('Vrh Lašići',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#6644
('Vrh Letovanički',44273,'Sela','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6645
('Vrh Martinšćice',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#6646
('Vrh Visočki',42225,'Breznički Hum','VARAŽDINSKA',now(),now(),1),
#6647
('Vrhi Pregradski',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6648
('Vrhi Vinagorski',49218,'Pregrada','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6649
('Vrhjani',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#6650
('Vrhova Gorica',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#6651
('Vrhovac',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#6652
('Vrhovac Sokolovački',48306,'Sokolovac','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6653
('Vrhovački Sopot',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#6654
('Vrhovci',51305,'Tršće','PRIMORSKO-GORANSKA',now(),now(),1),
#6655
('Vrhovčak',10430,'Samobor','ZAGREBAČKA',now(),now(),1),
#6656
('Vrhovec',10347,'Rakovec','ZAGREBAČKA',now(),now(),1),
#6657
('Vrhovec Bednjanski',42253,'Bednja','VARAŽDINSKA',now(),now(),1),
#6658
('Vrhovina',35211,'Trnjani','BRODSKO-POSAVSKA',now(),now(),1),
#6659
('Vrhovine',53223,'Vrhovine','LIČKO-SENJSKA',now(),now(),1),
#6660
('Vrhovljan',40313,'Sveti Martin na Muri','MEĐIMURSKA',now(),now(),1),
#6661
('Vrisnik',21465,'Jelsa','SPLITSKO-DALMATINSKA',now(),now(),1),
#6662
('Vrlika',21236,'Vrlika','SPLITSKO-DALMATINSKA',now(),now(),1),
#6663
('Vrnjak',52462,'Momjan (Momiano)','ISTARSKA',now(),now(),1),
#6664
('Vrpile',53230,'Korenica','LIČKO-SENJSKA',now(),now(),1),
#6665
('Vrpolje',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#6666
('Vrpolje',21245,'Tijarica','SPLITSKO-DALMATINSKA',now(),now(),1),
#6667
('Vrpolje',22206,'Boraja','ŠIBENSKO-KNINSKA',now(),now(),1),
#6668
('Vrpolje',35210,'Vrpolje','BRODSKO-POSAVSKA',now(),now(),1),
#6669
('Vrpolje Bansko',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6670
('Vrsar',52450,'Vrsar (Orsera)','ISTARSKA',now(),now(),1),
#6671
('Vrsi',23235,'Vrsi','ZADARSKA',now(),now(),1),
#6672
('Vrsine',21222,'Marina','SPLITSKO-DALMATINSKA',now(),now(),1),
#6673
('Vrsno',22206,'Boraja','ŠIBENSKO-KNINSKA',now(),now(),1),
#6674
('Vrškovac',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#6675
('Vrtlinovec',42223,'Varaždinske Toplice','VARAŽDINSKA',now(),now(),1),
#6676
('Vrtlinska',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6677
('Vrtnjakovec',49217,'Krapinske Toplice','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6678
('Vručac',47313,'Drežnica','KARLOVAČKA',now(),now(),1),
#6679
('Vrvari',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#6680
('Vrzići',53273,'Vratnik','LIČKO-SENJSKA',now(),now(),1),
#6681
('Vucelići',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#6682
('Vučak',49221,'Bedekovčina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6683
('Vučani',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6684
('Vučetinec',40311,'Lopatinec','MEĐIMURSKA',now(),now(),1),
#6685
('Vučevci',31402,'Semeljci','OSJEČKO-BARANJSKA',now(),now(),1),
#6686
('Vučevica',21202,'Lećevica','SPLITSKO-DALMATINSKA',now(),now(),1),
#6687
('Vučilčevo',10293,'Dubravica','ZAGREBAČKA',now(),now(),1),
#6688
('Vučinići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#6689
('Vučipolje',21233,'Hrvace','SPLITSKO-DALMATINSKA',now(),now(),1),
#6690
('Vučipolje',23243,'Jasenice','ZADARSKA',now(),now(),1),
#6691
('Vučjak',23247,'Vinjerac','ZADARSKA',now(),now(),1),
#6692
('Vučjak Feričanački',31512,'Feričanci','OSJEČKO-BARANJSKA',now(),now(),1),
#6693
('Vučnik',51328,'Lukovdol','PRIMORSKO-GORANSKA',now(),now(),1),
#6694
('Vuger Selo',10360,'Sesvete','GRAD ZAGREB',now(),now(),1),
#6695
('Vuglovec',42240,'Ivanec','VARAŽDINSKA',now(),now(),1),
#6696
('Vugrišinec',40306,'Macinec','MEĐIMURSKA',now(),now(),1),
#6697
('Vugrovec Donji',10360,'Sesvete','GRAD ZAGREB',now(),now(),1),
#6698
('Vugrovec Gornji',10360,'Sesvete','GRAD ZAGREB',now(),now(),1),
#6699
('Vujići Vojakovački',48264,'Kloštar Vojakovački','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6700
('Vujnovići',51326,'Vrbovsko','PRIMORSKO-GORANSKA',now(),now(),1),
#6701
('Vuka',31403,'Vuka','OSJEČKO-BARANJSKA',now(),now(),1),
#6702
('Vukanci',49251,'Mače','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6703
('Vukanovec',40306,'Macinec','MEĐIMURSKA',now(),now(),1),
#6704
('Vukelići',47313,'Drežnica','KARLOVAČKA',now(),now(),1),
#6705
('Vukelići',53203,'Kosinj','LIČKO-SENJSKA',now(),now(),1),
#6706
('Vukelići',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#6707
('Vuketić',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#6708
('Vukmanić',47241,'Cerovac Vukmanički','KARLOVAČKA',now(),now(),1),
#6709
('Vukoder',47286,'Mahično','KARLOVAČKA',now(),now(),1),
#6710
('Vukojevci',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#6711
('Vukojevica',34350,'Čaglin','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6712
('Vukomerić',10418,'Dubranec','ZAGREBAČKA',now(),now(),1),
#6713
('Vukosavljevica',33404,'Špišić Bukovica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6714
('Vukoševac',44211,'Blinjski Kut','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6715
('Vukova Gorica',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#6716
('Vukovar',32000,'Vukovar','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#6717
('Vukovar-dio',32010,'Vukovar','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#6718
('Vukovec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6719
('Vukovije',43500,'Daruvar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6720
('Vukovina',10419,'Vukovina','ZAGREBAČKA',now(),now(),1),
#6721
('Vukovje Zelinsko',10382,'Donja Zelina','ZAGREBAČKA',now(),now(),1),
#6722
('Vukovo Brdo',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#6723
('Vukovo Selo',10292,'Šenkovec','ZAGREBAČKA',now(),now(),1),
#6724
('Vukovoj',42244,'Klenovnik','VARAŽDINSKA',now(),now(),1),
#6725
('Vuksani',47281,'Mali Erjavec','KARLOVAČKA',now(),now(),1),
#6726
('Vukšić',23422,'Stankovci','ZADARSKA',now(),now(),1),
#6727
('Vukšin Šipak',10454,'Krašić','ZAGREBAČKA',now(),now(),1),
#6728
('Vukšinec Riječki',48268,'Gornja Rijeka','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6729
('Vularija',40322,'Orehovica','MEĐIMURSKA',now(),now(),1),
#6730
('Vulišinec',42250,'Lepoglava','VARAŽDINSKA',now(),now(),1),
#6731
('Vurnovec',10362,'Kašina','GRAD ZAGREB',now(),now(),1),
#6732
('Vurot',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6733
('Zablatje',48316,'Đelekovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6734
('Zablatje Posavsko',10410,'Velika Gorica','ZAGREBAČKA',now(),now(),1),
#6735
('Zabok',49210,'Zabok','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6736
('Zaborsko Selo',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#6737
('Zabrđe',20230,'Ston','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6738
('Zabrđe',10345,'Gradec','ZAGREBAČKA',now(),now(),1),
#6739
('Zabrežani',52000,'Pazin','ISTARSKA',now(),now(),1),
#6740
('Zabukovac',51252,'Klenovica','PRIMORSKO-GORANSKA',now(),now(),1),
#6741
('Zadar',23000,'Zadar','ZADARSKA',now(),now(),1),
#6742
('Zadobarje',47000,'Karlovac','KARLOVAČKA',now(),now(),1),
#6743
('Zadravec',49228,'Brestovec Orehovički','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6744
('Zadrkovec',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#6745
('Zadubravlje',35211,'Trnjani','BRODSKO-POSAVSKA',now(),now(),1),
#6746
('Zadvarje',21255,'Zadvarje','SPLITSKO-DALMATINSKA',now(),now(),1),
#6747
('Zadvorsko',10257,'Brezovica','GRAD ZAGREB',now(),now(),1),
#6748
('Zaglav',23281,'Sali','ZADARSKA',now(),now(),1),
#6749
('Zagolik',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#6750
('Zagora',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6751
('Zagore',51418,'Brseč','PRIMORSKO-GORANSKA',now(),now(),1),
#6752
('Zagorje',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#6753
('Zagorje',52234,'Plomin','ISTARSKA',now(),now(),1),
#6754
('Zagorje Modruško',47307,'Gornje Zagorje','KARLOVAČKA',now(),now(),1),
#6755
('Zagorska Sela',49296,'Zagorska Sela','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6756
('Zagrad',23420,'Benkovac','ZADARSKA',now(),now(),1),
#6757
('Zagradci',47250,'Duga Resa','KARLOVAČKA',now(),now(),1),
#6758
('Zagrađe',34310,'Pleternica','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6759
('Zagraj',47286,'Mahično','KARLOVAČKA',now(),now(),1),
#6760
('Zagreb-dio',10010,'Zagreb-Sloboština','GRAD ZAGREB',now(),now(),1),
#6761
('Zagreb-dio',10000,'Zagreb','GRAD ZAGREB',now(),now(),1),
#6762
('Zagreb-dio',10020,'Zagreb-Novi Zagreb','GRAD ZAGREB',now(),now(),1),
#6763
('Zagreb-dio',10040,'Zagreb-Dubrava','GRAD ZAGREB',now(),now(),1),
#6764
('Zagreb-dio',10090,'Zagreb-Susedgrad','GRAD ZAGREB',now(),now(),1),
#6765
('Zagreb-Trešnjevka',10110,'Zagreb','GRAD ZAGREB',now(),now(),1),
#6766
('Zagvozd',21270,'Zagvozd','SPLITSKO-DALMATINSKA',now(),now(),1),
#6767
('Zahrt',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#6768
('Zaistovec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6769
('Zajačko Selo',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#6770
('Zajci',52333,'Podpićan','ISTARSKA',now(),now(),1),
#6771
('Zajezda',49284,'Budinšćina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6772
('Zaklepica',10311,'Posavski Bregi','ZAGREBAČKA',now(),now(),1),
#6773
('Zaklopac',23445,'Srb','ZADARSKA',now(),now(),1),
#6774
('Zaklopača',53233,'Ličko Petrovo Selo','LIČKO-SENJSKA',now(),now(),1),
#6775
('Zaklopatica',20290,'Lastovo','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6776
('Zakopa',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6777
('Zakorenje',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6778
('Zakrajc Brodski',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#6779
('Zakrajc Turkovski',51302,'Kuželj','PRIMORSKO-GORANSKA',now(),now(),1),
#6780
('Zakučac',21310,'Omiš','SPLITSKO-DALMATINSKA',now(),now(),1),
#6781
('Zalesina',51313,'Kupjak','PRIMORSKO-GORANSKA',now(),now(),1),
#6782
('Zaloj',44400,'Glina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6783
('Zalug',49231,'Hum na Sutli','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6784
('Zaluka',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#6785
('Zaluka Lipnička',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#6786
('Zaluki',51213,'Jurdani','PRIMORSKO-GORANSKA',now(),now(),1),
#6787
('Zalužje',42255,'Donja Višnjica','VARAŽDINSKA',now(),now(),1),
#6788
('Zalužnica',53223,'Vrhovine','LIČKO-SENJSKA',now(),now(),1),
#6789
('Zamaski Dol',52000,'Pazin','ISTARSKA',now(),now(),1),
#6790
('Zambratija',52475,'Savudrija (Salvore)','ISTARSKA',now(),now(),1),
#6791
('Zamlača',42205,'Vidovec','VARAŽDINSKA',now(),now(),1),
#6792
('Zamlača',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6793
('Zamladinec',48267,'Orehovec','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6794
('Zamlaka',42202,'Trnovec Bartolovečki','VARAŽDINSKA',now(),now(),1),
#6795
('Zamost',51303,'Plešce','PRIMORSKO-GORANSKA',now(),now(),1),
#6796
('Zamost Brodski',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#6797
('Zamršje',47203,'Rečica','KARLOVAČKA',now(),now(),1),
#6798
('Zamslina',20231,'Doli','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6799
('Zankovci',52232,'Kršan','ISTARSKA',now(),now(),1),
#6800
('Zaostrog',21334,'Zaostrog','SPLITSKO-DALMATINSKA',now(),now(),1),
#6801
('Zapeć',51328,'Lukovdol','PRIMORSKO-GORANSKA',now(),now(),1),
#6802
('Zapoljak',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#6803
('Zapolje',35422,'Zapolje','BRODSKO-POSAVSKA',now(),now(),1),
#6804
('Zapolje Brodsko',51301,'Brod na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#6805
('Zaprešić',10290,'Zaprešić','GRAD ZAGREB',now(),now(),1),
#6806
('Zapuntel',23292,'Molat','ZADARSKA',now(),now(),1),
#6807
('Zapužane',23420,'Benkovac','ZADARSKA',now(),now(),1),
#6808
('Zaraće',21450,'Hvar','SPLITSKO-DALMATINSKA',now(),now(),1),
#6809
('Zarečje',52000,'Pazin','ISTARSKA',now(),now(),1),
#6810
('Zarilac',34312,'Sesvete (kod Požege)','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6811
('Zasadbreg',40311,'Lopatinec','MEĐIMURSKA',now(),now(),1),
#6812
('Zasiok',21233,'Hrvace','SPLITSKO-DALMATINSKA',now(),now(),1),
#6813
('Zastenice',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#6814
('Zastolje',20216,'Dubravka','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6815
('Zastražišće',21466,'Zastražišće','SPLITSKO-DALMATINSKA',now(),now(),1),
#6816
('Zatka Ćepić',52232,'Kršan','ISTARSKA',now(),now(),1),
#6817
('Zaton',22215,'Zaton','ŠIBENSKO-KNINSKA',now(),now(),1),
#6818
('Zaton',20235,'Zaton Veliki','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6819
('Zaton',23232,'Nin','ZADARSKA',now(),now(),1),
#6820
('Zaton Doli',20231,'Doli','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6821
('Zaton Obrovački',23450,'Obrovac','ZADARSKA',now(),now(),1),
#6822
('Zaumol',51328,'Lukovdol','PRIMORSKO-GORANSKA',now(),now(),1),
#6823
('Zavala',21465,'Jelsa','SPLITSKO-DALMATINSKA',now(),now(),1),
#6824
('Zaveščak',40314,'Selnica','MEĐIMURSKA',now(),now(),1),
#6825
('Zavođe',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#6826
('Zavojane',21275,'Dragljane','SPLITSKO-DALMATINSKA',now(),now(),1),
#6827
('Zavrelje',20207,'Mlini','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6828
('Zavrh',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#6829
('Završje',51312,'Brod Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#6830
('Završje',52429,'Grožnjan (Grisignana)','ISTARSKA',now(),now(),1),
#6831
('Završje',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6832
('Završje',35252,'Sibinj','BRODSKO-POSAVSKA',now(),now(),1),
#6833
('Završje Belečko',49254,'Belec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6834
('Završje Loborsko',49253,'Lobor','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6835
('Završje Netretićko',47271,'Netretić','KARLOVAČKA',now(),now(),1),
#6836
('Završje Podbelsko',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#6837
('Završje Začretsko',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6838
('Zbelava',42202,'Trnovec Bartolovečki','VARAŽDINSKA',now(),now(),1),
#6839
('Zbičina',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#6840
('Zbišina',51557,'Cres','PRIMORSKO-GORANSKA',now(),now(),1),
#6841
('Zbitke',51307,'Prezid','PRIMORSKO-GORANSKA',now(),now(),1),
#6842
('Zbjeg',35254,'Bebrina','BRODSKO-POSAVSKA',now(),now(),1),
#6843
('Zbjegovača',44320,'Kutina','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6844
('Zden',47264,'Tounj','KARLOVAČKA',now(),now(),1),
#6845
('Zdenci',33513,'Zdenci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6846
('Zdenci Brdovečki',10291,'Prigorje Brdovečko','ZAGREBAČKA',now(),now(),1),
#6847
('Zdenčac',43280,'Garešnica','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6848
('Zdenčec',43240,'Čazma','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6849
('Zdihovo',10450,'Jastrebarsko','ZAGREBAČKA',now(),now(),1),
#6850
('Zdihovo',51329,'Severin na Kupi','PRIMORSKO-GORANSKA',now(),now(),1),
#6851
('Zebanec Selo',40314,'Selnica','MEĐIMURSKA',now(),now(),1),
#6852
('Zeci',52341,'Žminj','ISTARSKA',now(),now(),1),
#6853
('Zečev Varoš',47240,'Slunj','KARLOVAČKA',now(),now(),1),
#6854
('Zečevo',22305,'Kistanje','ŠIBENSKO-KNINSKA',now(),now(),1),
#6855
('Zečevo Rogozničko',22203,'Rogoznica','ŠIBENSKO-KNINSKA',now(),now(),1),
#6856
('Zečica',47300,'Ogulin','KARLOVAČKA',now(),now(),1),
#6857
('Zelčin',31227,'Zelčin','OSJEČKO-BARANJSKA',now(),now(),1),
#6858
('Zelengrad',23450,'Obrovac','ZADARSKA',now(),now(),1),
#6859
('Zeleni hrast',23242,'Posedarje','ZADARSKA',now(),now(),1),
#6860
('Zeleno Polje',31321,'Petlovac','OSJEČKO-BARANJSKA',now(),now(),1),
#6861
('Zelin Crnoluški',51317,'Crni Lug','PRIMORSKO-GORANSKA',now(),now(),1),
#6862
('Zelin Mrzlovodički',51316,'Lokve','PRIMORSKO-GORANSKA',now(),now(),1),
#6863
('Zelina Breška',10310,'Ivanić-Grad','ZAGREBAČKA',now(),now(),1),
#6864
('Zelovo',21233,'Hrvace','SPLITSKO-DALMATINSKA',now(),now(),1),
#6865
('Zelovo',21247,'Neorić','SPLITSKO-DALMATINSKA',now(),now(),1),
#6866
('Zemunik',23222,'Zemunik','ZADARSKA',now(),now(),1),
#6867
('Zemunik Gornji',23222,'Zemunik','ZADARSKA',now(),now(),1),
#6868
('Zetkan',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#6869
('Zgališće',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#6870
('Zgrabljići',52448,'Sveti Lovreč','ISTARSKA',now(),now(),1),
#6871
('Zgurić Brdo',10414,'Pokupsko','ZAGREBAČKA',now(),now(),1),
#6872
('Zidarići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#6873
('Zimić',47242,'Krnjak','KARLOVAČKA',now(),now(),1),
#6874
('Zinajevac',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#6875
('Zlarin',22232,'Zlarin','ŠIBENSKO-KNINSKA',now(),now(),1),
#6876
('Zlatar',49250,'Zlatar','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6877
('Zlatar-Bistrica',49247,'Zlatar Bistrica','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6878
('Zlatna Greda',31309,'Kneževi Vinogradi','OSJEČKO-BARANJSKA',now(),now(),1),
#6879
('Zleć',49223,'Sveti Križ Začretje','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6880
('Zlobin',51324,'Zlobin','PRIMORSKO-GORANSKA',now(),now(),1),
#6881
('Zlogonje',42255,'Donja Višnjica','VARAŽDINSKA',now(),now(),1),
#6882
('Zmajevac',31307,'Zmajevac (V&#246;r&#246;smart)','OSJEČKO-BARANJSKA',now(),now(),1),
#6883
('Zmijavci',21266,'Zmijavci','SPLITSKO-DALMATINSKA',now(),now(),1),
#6884
('Znož /dio/9-dalje',49254,'Belec','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6885
('Znož/dio/1-8',49250,'Zlatar','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6886
('Zokov Gaj',33513,'Zdenci','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6887
('Zoljan',31500,'Našice','OSJEČKO-BARANJSKA',now(),now(),1),
#6888
('Zoljani',35216,'Prnjavor','BRODSKO-POSAVSKA',now(),now(),1),
#6889
('Zoretići',51218,'Dražice','PRIMORSKO-GORANSKA',now(),now(),1),
#6890
('Zoričići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#6891
('Zoričići',51260,'Crikvenica','PRIMORSKO-GORANSKA',now(),now(),1),
#6892
('Zorkovac',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#6893
('Zorkovac na Kupi',47280,'Ozalj','KARLOVAČKA',now(),now(),1),
#6894
('Zorkovac Vivodinski',47283,'Vivodina','KARLOVAČKA',now(),now(),1),
#6895
('Zrenj',52428,'Oprtalj (Portole)','ISTARSKA',now(),now(),1),
#6896
('Zrin',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6897
('Zrinska',43270,'Veliki Grđevac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6898
('Zrinska Drag',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6899
('Zrinski Brđani',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6900
('Zrinski Topolovac',43202,'Zrinski Topolovac','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6901
('Zrinšćina',10383,'Komin','ZAGREBAČKA',now(),now(),1),
#6902
('Zrinj Lukački',33407,'Gornje Bazje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6903
('Zrmanja',23440,'Gračac','ZADARSKA',now(),now(),1),
#6904
('Zrmanja Vrelo',23440,'Gračac','ZADARSKA',now(),now(),1),
#6905
('Zrnići',47313,'Drežnica','KARLOVAČKA',now(),now(),1),
#6906
('Zubovići',53296,'Zubovići','LIČKO-SENJSKA',now(),now(),1),
#6907
('Zut',44440,'Dvor','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6908
('Zvečaj',47261,'Zvečaj','KARLOVAČKA',now(),now(),1),
#6909
('Zvečanje',21253,'Gata','SPLITSKO-DALMATINSKA',now(),now(),1),
#6910
('Zvekovac',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#6911
('Zvekovica',20210,'Cavtat','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6912
('Zverinac',23286,'Božava','ZADARSKA',now(),now(),1),
#6913
('Zverinac',23291,'Sestrunj','ZADARSKA',now(),now(),1),
#6914
('Zvijerci',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6915
('Zvjerinac',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#6916
('Zvoneća',51213,'Jurdani','PRIMORSKO-GORANSKA',now(),now(),1),
#6917
('Zvonik',10344,'Farkaševac','ZAGREBAČKA',now(),now(),1),
#6918
('Zvonimirevo',33410,'Suhopolje','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6919
('Zvonimirovac',33523,'Čađavica','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6920
('Žabica',53000,'Gospić','LIČKO-SENJSKA',now(),now(),1),
#6921
('Žabjak',43212,'Rovišće','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6922
('Žabljak',47252,'Barilović','KARLOVAČKA',now(),now(),1),
#6923
('Žabnica',10343,'Nova Kapela','ZAGREBAČKA',now(),now(),1),
#6924
('Žabnik',42202,'Trnovec Bartolovečki','VARAŽDINSKA',now(),now(),1),
#6925
('Žabnik',40313,'Sveti Martin na Muri','MEĐIMURSKA',now(),now(),1),
#6926
('Žabno',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6927
('Žabnjača',33507,'Crnac','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6928
('Žabnjak',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#6929
('Žagrići',52341,'Žminj','ISTARSKA',now(),now(),1),
#6930
('Žagrović',22300,'Knin','ŠIBENSKO-KNINSKA',now(),now(),1),
#6931
('Žakanje',47276,'Žakanje','KARLOVAČKA',now(),now(),1),
#6932
('Žakule',51325,'Moravice','PRIMORSKO-GORANSKA',now(),now(),1),
#6933
('Žamarija',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#6934
('Žarovnica',42250,'Lepoglava','VARAŽDINSKA',now(),now(),1),
#6935
('Žažina',44272,'Lekenik','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6936
('Žažvić',22214,'Čista Velika','ŠIBENSKO-KNINSKA',now(),now(),1),
#6937
('Žbandaj',52440,'Poreč (Parenzo)','ISTARSKA',now(),now(),1),
#6938
('Ždala',48332,'Ždala','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6939
('Ždralovi',43000,'Bjelovar','BJELOVARSKO-BILOGORSKA',now(),now(),1),
#6940
('Ždrapanj',22222,'Skradin','ŠIBENSKO-KNINSKA',now(),now(),1),
#6941
('Ždrelac',23263,'Ždrelac','ZADARSKA',now(),now(),1),
#6942
('Ždrijac',23232,'Nin','ZADARSKA',now(),now(),1),
#6943
('Ždrilo',23247,'Vinjerac','ZADARSKA',now(),now(),1),
#6944
('Žedno',21220,'Trogir','SPLITSKO-DALMATINSKA',now(),now(),1),
#6945
('Žegar',23450,'Obrovac','ZADARSKA',now(),now(),1),
#6946
('Žejane',51212,'Vele Mune','PRIMORSKO-GORANSKA',now(),now(),1),
#6947
('Žejinci',10296,'Luka','ZAGREBAČKA',now(),now(),1),
#6948
('Železna Gora',40312,'Štrigova','MEĐIMURSKA',now(),now(),1),
#6949
('Želiski',52207,'Barban','ISTARSKA',now(),now(),1),
#6950
('Željava',53233,'Ličko Petrovo Selo','LIČKO-SENJSKA',now(),now(),1),
#6951
('Željeznica',42242,'Radovan','VARAŽDINSKA',now(),now(),1),
#6952
('Željezno Žumberačko',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#6953
('Žena Glava',21483,'Podšpilje','SPLITSKO-DALMATINSKA',now(),now(),1),
#6954
('Ženodraga',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#6955
('Žerava',23235,'Vrsi','ZADARSKA',now(),now(),1),
#6956
('Žerjavinec',10360,'Sesvete','GRAD ZAGREB',now(),now(),1),
#6957
('Žestilac',51515,'Šilo','PRIMORSKO-GORANSKA',now(),now(),1),
#6958
('Žeževica',21250,'Šestanovac','SPLITSKO-DALMATINSKA',now(),now(),1),
#6959
('Žgaljići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#6960
('Žgombići',51511,'Malinska','PRIMORSKO-GORANSKA',now(),now(),1),
#6961
('Žibrinovec',48269,'Kalnik','KOPRIVNIČKO-KRIŽEVAČKA',now(),now(),1),
#6962
('Židovinjak',49221,'Bedekovčina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#6963
('Žigerovci',34322,'Brestovac','POŽEŠKO-SLAVONSKA',now(),now(),1),
#6964
('Žigrovec',42214,'Sveti Ilija','VARAŽDINSKA',now(),now(),1),
#6965
('Žikovići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#6966
('Žirčica',44000,'Sisak','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6967
('Žirje',22236,'Žirje','ŠIBENSKO-KNINSKA',now(),now(),1),
#6968
('Žiroslavlje',33412,'Cabuna','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6969
('Žiškovec',40000,'Čakovec','MEĐIMURSKA',now(),now(),1),
#6970
('Žitarka',10436,'Rakov Potok','ZAGREBAČKA',now(),now(),1),
#6971
('Žitkovčica',10413,'Kravarsko','ZAGREBAČKA',now(),now(),1),
#6972
('Žitnić',22320,'Drniš','ŠIBENSKO-KNINSKA',now(),now(),1),
#6973
('Žitomir',10380,'Sveti Ivan Zelina','ZAGREBAČKA',now(),now(),1),
#6974
('Živaja',44450,'Hrvatska Dubica','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6975
('Živike',35257,'Lužani','BRODSKO-POSAVSKA',now(),now(),1),
#6976
('Živković Kosa',47220,'Vojnić','KARLOVAČKA',now(),now(),1),
#6977
('Živogošće',21329,'Igrane','SPLITSKO-DALMATINSKA',now(),now(),1),
#6978
('Žlebec Gorički',10294,'Donja Pušća','ZAGREBAČKA',now(),now(),1),
#6979
('Žlebec Pušćanski',10294,'Donja Pušća','ZAGREBAČKA',now(),now(),1),
#6980
('Žlebina',33411,'Gradina','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6981
('Žman',23282,'Žman','ZADARSKA',now(),now(),1),
#6982
('Žminj',52341,'Žminj','ISTARSKA',now(),now(),1),
#6983
('Žnjidarići',52428,'Oprtalj (Portole)','ISTARSKA',now(),now(),1),
#6984
('Žonti',52420,'Buzet','ISTARSKA',now(),now(),1),
#6985
('Žreme',44210,'Sunja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#6986
('Žrnovac',51311,'Skrad','PRIMORSKO-GORANSKA',now(),now(),1),
#6987
('Žrnovnica',21251,'Žrnovnica','SPLITSKO-DALMATINSKA',now(),now(),1),
#6988
('Žrnovo',20275,'Žrnovo','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6989
('Žuberkovac',35429,'Gornji Bogićevci','BRODSKO-POSAVSKA',now(),now(),1),
#6990
('Žubrica',33412,'Cabuna','VIROVITIČKO-PODRAVSKA',now(),now(),1),
#6991
('Žubrinci',47251,'Bosiljevo','KARLOVAČKA',now(),now(),1),
#6992
('Žudetići',52447,'Vižinada (Visinada)','ISTARSKA',now(),now(),1),
#6993
('Žuknica',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#6994
('Žukovec',10342,'Dubrava','ZAGREBAČKA',now(),now(),1),
#6995
('Žuljana',20247,'Žuljana','DUBROVAČKO-NERETVANSKA',now(),now(),1),
#6996
('Žumberak',10455,'Kostanjevac','ZAGREBAČKA',now(),now(),1),
#6997
('Žunci',10346,'Preseka','ZAGREBAČKA',now(),now(),1),
#6998
('Žuntići',52352,'Kanfanar','ISTARSKA',now(),now(),1),
#6999
('Župa',21273,'Župa','SPLITSKO-DALMATINSKA',now(),now(),1),
#7000
('Župa Srednja',21273,'Župa','SPLITSKO-DALMATINSKA',now(),now(),1),
#7001
('Županec',42231,'Mali Bukovec','VARAŽDINSKA',now(),now(),1),
#7002
('Županići',52231,'Nedešćina','ISTARSKA',now(),now(),1),
#7003
('Županja',32270,'Županja','VUKOVARSKO-SRIJEMSKA',now(),now(),1),
#7004
('Županje',51515,'Šilo','PRIMORSKO-GORANSKA',now(),now(),1),
#7005
('Župić',44250,'Petrinja','SISAČKO-MOSLAVAČKA',now(),now(),1),
#7006
('Žurkovo',51221,'Kostrena','PRIMORSKO-GORANSKA',now(),now(),1),
#7007
('Žuta Lokva',53260,'Brinje','LIČKO-SENJSKA',now(),now(),1),
#7008
('Žutnica',49000,'Krapina','KRAPINSKO-ZAGORSKA',now(),now(),1),
#7009
('Žužići',52463,'Višnjan (Visignano)','ISTARSKA',now(),now(),1),
#7010
('Žužići',52444,'Tinjan','ISTARSKA',now(),now(),1);
#)

-- OSOBA
#1
insert into osoba (oib,ime,prezime,adresa,mjesto,telefon,mobitel,email,slika)
values ('96141450286','Višnja','Srdanović','Sjenjak 32',4266,'031123123','098730004','visnja@gmail.com',null);
#2
insert into osoba (oib,ime,prezime,adresa,mjesto,telefon,mobitel,email,slika)
values ('46530469259','Dario','Srdanović','Sjenjak 32',4276,'031456456','098323185','srky187@gmail.com',null);
#3
insert into osoba (oib,ime,prezime,adresa,mjesto,telefon,mobitel,email,slika)
values ('11111111111','Eduard','Kuzma','Ulica Lorenza Jagera 5',4286,'031205555','098000002','edo@gmail.com',null);
#4
insert into osoba (oib,ime,prezime,adresa,mjesto,telefon,mobitel,email,slika) values 
('00000000100','Tomislav','Jakopec','Trpinjska 23',4086,'031205555','098000001','tjakopec@gmail.com',null);

-- ZAPOSLENIK
#1
insert into zaposlenik (osoba,nadredeni,radnomjesto,datumunosa,datumpromjene,operater) 
values (1,null,'Šef',now(),now(),1);
#2
insert into zaposlenik (osoba,nadredeni,radnomjesto,datumunosa,datumpromjene,operater) 
values (2,1,'Radnik',now(),now(),2);

-- KLIJENT
#1 
insert into klijent (osoba,datumunosa,datumpromjene,operater) 
values (3,now(),now(),3);
#2
insert into klijent (osoba,datumunosa,datumpromjene,operater) 
values (4,now(),now(),4);

-- USLUGE

insert into usluga (naziv,cijena,datumunosa,datumpromjene,operater) values

('Šišanje',null,now(),now(),1),

('Kupanje',null,now(),now(),1),

('Češljanje',null,now(),now(),1),

('Rezanje noktiju',null,now(),now(),1),

('Brijanje šapica',null,now(),now(),1);

-- PASMINA

insert into pasmina (naziv,slika,datumunosa,datumpromjene,operater) values 
('Američki koker španijel','americkiKokerSpanijel.jpg',now(),now(),1),
('Belgijski ovčar - Malinois','malinois.jpg',now(),now(),1),
('Bernski planinski pas','bernskiPlaninskiPas.jpg',now(),now(),1),
('Bichon Frise','bichonFrise.jpg',now(),now(),1),
('Bichon Havanese','nemaSlike.png',now(),now(),1),
('Bigl','bigl.jpg',now(),now(),1),
('Crni ruski terijer','crniRuskiTerijer.jpg',now(),now(),1),
('Čau Čau','chowChow.jpg',now(),now(),1),
('Čivava','civava.jpg',now(),now(),1),
('Engleski koker španijel','engleskiKokerSpanijel.jpg',now(),now(),1),
('Engleski buldog','engleskiBuldog.jpg',now(),now(),1),
('Erdel terijer','erdelTerijer.jpg',now(),now(),1),
('Fox terijer - oštrodlaki','foxTerijerOstrodlaki.jpg',now(),now(),1),
('Francuski buldog','francuskiBuldog.jpg',now(),now(),1),
('Irski terijer','irskiTerijer.jpg',now(),now(),1),
('Irski vodeni španijel','irskiVodeniSpanijel.jpg',now(),now(),1),
('Jazavčar','jazavcar.jpg',now(),now(),1),
('Jorkširski terijer','jorksirskiTerijer.jpg',now(),now(),1),
('Kavalir King Charles španijel','cavalierKingCharlesSpaniel.jpg',now(),now(),1),
('Kern terijer','kernTerijer.jpg',now(),now(),1),
('Kineski kukmasti pas','kineskiKukmastiPas.jpg',now(),now(),1),
('Klamber španijel','klamberSpanijel.jpg',now(),now(),1),
('Lakeland terijer','lakelandTerijer.jpg',now(),now(),1),
('Lhasa Apso','lhasaApso.jpg',now(),now(),1),
('Maltezer','maltezer.jpg',now(),now(),1),
('Mekodlaki pšenični terijer','mekodlakiPsenicniTerijer.jpg',now(),now(),1),
('Mops','mops.jpg',now(),now(),1),
('Norfolški terijer','norfolskiTerijer.jpg',now(),now(),1),
('Norvički terijer','norvickiTerijer.jpg',now(),now(),1),
('Parson Russell terijer','parsonRussellTerijer.jpg',now(),now(),1),
('Patuljasti pinč','patuljastiPinc.jpg',now(),now(),1),
('Pekinezer','pekinezer.jpg',now(),now(),1),
('Poljski nizinski ovčar','poljskiNizinskiOvcar.jpg',now(),now(),1),
('Poljski španijel','poljskiSpanijel.jpg',now(),now(),1),
('Pudla','pudla.jpg',now(),now(),1),
('Puli','puli.jpg',now(),now(),1),
('Samojed','samojed.jpg',now(),now(),1),
('Shih Tzu','shihTzu.jpg',now(),now(),1),
('Silihejmski terijer','silihejmskiTerijer.jpg',now(),now(),1),
('Skye terijer','skyeTerijer.jpg',now(),now(),1),
('Škotski terijer','skotskiTerijer.jpg',now(),now(),1),
('Šnaucer, patuljasti','patuljastiSnaucer.jpg',now(),now(),1),
('Šnaucer, srednji','srednjiSnaucer.jpg',now(),now(),1),
('Šnaucer, veliki','velikiSnaucer.jpg',now(),now(),1),
('Tibetski terijer','tibetskiTerijer.jpg',now(),now(),1),
('Velški terijer','velskiTerijer.jpg',now(),now(),1),
('Westie','westie.jpg',now(),now(),1);


-- PAS
#1
insert into pas (ime,pasmina,klijent,slika,datumunosa,datumpromjene,operater) values ('Blacky',1,1,null,now(),now(),3);
#2
insert into pas (ime,pasmina,klijent,slika,datumunosa,datumpromjene,operater) values ('Tory',2,1,null,now(),now(),3);
#3
insert into pas (ime,pasmina,klijent,slika,datumunosa,datumpromjene,operater) values ('Max',3,2,null,now(),now(),4);

-- NARUDŽBE

#1
insert into narudzba (zaposlenik,klijent,pas,datumnarudzbe,termin,dan,status,napomena,datumunosa,datumpromjene,operater)
values (2,1,1,'2015-04-09','07:00','Četvrtak',true,'Grize',now(),now(),2);
#2
insert into narudzba (zaposlenik,klijent,pas,datumnarudzbe,termin,dan,status,napomena,datumunosa,datumpromjene,operater)
values (2,1,2,'2015-04-10','09:30','Petak',true,'Operiran stomak',now(),now(),2);
#3
insert into narudzba (zaposlenik,klijent,pas,datumnarudzbe,termin,dan,status,napomena,datumunosa,datumpromjene,operater)
values (2,2,3,'2015-04-13','17:00','Ponedjeljak',true,'Bolesne uši',now(),now(),2);

-- NARUDŽBA_USLUGA

#1
insert into narudzba_usluga(narudzba,usluga,cijena) values (1,1,100.00);
insert into narudzba_usluga(narudzba,usluga,cijena) values (1,2,30.00);
insert into narudzba_usluga(narudzba,usluga,cijena) values (1,3,20.00);

#2
insert into narudzba_usluga(narudzba,usluga,cijena) values (2,3,60.00);
insert into narudzba_usluga(narudzba,usluga,cijena) values (2,4,20.00);

#3
insert into narudzba_usluga(narudzba,usluga,cijena) values (3,2,50.00);
insert into narudzba_usluga(narudzba,usluga,cijena) values (3,3,30.00);
insert into narudzba_usluga(narudzba,usluga,cijena) values (3,5,20.00);













