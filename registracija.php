<?php

include_once 'konfiguracija.php';

//SELECT MJESTO

$izraz = $veza -> prepare("select * from mjesto");
$izraz -> execute();
$mjesto = $izraz -> fetchAll(PDO::FETCH_OBJ);

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

		<!-- TIJELO -->
		<div class="row">
			<div class="large-12 columns">
				<h4><i class="fi-clipboard-pencil"></i> Registracija</h4>
				<hr />
			</div>
		</div>

		<div class="row">
			<div class="large-4 columns">

				<form id="myform" action="dodajOsobaOperater.php" method="post" accept-charset="utf-8" >

					<input id="oib" type="text" name="oib" placeholder="OIB" maxlength="11">

					<input  id="ime" type="text" name="ime" placeholder="Ime">

					<input id="prezime" type="text" name="prezime" placeholder="Prezime">

					<input id="adresa" type="text" name="adresa" placeholder="Adresa">
					
					<select id="mjesto" name="mjesto">
						<option value = "0">Mjesto</option>
						<option value = "0">--------------------------------------------------</option>
								
						<?php
						foreach ($mjesto as $m) { ?>

						 <option value="<?php echo $m -> sifra; ?>"><?php echo $m -> naselje; ?></option>

						<?php	} ?>
					</select>

					<input id="telefon" type="text" name="telefon" placeholder="Telefon">

					<input id="mobitel" type="text" name="mobitel" placeholder="Mobitel" >

					<input id="email" type="text" name="email" placeholder="E-mail">

			</div>
			<div id="myform" class="large-4 columns end">

				<input id="korisnickoime" type="text" name="korisnickoime" placeholder="Korisničko ime">

				<input id="lozinka" type="password" name="lozinka" placeholder="Lozinka">

				<input id="lozinkaponovo" type="password" name="lozinkaponovo" placeholder="Lozinka ponovo">

				<input id="registracija" type="submit" class="round button registrirajsebutton" value="Registriraj se">

				</form>

			</div>
		</div>
		<br />
		
		<?php
		include_once 'modalRegistracija.php';
		?>
	
		<?php
		include_once 'podnozje.php';
		?>

		<?php
		include_once 'skripte.php';
		?>
		<script src="<?php echo $putanjaApp; ?>strength/styled/strength.js"></script>
		<script src="<?php echo $putanjaApp; ?>tooltipster/js/jquery.tooltipster.min.js"></script>

		<script>
			$(document).ready(function($) {
				



				$(window).keypress(function() {
					$('#oib').tooltipster('hide');
					$('#ime').tooltipster('hide');
					$('#prezime').tooltipster('hide');
					$('#adresa').tooltipster('hide');
					$('#telefon').tooltipster('hide');
					$('#mobitel').tooltipster('hide');
					$('#email').tooltipster('hide');
					$('#korisnickoime').tooltipster('hide');
					$('#lozinka').tooltipster('hide');
					$('#lozinkaponovo').tooltipster('hide');
				});

				$(window).click(function() {
					$('#mjesto').tooltipster('hide');

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

				$('#adresa').tooltipster({
					position : 'left',
					//hideOnClick: 'true',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});

				$('#mjesto').tooltipster({
					position : 'left',
					//hideOnClick: 'true',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});

				$('#telefon').tooltipster({
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

				$('#korisnickoime').tooltipster({
					position : 'right',
					//hideOnClick: 'true',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});

				$('#lozinka').tooltipster({
					position : 'right',
					//hideOnClick: 'true',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});

				$('#lozinkaponovo').tooltipster({
					position : 'right',
					//hideOnClick: 'true',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});

				$("#oib").focusout(function() {

					$.ajax({
						type : "POST",
						url : "provjeraOib.php",
						data : "oib=" + $('#oib').val(),
						cache : false,
						success : function(data) {
							//alert(data);
							if (data == "POSTOJI") {
								$('#oib').tooltipster('content', 'Ovaj OIB se koristi.');
								$('#oib').tooltipster('show');
								return false;

							}
						}
					});

				});

				$("#email").focusout(function() {

					$.ajax({
						type : "POST",
						url : "provjeraEmail.php",
						data : "email=" + $('#email').val(),
						cache : false,
						success : function(data) {
							//alert(data);
							if (data == "POSTOJI") {
								$('#email').tooltipster('content', 'Ovaj E-mail se koristi.');
								$('#email').tooltipster('show');
								//	$('#email').focus();
								return false;

							}
						}
					});

				});

				$("#korisnickoime").focusout(function() {

					$.ajax({
						type : "POST",
						url : "provjeraKorisnickoIme.php",
						data : "korisnickoime=" + $('#korisnickoime').val(),
						cache : false,
						success : function(data) {
							//alert(data);
							if (data == "POSTOJI") {
								$('#korisnickoime').tooltipster('content', 'Ovo korisničko ime je zauzeto.');
								$('#korisnickoime').tooltipster('show');
								//	$('#email').focus();
								return false;

							}
						}
					});

				});

				$('#registracija').click(function(event) {

					event.preventDefault();
					// using this page stop being refreshing

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

					//PROVJERA ADRESE

					var adresa = $('#adresa').val();
					var adresa_regex = /^[a-zA-Z0-9ćĆčČđĐšŠžŽ .]{6,50}$/;

					if (adresa.length == 0) {

						$('#adresa').tooltipster('content', 'Ovo polje je obavezno.');
						$('#adresa').tooltipster('show');

						return false;
					}

					if (!adresa.match(adresa_regex)) {

						$('#adresa').tooltipster('content', 'Dozvoljena samo slova i brojevi. 6-50');
						$('#adresa').tooltipster('show');
						return false;
					}

					//PROVJERA MJESTA

					var selektiranoMjesto = $('#mjesto').val()

					if (selektiranoMjesto == 0) {

						$('#mjesto').tooltipster('content', 'Niste odabrali mjesto.');
						$('#mjesto').tooltipster('show');

						return false;
					}

					//PROVJERA TELEFONA

					var telefon = $('#telefon').val();
					var telefon_regex = /^[(]{0,1}[0-9]{3}[)]{0,1}[-\s\.]{0,1}[0-9]{3}[-\s\.]{0,1}[0-9]{3,4}$/;

					if (telefon.length == 0) {
						$('#telefon').tooltipster('content', 'Ovo polje je obavezno.');
						$('#telefon').tooltipster('show');

						return false;
					}

					if (!telefon.match(telefon_regex)) {
						$('#telefon').tooltipster('content', 'Dozvoljeni samo brojevi. 9-10');
						$('#telefon').tooltipster('show');
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

					//PROVJERA KORISNIČKOG IMENA

					var korisnickoime = $('#korisnickoime').val();
					var korisnickoime_regex = /^[a-zA-Z0-9]{6,15}$/;

					if (korisnickoime.length == 0) {
						$('#korisnickoime').tooltipster('content', 'Ovo polje je obavezno.');
						$('#korisnickoime').tooltipster('show');

						return false;
					}

					if (!korisnickoime.match(korisnickoime_regex)) {
						$('#korisnickoime').tooltipster('content', 'Dozvoljena slova i brojevi. 6-15');
						$('#korisnickoime').tooltipster('show');
						return false;

					}

					//PROVJERA LOZINKE

					var lozinka = $('#lozinka').val();
					var lozinka_regex = /^[a-zA-Z0-9]{8,15}$/;

					if (lozinka.length == 0) {
						$('#lozinka').tooltipster('content', 'Ovo polje je obavezno.');
						$('#lozinka').tooltipster('show');
						return false;
					}

					if (!lozinka.match(lozinka_regex)) {

						$('#lozinka').tooltipster('content', 'Dozvoljena slova i brojevi. Minimalno 8 znakova.');
						$('#lozinka').tooltipster('show');
						return false;
					}

					//PROVJERA LOZINKE PONOVO

					var lozinkaponovo = $('#lozinkaponovo').val();

					//if (lozinkaponovo.length == 0) {

					//	return false;
					//	}

					if (lozinka != lozinkaponovo) {
						$('#lozinka').tooltipster('content', 'Lozinke nisu jednake.');
						$('#lozinka').tooltipster('show');
						$('#lozinkaponovo').tooltipster('content', 'Lozinke nisu jednake.');
						$('#lozinkaponovo').tooltipster('show');
						return false;
					}

					var forma = $("#myform");
				//	alert(forma);
					var podaci = forma.serialize();
					var url = forma.attr('action');
					//alert(podaci);

					$.ajax({
						type : "POST",
						url : url,
						data : podaci,
						cache : false,
						success : function(data) {

							if (data == "OK") {

								$("#myModal").foundation('reveal', 'open');
							}

						}
					});

				});

				$('#lozinka').strength({
					strengthClass : 'strength',
					strengthMeterClass : 'strength_meter',
					strengthButtonClass : 'button_strength',
					strengthButtonText : 'Prikaži lozinku',
					strengthButtonTextToggle : 'Sakrij lozinku'
				});

			});

		</script>

	</body>
</html>
