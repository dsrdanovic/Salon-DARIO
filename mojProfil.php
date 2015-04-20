<?php
include_once 'konfiguracija.php';
?>

<!doctype html>
<html class="no-js" lang="en">
	<head>

		<?php
		include_once 'head.php';
		?>
		<link rel="stylesheet" href="<?php echo $putanjaApp; ?>strength/styled/strength.css" />
		<link rel="stylesheet" href="<?php echo $putanjaApp; ?>tooltipster/css/tooltipster.css"/>

	</head>
	<body spellcheck="false">

		<?php
		include_once 'zaglavlje.php';
		?>

				<?php

				$izraz = $veza -> prepare("select * from mjesto");
				$izraz -> execute();
				$mjesto = $izraz -> fetchAll(PDO::FETCH_OBJ);

				$korisnickoime = $_SESSION[$ida . "operater"] -> korisnickoime;
				//	echo $korisnickoime;
				$izraz = $veza -> prepare("select a.*,b.*,c.* from operater a inner join zaposlenik b on  a.sifra=b.operater inner join osoba c on b.osoba=c.sifra where a.korisnickoime= :korisnickoime");
				$izraz -> bindParam(":korisnickoime", $korisnickoime);
				$izraz -> execute();
				$osoba = $izraz -> fetch(PDO::FETCH_OBJ);

				if ($osoba == null) {

					$izraz = $veza -> prepare("select a.*,b.sifra as sifraKlijenta,b.*,c.* from operater a inner join klijent b on  a.sifra=b.operater inner join osoba c on b.osoba=c.sifra where a.korisnickoime= :korisnickoime");
					$izraz -> bindParam(":korisnickoime", $korisnickoime);
					$izraz -> execute();
					$osoba = $izraz -> fetch(PDO::FETCH_OBJ);

					$izraz = $veza -> prepare("select * from pasmina");
					$izraz -> execute();
					$pasmina = $izraz -> fetchAll(PDO::FETCH_OBJ);

					$izraz = $veza -> prepare("select a.*,b.naziv,b.sifra as sifraPasmine,b.slika as slikaPasmine from pas a inner join pasmina b on a.pasmina=b.sifra where klijent=:sifraKlijenta");
					$sifraKlijenta = $osoba -> sifraKlijenta;
					$izraz -> bindParam(":sifraKlijenta", $sifraKlijenta);
					$izraz -> execute();
					$pas = $izraz -> fetchAll(PDO::FETCH_OBJ);
				}
				?>

		<div class="row">
			<div class="large-12 columns">
					<h4><i class="fi-torso"> </i><?php echo $osoba -> ime . ' ' . $osoba -> prezime; ?></h4>
				<hr />

			</div>
		</div>

		<div class="row">
			
			<div class="large-4 columns">
				
				
				<form id="myform" action="promjenaOsoba.php" method="post" accept-charset="utf-8" >

					<label for="oib">OIB</label>
					<input id="oib" type="text" name="oib" maxlength="11" value="<?php echo $osoba -> oib; ?>">

					<label for="ime">Ime</label>
					<input id="ime" type="text" name="ime" value="<?php echo $osoba -> ime; ?>">

					<label for="ime">Prezime</label>
					<input id="prezime" type="text" name="prezime" value="<?php echo $osoba -> prezime; ?>" >

					<label for="adresa">Adresa</label>
					<input id="adresa" type="text" name="adresa" value="<?php echo $osoba -> adresa; ?>" >

					<label for="mjesto">Mjesto</label>
					<select id="mjesto" name="mjesto">
						<option value = "0"></option>
						
								
						<?php
						foreach ($mjesto as $m) : ?>

						 <option value="<?php echo $m -> sifra; ?>" <?php if($m -> sifra == $osoba->mjesto): ?> selected="selected"<?php endif; ?>><?php echo $m -> naselje; ?></option>

						<?php endforeach; ?>
					</select>
					
					<label for="telefon">Telefon</label>
					<input id="telefon" type="text" name="telefon" value="<?php echo $osoba -> telefon; ?>">

					<label for="mobitel">Mobitel</label>
					<input id="mobitel" type="text" name="mobitel" value="<?php echo $osoba -> mobitel; ?>">

					<label for="email">E-mail</label>
					<input id="email" type="text" name="email" value="<?php echo $osoba -> email; ?>">
	
									
					<div class="row collapse prefix-radius">
											<div class="large-5 columns">
												<span class="prefix">Datum unosa</span>
											</div>
											<div class="large-7 columns">
											<?php
											$date = date_create($osoba -> datumunosa);
											?>
												<input id="datumunosa" name="datumunosa" type="text" disabled="disabled" value="<?php echo date_format($date, 'd.m.Y. H:i:s'); ?>">
											</div>
										</div>
					
					<div class="row collapse prefix-radius">
											<div class="large-5 columns">
												<span class="prefix">Datum promjene</span>
											</div>
											<div class="large-7 columns">
											<?php
											$date = date_create($osoba -> datumpromjene);
											?>
												<input id="datumpromjene" name="datumpromjene" type="text" disabled="disabled" value="<?php echo date_format($date, 'd.m.Y. H:i:s'); ?>">
											</div>
										</div>
					
					
					
					<a href="#" id="promjenaOsoba" type="submit" class="round button success tipkaspremi2"><i class="fi-save"></i> Spremi</a>
					
				</form>
				
				<div data-alert class="alert-box success radius profil" style="display: none;">
  									Spremljeno.
 									 <a href="#" class="close"></a>
									</div>

				</div>

					<div class="large-6 columns">

						<ul class="accordion" data-accordion>
							<li class="accordion-navigation">
								<a href="#panel0a"><i class="fi-key"> </i>Promjena lozinke</a>
								<div id="panel0a" class="content">

									<form id="formaZaPromjenuLozinke" action="promjenaLozinka.php" method="post" accept-charset="utf-8" >

										<div class="row collapse prefix-radius">
											<div class="small-5 columns">
												<span class="prefix bok">Trenutna lozinka</span>
											</div>
											<div class="small-7 columns">
												<input id="trenutnaLozinka" name="trenutnaLozinka" type="password">
											</div>
										</div>

										<div class="row collapse prefix-radius">
											<div class="small-5 columns">
												<span class="prefix">Nova lozinka</span>
											</div>
											<div class="small-7 columns">
												<input id="novaLozinka" name="novaLozinka" type="password">
											</div>
										</div>

										<div class="row collapse prefix-radius">
											<div class="small-5 columns">
												<span class="prefix">Ponovno nova lozinka</span>
											</div>
											<div class="small-7 columns">
												<input id="ponovoNovaLozinka" name="ponovoNovaLozinka" type="password">
											</div>
										</div>
										<a href="#" id="promjenaLozinke" type="submit" class="round button success tipkaspremi3"><i class="fi-save"></i> Spremi</a>

									
										
											<div data-alert class="alert-box success radius alertLozinkaPromjenjena" style="display: none;">
  									Lozinka uspješno promjenjena.
 									 <a href="#" class="close"></a>
									</div>

									</form>
									
								
									
								
									

								</div>
							</li>
						</ul>
						<br />
					
						
						<?php if($_SESSION[$ida . "operater"]->uloga=="korisnik" && isset($pas)): ?>
							
						<ul class="accordion" data-accordion>
							
						
							<li class="accordion-navigation">
								<a href="#panel1a"><i class="fi-guide-dog"> </i>Moj pas</a>
									
									<?php 
							
							foreach ($pas as $pas) :
								
					
							
							?>
						
								<div id="panel1a" class="content">
					

									<form id="formaZaPromjenuPsa<?php echo $pas->sifra;?>" action="promjenaPsa.php" method="post" accept-charset="utf-8" >

										<div class="row collapse prefix-radius">
											<div class="small-5 columns">
												<span class="prefix">Ime</span>
											</div>
											<div class="small-7 columns">
												<input id="ime" name="ime" type="text" value="<?php echo $pas -> ime; ?>">
											</div>
										</div>

										<div class="row collapse prefix-radius">
											<div class="small-5 columns">
												<span class="prefix">Pasmina</span>
											</div>
											<div class="small-7 columns">
												
							<select id="pasmina" name="pasmina">
			
							<option value = "0">----------------------------------------</option>
								
						<?php
						foreach ($pasmina as $p) : ?>

						 <option value="<?php echo $p -> sifra; ?>" <?php if($p -> sifra == $pas->sifraPasmine): ?> selected="selected"<?php endif; ?>><?php echo $p -> naziv; ?></option>

						<?php endforeach; ?>
					</select>
											</div>
										</div>

										<div class="row collapse prefix-radius">
											<div class="small-12 columns">
												<span class="prefix">Slika</span>
											</div>
											
											<div class="panel profilpas">
												<?php
												$dat = $_SERVER["CONTEXT_DOCUMENT_ROOT"] . $putanjaApp."img/pasmine/". $pas->slikaPasmine;
				//print_r($dat);
				if(file_exists($dat)){
					$slika=$putanjaApp . "img/pasmine/". $pas->slikaPasmine;
				}
				else{
					$slika=$putanjaApp . "img/pasmine/nemaSlike.png";;
				}
				?>
													<img alt="" src="<?php echo $slika; ?>">
											</div>
											
											<div class="row collapse prefix-radius">
											<div class="large-5 columns">
												<span class="prefix">Datum unosa</span>
											</div>
											<div class="large-7 columns">
											<?php
											$date = date_create($pas -> datumunosa);
											?>
												<input id="datumunosa" name="datumunosa" type="text" disabled="disabled" value="<?php echo date_format($date, 'd.m.Y. H:i:s'); ?>">
											</div>
										</div>
					
					<div class="row collapse prefix-radius">
											<div class="large-5 columns">
												<span class="prefix">Datum promjene</span>
											</div>
											<div class="large-7 columns">
											<?php
											$date = date_create($pas -> datumpromjene);
											?>
												<input id="datumpromjene" name="datumpromjene" type="text" disabled="disabled" value="<?php echo date_format($date, 'd.m.Y. H:i:s'); ?>">
											</div>
										</div>
							
 							 <a href="#" name="<?php echo $pas->sifra;?>" id="promjenaPsa<?php echo $pas->sifra;?>" type="submit" class="round button success tipkaspremi3"><i class="fi-save"></i> Spremi</a>															
	
											<div id="alertPasPromjenjen<?php echo $pas->sifra;?>" data-alert class="alert-box success radius" style="display: none;">
  									Spremljeno.
 									 <a href="#" class="close"></a>
									</div>
							

									</form>
									
									
									
										
									<?php endforeach; ?>
									
								

								</div>
							</li>
							
						</ul>
						
						
						<?php endif; ?>
						
						
						
							
										
									

						</div>

					</div>
					
					
							
					
					
					

		<?php
		include_once 'podnozje.php';
		?>

		<?php
		include_once 'skripte.php';
		?>
		
	
		<script src="<?php echo $putanjaApp; ?>jQuery-MD5-master/jquery.md5.js"></script>
		<script src="<?php echo $putanjaApp; ?>tooltipster/js/jquery.tooltipster.min.js"></script>
		<script>
		
		
		// ako je dokument spreman					
		$(document).ready(function($) {
			
		// cim pocnem pisati sakrij tooltipove
		$(window).keypress(function() {
		$('#trenutnaLozinka').tooltipster('hide');
		$('#novaLozinka').tooltipster('hide');
		$('#ponovoNovaLozinka').tooltipster('hide');
		$('.alert-box').fadeOut();
				$('#oib').tooltipster('hide');
					$('#ime').tooltipster('hide');
					$('#prezime').tooltipster('hide');
					$('#adresa').tooltipster('hide');
					
					$('#mobitel').tooltipster('hide');
			});

		// cim kliknem misem sakrij tooltipove
		$(window).click(function() {
		$('#trenutnaLozinka').tooltipster('hide');
		$('#novaLozinka').tooltipster('hide');
		$('#ponovnoNovaLozinka').tooltipster('hide');
		$('.alert-box').fadeOut();
				$('#oib').tooltipster('hide');
					$('#ime').tooltipster('hide');
					$('#prezime').tooltipster('hide');
					$('#adresa').tooltipster('hide');
			
					$('#mobitel').tooltipster('hide');
			});
			
			$('#oib').tooltipster({
					position : 'left',
					//hideOnClick: 'true',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});

				$('#ime').tooltipster({
					position : 'left',
					//hideOnClick: 'true',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});

				$('#prezime').tooltipster({
					position : 'left',
					//hideOnClick: 'true',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});


				$('#mobitel').tooltipster({
					position : 'left',
					//hideOnClick: 'true',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});

				$('#email').tooltipster({
					position : 'left',
					//hideOnClick: 'true',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});
	
				
				// klikom na tipku Spremi u formi Moj Profil napravi->
		$('#promjenaOsoba').click(function(event) {
			
		// spriječi refresh stranice
		event.preventDefault();	
		
		//PROVJERA OIBA

		var oib = $('#oib').val();
		var oib_regex = /^[0-9]{11}$/;

		if (oib.length == 0) {

		$('#oib').tooltipster('content', 'Ovo polje je obavezno.');
		$('#oib').tooltipster('show');
		return false;
		}

		if (!oib.match(oib_regex)) {

		$('#oib').tooltipster('content', 'Unesite 11 znamenki.');
	//	$('#oib').tooltipster('content', $('Unesite 11 znamenki.<br/ >Saznajte svoj <a href=\"http://oib.oib.hr/SaznajOibWeb/fizickaOsoba.html\">OIB</a>.'));
		$('#oib').tooltipster('show');

		return false;
		}
		
	//PROVJERA IMENA

			var ime = $('#ime').val();
			var ime_regex = /^[a-zA-Z ćĆčČđĐšŠžŽ]{2,50}$/;

			if (ime.length == 0) {

			$('#ime').tooltipster('content', 'Ovo polje je obavezno.');
			$('#ime').tooltipster('show');
			return false;
			}

			if (!ime.match(ime_regex)) {

			$('#ime').tooltipster('content', 'Dozvoljena samo slova. 2-50');
			$('#ime').tooltipster('show');
			return false;
			}

			//PROVJERA PREZIMENA

			var prezime = $('#prezime').val();
			var prezime_regex = /^[a-zA-Z ćĆčČđĐšŠžŽ]{2,50}$/;

			if (prezime.length == 0) {

			$('#prezime').tooltipster('content', 'Ovo polje je obavezno.');
			$('#prezime').tooltipster('show');

			return false;
			}

			if (!prezime.match(prezime_regex)) {

			$('#prezime').tooltipster('content', 'Dozvoljena samo slova. 2-50');
			$('#prezime').tooltipster('show');

			return false;
			}

			

			//PROVJERA MOBITELA

			var mobitel = $('#mobitel').val();
			var mobitel_regex = /^[(]{0,1}[0-9]{3}[)]{0,1}[-\s\.]{0,1}[0-9]{3}[-\s\.]{0,1}[0-9]{3,4}$/;

			if (mobitel.length == 0) {
			$('#mobitel').tooltipster('content', 'Ovo polje je obavezno.');
			$('#mobitel').tooltipster('show');

			return false;
			}

			if (!mobitel.match(mobitel_regex)) {
			$('#mobitel').tooltipster('content', 'Dozvoljeni samo brojevi. 9-10');
			$('#mobitel').tooltipster('show');
			return false;

			}

			//PROVJERA EMAILA

			var email = $('#email').val();
			var email_regex = /^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i;

			if (email.length == 0) {
			$('#email').tooltipster('content', 'Ovo polje je obavezno.');
			$('#email').tooltipster('show');

			return false;
			}

			if (!email.match(email_regex)) {
			$('#email').tooltipster('content', 'Niste unijeli valjani e-mail.');
			$('#email').tooltipster('show');
			return false;

			}
		
		
		// sifra operatera
		var sifra = <?php echo $_SESSION[$ida . "operater"]->sifra ?>;						
		// označavanje forme kojom pristupam
		var forma = $("#myform");
		// kupljenje podataka iz forme
		var podaci = forma.serialize();
		// adresa di je stranica za dodavanje osobe
		var url = forma.attr('action');
		// alert box za moj profil
		var alertBox = $('.profil');
					

		$.ajax({
			type : "POST",
			url : url,
			data : podaci+"&sifra="+sifra,
			cache : false,
			success : function(data) {
	
			if (data == "OK") {
				
			
			
			setTimeout(function(){
      			$(alertBox).fadeIn(500);
    				}, 1000);		
			
		
					}

				}
			});


				}); 
			
			
			
			
		// klikom na bilo koji button 
		$('.button').click(function(event) {
			
		// sprijeci refresh stranice	
		event.preventDefault();
				
		// pronadji sifru tipke 		
	   	var sifra = $(this).attr('name');
		// pronadji formu od tipke
   		var forma = $(this).closest("form");
		// pokupi podatke iz inputa
		var podaci = forma.serialize();
		// pronadji adresu za ajax
		var url = forma.attr('action');
		// pronadji alert box poslije ajaxa	
		var alertBox = $('#alertPasPromjenjen'+sifra);
	
		$.ajax({
		type : "POST",
		url : url,
		data : podaci+"&sifra="+sifra,
		cache : false,
		success : function(data) {
	
		if (data == "OK") {
			
		setTimeout(function(){
      		$(alertBox).fadeIn(500);
    			}, 1000);		
		
				}

			}
		});

			
		});
			
											
		
										
			
	
	

	$('#trenutnaLozinka').tooltipster({
	position : 'right',
	//hideOnClick: 'true',
	offsetX : '5px',
	offsetY : '-19px',
	trigger : 'custom'

	});

	$('#novaLozinka').tooltipster({
	position : 'right',
	//hideOnClick: 'true',
	offsetX : '5px',
	offsetY : '-19px',
	trigger : 'custom'

	});

	$('#ponovoNovaLozinka').tooltipster({
	position : 'right',
	//hideOnClick: 'true',
	offsetX : '5px',
	offsetY : '-19px',
	trigger : 'custom'

	});

	$('#promjenaLozinke').click(function(event) {

	event.preventDefault();

	var trenutnaLozinka = $("#trenutnaLozinka").val();

	if (trenutnaLozinka.length == 0) {

	$('#trenutnaLozinka').tooltipster('content', 'Ovo polje je obavezno.');
	$('#trenutnaLozinka').tooltipster('show');
	return false;
	}

	var lozinka = $.md5(trenutnaLozinka);
	var sifra =
 <?php echo $_SESSION[$ida . "operater"]->sifra ?>
	;

	$.ajax({
		type : "POST",
		url : "provjeraLozinka.php",
		data : "lozinka=" + lozinka + "&sifra=" + sifra,
		cache : false,
		success : function(data) {

			if (data == "NEPOSTOJI") {
				$('#trenutnaLozinka').tooltipster('content', 'Netočan unos.');
				$('#trenutnaLozinka').tooltipster('show');

				return false;

			}
		}
	});

	var novaLozinka = $("#novaLozinka").val();

	if (novaLozinka.length == 0) {

		$('#novaLozinka').tooltipster('content', 'Ovo polje je obavezno.');
		$('#novaLozinka').tooltipster('show');
		return false;
	}

	if (novaLozinka.length < 8) {

		$('#novaLozinka').tooltipster('content', 'Minimalno 8 znakova.');
		$('#novaLozinka').tooltipster('show');
		return false;
	}

	var ponovoNovaLozinka = $("#ponovoNovaLozinka").val();

	if (novaLozinka != ponovoNovaLozinka) {
		$('#novaLozinka').tooltipster('content', 'Lozinke nisu jednake.');
		$('#novaLozinka').tooltipster('show');
		$('#ponovoNovaLozinka').tooltipster('content', 'Lozinke nisu jednake.');
		$('#ponovoNovaLozinka').tooltipster('show');
		return false;
	}

	var novaLozinka = $.md5(novaLozinka);
	var sifra =<?php echo $_SESSION[$ida . "operater"]->sifra ?>;
	var alertBox = $('.alertLozinkaPromjenjena');

	$.ajax({
		type : "POST",
		url : "promjenaLozinka.php",
		data : "lozinka=" + novaLozinka + "&sifra=" + sifra,
		cache : false,
		success : function(data) {

			if (data == "OK") {

				$('input[type="password"]').val('');

					setTimeout(function(){
      			$(alertBox).fadeIn(500);
    				}, 1000);		
			

				return false;

			}
		}
	});

	});

	});

		</script>
		
	</body>
</html>
