<?php
include_once '../../konfiguracija.php';

if (!isset($_SESSION[$ida . "operater"]) || $_SESSION[$ida . "operater"]->uloga != "administrator") {
	header("location: ../../odjavi.php");
}

if (!((isset($_GET["sifra"]) && ctype_digit($_GET["sifra"])) || isset($_POST["sifra"]))) {
	header("location: ../../odjavi.php");
}else{
	if(isset($_GET["sifra"])){
		$sifra=$_GET["sifra"];
	}else{
		$sifra=$_POST["sifra"];
	}
}

$izraz = $veza -> prepare("select * from mjesto");
				$izraz -> execute();
				$mjesto = $izraz -> fetchAll(PDO::FETCH_OBJ);

$izraz = $veza -> prepare("select a.*,b.*,c.* from operater a inner join klijent b on a.sifra=b.operater inner join osoba c on b.osoba=c.sifra where b.sifra=:sifra");
$izraz->bindParam("sifra",$sifra);
$izraz -> execute();
$klijent = $izraz -> fetch(PDO::FETCH_OBJ);

?>
<!doctype html>
<html class="no-js" lang="en">
	<head>
		<?php include_once '../../head.php';?>
		<link rel="stylesheet" href="<?php echo $putanjaApp; ?>strength/styled/strength.css" />
		<link rel="stylesheet" href="<?php echo $putanjaApp; ?>tooltipster/css/tooltipster.css"/>
	</head>
	<body>

		<?php include_once '../../zaglavlje.php';?>
		
		<div class="row">
			<div class="large-12 columns">
				<h4><i class="fi-torso-business"></i> Klijent: <?php echo $klijent -> ime . ' ' . $klijent -> prezime ?></h4>
				<hr />
			</div>
		</div>

		<div class="row">
			<div class="large-4 columns">
				
			
			<form id="myform" action="promjeniKlijenta.php" method="post" accept-charset="utf-8" >

					<label for="oib">OIB</label>
					<input id="oib" type="text" name="oib" maxlength="11" value="<?php echo $klijent -> oib; ?>">

					<label for="ime">Ime</label>
					<input id="ime" type="text" name="ime" value="<?php echo $klijent -> ime; ?>">

					<label for="ime">Prezime</label>
					<input id="prezime" type="text" name="prezime" value="<?php echo $klijent -> prezime; ?>" >

					<label for="adresa">Adresa</label>
					<input id="adresa" type="text" name="adresa" value="<?php echo $klijent -> adresa; ?>" >

					<label for="mjesto">Mjesto</label>
					<select id="mjesto" name="mjesto">
						<option value = "0"></option>
						
								
						<?php
						foreach ($mjesto as $m) : ?>

						 <option value="<?php echo $m -> sifra; ?>" <?php if($m -> sifra == $klijent->mjesto): ?> selected="selected"<?php endif; ?>><?php echo $m -> naselje; ?></option>

						<?php endforeach; ?>
					</select>
					
					<label for="telefon">Telefon</label>
					<input id="telefon" type="text" name="telefon" value="<?php echo $klijent -> telefon; ?>">

					<label for="mobitel">Mobitel</label>
					<input id="mobitel" type="text" name="mobitel" value="<?php echo $klijent -> mobitel; ?>">

					<label for="email">E-mail</label>
					<input id="email" type="text" name="email" value="<?php echo $klijent -> email; ?>">
					
					</div>
				
					<div class="large-4 columns">	
					
					<label for="korisnickoime">Korisničko ime</label>
					<input id="korisnickoime" type="text" name="korisnickoime" value="<?php echo $klijent -> korisnickoime; ?>">

					<label for="uloga">Uloga</label>
					<select id="uloga" name="uloga">
					<option value = "korisnik" <?php if($klijent -> uloga == "korisnik"): ?> selected="selected"<?php endif; ?>>Korisnik</option>
					<option value = "administrator" <?php if($klijent -> uloga == "administrator"): ?> selected="selected"<?php endif; ?>>Administrator</option>
					</select>
					
					
										<label>Aktivan</label>	
<div class="switch">
  <input id="aktivan" name="aktivan" type="checkbox" <?php
					if ($klijent -> aktivan == 1) { echo "checked";}?>>
  <label for="aktivan"></label>
</div> 
				
									
					<input type="hidden" name="sifra" value="<?php echo $klijent->sifra;?>" />
					<input type="hidden" name="sifraOsobe" value="<?php echo $klijent->osoba;?>" />
					<input type="hidden" name="sifraOperatera" value="<?php echo $klijent->operater;?>" />
	
									
					<div class="row collapse prefix-radius">
											<div class="large-5 columns">
												<span class="prefix">Datum unosa</span>
											</div>
											<div class="large-7 columns">
											<?php
											$date = date_create($klijent -> datumunosa);
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
											$date = date_create($klijent -> datumpromjene);
											?>
												<input id="datumpromjene" name="datumpromjene" type="text" disabled="disabled" value="<?php echo date_format($date, 'd.m.Y. H:i:s'); ?>">
											</div>
										</div>
										
										<input type="hidden" name="sifra" id="sifra" value="<?php echo $klijent->sifra;?>" />
					<input type="hidden" name="sifraOsobe" id="sifraOsobe" value="<?php echo $klijent->osoba;?>" />
					<input type="hidden" name="sifraOperatera" id="sifraOperatera" value="<?php echo $klijent->operater;?>" />
								
									<ul class="button-group round">
					<li><a href="index.php" class="round button alert tipkanazad"><i class="fi-arrow-left"></i> Nazad</a></li>
					<li><a href="#" id="promjeniKlijenta" type="submit" class="round button success tipkaspremi"><i class="fi-save"></i> Spremi</a></li>
					</ul>	
					
					<div data-alert class="alert-box success radius alertZaposlenikPromjenjen" style="display: none;">
  									Podaci uspješno promjenjeni.
 									 <a href="#" class="close"></a>
									</div>
					
					</form>				
					
					</div>
					
					<div class="large-4 columns">

				
					
					
									
									<ul class="accordion" data-accordion>
							<li class="accordion-navigation">
								<a href="#panel0a"><i class="fi-key"> </i>Promjena lozinke</a>
								<div id="panel0a" class="content">

									<form id="formaZaPromjenuLozinke" action="promjeniLozinku.php" method="post" accept-charset="utf-8" >

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
												<span class="prefix">PN lozinka</span>
											</div>
											<div class="small-7 columns">
												<input id="ponovoNovaLozinka" name="ponovoNovaLozinka" type="password">
											</div>
										</div>

										<a href="#" id="promjeniLozinku" type="submit" class="round button success tipkaspremi1"><i class="fi-save"></i> Spremi</a>
										
											<div data-alert class="alert-box success radius alertLozinkaPromjenjena" style="display: none;">
  									Lozinka uspješno promjenjena.
 									 <a href="#" class="close"></a>
									</div>

									</form>
									
								</div>
							</li>
						</ul>
														
										
					</div>
						
					
					</div>
					

		<?php
	include_once '../../podnozje.php';
		?>

		<?php
	include_once '../../skripte.php';
		?>
		
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
					$('.alert-box').fadeOut();
				
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
				
		$('#promjeniKlijenta').click(function(event) {
			
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

		return false;
		}
		
		
		var oib = $('#oib').val();
		var sifraOsobe = $('#sifraOsobe').val();

		$.ajax({
						type : "POST",
						url : "../zaposlenici/provjeriOib.php",
						data : "oib="+oib+"&sifraOsobe="+sifraOsobe,
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

				
					if (adresa.length > 0 && !adresa.match(adresa_regex)) {

						$('#adresa').tooltipster('content', 'Dozvoljena samo slova i brojevi. 6-50');
						$('#adresa').tooltipster('show');
						return false;
					}
					
						//PROVJERA TELEFONA

					var telefon = $('#telefon').val();
					var telefon_regex = /^[(]{0,1}[0-9]{3}[)]{0,1}[-\s\.]{0,1}[0-9]{3}[-\s\.]{0,1}[0-9]{3,4}$/;

					if (telefon.length > 0 && !telefon.match(telefon_regex)) {
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
					
					var email = $('#email').val();
					var sifraOsobe = $('#sifraOsobe').val();

					$.ajax({
						type : "POST",
						url : "../zaposlenici/provjeriEmail.php",
						data : "email="+email+"&sifraOsobe="+sifraOsobe,
						cache : false,
						success : function(data) {
							//alert(data);
							if (data == "POSTOJI") {
								$('#email').tooltipster('content', 'Ovaj E-mail se koristi.');
								$('#email').tooltipster('show');
								return false;

							}
						}
					});

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
					
					var korisnickoIme = $('#korisnickoime').val();
					var sifraOperatera = $('#sifraOperatera').val();

					$.ajax({
						type : "POST",
						url : "../zaposlenici/provjeriKorisnickoIme.php",
						data : "korisnickoIme="+korisnickoIme+"&sifraOperatera="+sifraOperatera,
						cache : false,
						success : function(data) {
							//alert(data);
							if (data == "POSTOJI") {
								$('#korisnickoime').tooltipster('content', 'Ovo korisničko ime se koristi.');
								$('#korisnickoime').tooltipster('show');
								return false;

							}
						}
					});

				
		
		
		// označavanje forme kojom pristupam
		var forma = $("#myform");
		// kupljenje podataka iz forme
		var podaci = forma.serialize();
		// adresa di je stranica za dodavanje osobe
		var url = forma.attr('action');
		// alert box za moj profil
		var alertBox = $('.alertZaposlenikPromjenjen');
				
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
				
					
 	$('#promjeniLozinku').click(function(event) {

	event.preventDefault();
	
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

	
	var sifra = <?php echo $sifra; ?>	
	var forma = $("#formaZaPromjenuLozinke"); 
	var url = forma.attr('action');
	var alertBox = $('.alertLozinkaPromjenjena');
	
	
	$.ajax({
		type : "POST",
		url : url,
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