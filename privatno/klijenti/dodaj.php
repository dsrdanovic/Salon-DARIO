<?php
include_once '../../konfiguracija.php';

if (!isset($_SESSION[$ida . "operater"]) || $_SESSION[$ida . "operater"]->uloga != "administrator") {
	header("location: ../../odjavi.php");
}

$izraz = $veza -> prepare("select * from mjesto");
$izraz -> execute();
$mjesto = $izraz -> fetchAll(PDO::FETCH_OBJ);
?>
<!doctype html>
<html class="no-js" lang="en">
	<head>
		<?php
		include_once '../../head.php';
	?>
	</head>
	<body>

		<?php
		include_once '../../zaglavlje.php';
	?>
		
		
		<div class="row">
			<div class="large-12 columns">
				<h4><i class="fi-torso-business"></i> Novi klijent</h4>
				<hr />
			</div>
		</div>

		<div class="row">
			<div class="large-4 columns">
				
			
			<form id="myform" action="dodajKlijenta.php" method="post" accept-charset="utf-8" >

					<label for="oib">OIB</label>
					<input id="oib" type="text" name="oib" maxlength="11">

					<label for="ime">Ime</label>
					<input id="ime" type="text" name="ime">

					<label for="ime">Prezime</label>
					<input id="prezime" type="text" name="prezime">

					<label for="adresa">Adresa</label>
					<input id="adresa" type="text" name="adresa">

					<label for="mjesto">Mjesto</label>
					<select id="mjesto" name="mjesto">
						<option value = "0"></option>
					
								
								
						<?php
						foreach ($mjesto as $m) : ?>

						 <option value="<?php echo $m -> sifra; ?>"><?php echo $m -> naselje; ?></option>

					<?php endforeach; ?>
					</select>
					
					<label for="telefon">Telefon</label>
					<input id="telefon" type="text" name="telefon">

					<label for="mobitel">Mobitel</label>
					<input id="mobitel" type="text" name="mobitel">

					<label for="email">E-mail</label>
					<input id="email" type="text" name="email">
					
					
					
					</div>
				
					<div class="large-4 columns end">	
					
					<label for="korisnickoime">Korisničko ime</label>
					<input id="korisnickoime" type="text" name="korisnickoime">

					<label for="lozinka">Lozinka</label>
					<input id="lozinka" type="password" name="lozinka">
					
					<ul class="button-group round">
					<li><a href="index.php" class="round button alert tipkanazad"><i class="fi-arrow-left"></i> Nazad</a></li>
					<li><a href="#" id="dodajKlijenta" type="submit" class="round button success tipkaspremi"><i class="fi-save"></i> Spremi</a></li>
					
					
					</ul>
					
					</form>
					
						<div data-alert class="alert-box success radius alertKlijentDodan" style="display: none;">
  									Klijent uspješno dodan.
 									 <a href="#" class="close"></a>
									</div>	

				
					
					</div>
					
					
			
		</div>

		<?php
		include_once '../../podnozje.php';
		?>

		<?php
		include_once '../../skripte.php';
		?>
		
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
				});
				
				$('#oib').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});

				$('#ime').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});

				$('#prezime').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});
				
				$('#adresa').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});
				
				$('#mjesto').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});
				
				$('#telefon').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});


				$('#mobitel').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});

				$('#email').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});

				$('#korisnickoime').tooltipster({
					position : 'right',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});

				$('#lozinka').tooltipster({
					position : 'right',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});
				
				$("#oib").focusout(function() {

					$.ajax({
						type : "POST",
						url : "../../provjeraOib.php",
						data : "oib=" + $('#oib').val(),
						cache : false,
						success : function(data) {
							//alert(data);
							if (data == "POSTOJI") {
								$('#oib').tooltipster('content', 'Ovaj OIB se koristi.');
								$('#oib').tooltipster('show');
								$('#oib').focus();
								return false;

							}
						}
					});

				});

				$("#email").focusout(function() {

					$.ajax({
						type : "POST",
						url : "../../provjeraEmail.php",
						data : "email=" + $('#email').val(),
						cache : false,
						success : function(data) {
							//alert(data);
							if (data == "POSTOJI") {
								$('#email').tooltipster('content', 'Ovaj E-mail se koristi.');
								$('#email').tooltipster('show');
								$('#email').focus();
								return false;

							}
						}
					});

				});

				$("#korisnickoime").focusout(function() {

					$.ajax({
						type : "POST",
						url : "../../provjeraKorisnickoIme.php",
						data : "korisnickoime=" + $('#korisnickoime').val(),
						cache : false,
						success : function(data) {
							//alert(data);
							if (data == "POSTOJI") {
								$('#korisnickoime').tooltipster('content', 'Ovo korisničko ime je zauzeto.');
								$('#korisnickoime').tooltipster('show');
								$('#korisnickoime').focus();
								return false;

							}
						}
					});

				});


				

				$('#dodajKlijenta').click(function(event) {
					
					event.preventDefault();
					
					//PROVJERA OIBA

					var oib = $('#oib').val();
					var oib_regex = /^[0-9]{11}$/;

					if (oib.length == 0) {

						$('#oib').tooltipster('content', 'Ovo polje je obavezno.');
						$('#oib').tooltipster('show');
						$('#oib').focus();
						return false;
					}

					if (!oib.match(oib_regex)) {

						$('#oib').tooltipster('content', 'Unesite 11 znamenki.');
					//	$('#oib').tooltipster('content', $('<a href="http://oib.oib.hr/SaznajOibWeb/fizickaOsoba.html">OIB</a>'));
						$('#oib').tooltipster('show');
						$('#oib').focus();

						return false;
					}

					//PROVJERA IMENA

					var ime = $('#ime').val();
					var ime_regex = /^[a-zA-Z ćĆčČđĐšŠžŽ]{2,50}$/;

					if (ime.length == 0) {

						$('#ime').tooltipster('content', 'Ovo polje je obavezno.');
						$('#ime').tooltipster('show');
						$('#ime').focus();
						return false;
					}

					if (!ime.match(ime_regex)) {

						$('#ime').tooltipster('content', 'Dozvoljena samo slova. 2-50');
						$('#ime').tooltipster('show');
						$('#ime').focus();
						return false;
					}

					//PROVJERA PREZIMENA

					var prezime = $('#prezime').val();
					var prezime_regex = /^[a-zA-Z ćĆčČđĐšŠžŽ]{2,50}$/;

					if (prezime.length == 0) {

						$('#prezime').tooltipster('content', 'Ovo polje je obavezno.');
						$('#prezime').tooltipster('show');
						$('#prezime').focus();

						return false;
					}

					if (!prezime.match(prezime_regex)) {

						$('#prezime').tooltipster('content', 'Dozvoljena samo slova. 2-50');
						$('#prezime').tooltipster('show');
						$('#prezime').focus();

						return false;
					}
					
						//PROVJERA ADRESE

					var adresa = $('#adresa').val();
					var adresa_regex = /^[a-zA-Z0-9ćĆčČđĐšŠžŽ .]{6,50}$/;

				
					if (adresa.length > 0 && !adresa.match(adresa_regex)) {

						$('#adresa').tooltipster('content', 'Dozvoljena samo slova i brojevi. 6-50');
						$('#adresa').tooltipster('show');
						$('#adresa').focus();
						return false;
					}
					
						//PROVJERA TELEFONA

					var telefon = $('#telefon').val();
					var telefon_regex = /^[(]{0,1}[0-9]{3}[)]{0,1}[-\s\.]{0,1}[0-9]{3}[-\s\.]{0,1}[0-9]{3,4}$/;

					if (telefon.length > 0 && !telefon.match(telefon_regex)) {
						$('#telefon').tooltipster('content', 'Dozvoljeni samo brojevi. 9-10');
						$('#telefon').tooltipster('show');
						$('#telefon').focus();
						return false;

					}

					//PROVJERA MOBITELA

					var mobitel = $('#mobitel').val();
					var mobitel_regex = /^[(]{0,1}[0-9]{3}[)]{0,1}[-\s\.]{0,1}[0-9]{3}[-\s\.]{0,1}[0-9]{3,4}$/;

					if (mobitel.length == 0) {
						$('#mobitel').tooltipster('content', 'Ovo polje je obavezno.');
						$('#mobitel').tooltipster('show');
						$('#mobitel').focus();

						return false;
					}

					if (!mobitel.match(mobitel_regex)) {
						$('#mobitel').tooltipster('content', 'Dozvoljeni samo brojevi. 9-10');
						$('#mobitel').tooltipster('show');
						$('#mobitel').focus();
						return false;

					}

					//PROVJERA EMAILA

					var email = $('#email').val();
					var email_regex = /^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i;

					if (email.length == 0) {
						$('#email').tooltipster('content', 'Ovo polje je obavezno.');
						$('#email').tooltipster('show');
						$('#email').focus();

						return false;
					}

					if (!email.match(email_regex)) {
						$('#email').tooltipster('content', 'Niste unijeli valjani e-mail.');
						$('#email').tooltipster('show');
						$('#email').focus();
						return false;

					}

					//PROVJERA KORISNIČKOG IMENA

					var korisnickoime = $('#korisnickoime').val();
					var korisnickoime_regex = /^[a-zA-Z0-9]{6,15}$/;

					if (korisnickoime.length == 0) {
						$('#korisnickoime').tooltipster('content', 'Ovo polje je obavezno.');
						$('#korisnickoime').tooltipster('show');
						$('#korisnickoime').focus();

						return false;
					}

					if (!korisnickoime.match(korisnickoime_regex)) {
						$('#korisnickoime').tooltipster('content', 'Dozvoljena slova i brojevi. 6-15');
						$('#korisnickoime').tooltipster('show');
						$('#korisnickoime').focus();
						return false;

					}

					//PROVJERA LOZINKE

					var lozinka = $('#lozinka').val();
					var lozinka_regex = /^[a-zA-Z0-9]{8,15}$/;

					if (lozinka.length == 0) {
						$('#lozinka').tooltipster('content', 'Ovo polje je obavezno.');
						$('#lozinka').tooltipster('show');
						$('#lozinka').focus();
						return false;
					}

					if (!lozinka.match(lozinka_regex)) {

						$('#lozinka').tooltipster('content', 'Dozvoljena slova i brojevi. Minimalno 8 znakova.');
						$('#lozinka').tooltipster('show');
						$('#lozinka').focus();
						return false;
					}
					
					
				var forma = $("#myform");
				
				var podaci = forma.serialize();
				
				var url = forma.attr('action');
				
				var alertBox = $('.alertKlijentDodan');

				//alert(podaci);

					
					$.ajax({
						type : "POST",
						url : url,
						data : podaci,
						cache : false,
						success : function(data) {

							if (data == "OK") {

								setTimeout(function() {
									$(alertBox).fadeIn(500);
								}, 1000);

							}

						}
					});
					
					

					
				});
			});

		</script>
		
		
		
	</body>
</html>