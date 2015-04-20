<?php
include_once 'konfiguracija.php';
?>

<!doctype html>
<html class="no-js" lang="en">
	<head>

		<?php
		include_once 'head.php';
		?>
		
	</head>

	<body>

		<?php
		include_once 'zaglavlje.php';
		?>

		<?php
		include_once 'slider.php';
		?>

		<div class="row">
			<div class="large-12 columns">
		
				<h3>Dobrodošli !</h3>
				<hr />
				<div class="row" data-equalizer="">
					<div class="large-4 columns">
						<ul class="pricing-table">
							<li class="title">
								Šišanje
							</li>
							<li class="price">
								<img class="sisanjelogo" src="img/sisanjelogo.png" alt=""/>
							</li>
							<li class="bullet-item">
								∞ Databases
							</li>
							<li class="bullet-item">
								∞ Storage
							</li>
							<li class="bullet-item">
								∞ Users
							</li>
							<li class="bullet-item">
								SSL Support
							</li>
							<li class="bullet-item">
								24/7 Support
							</li>
							<li class="cta-button">
								
								<a class="button narucise" href="#">Naruči se</a>
								
							</li>
						</ul>
						<br>
					</div>
					<div class="large-4 columns">
						<ul class="pricing-table" data-equalizer-watch="" style="height: 378px;">
							<li class="title">
								Kupanje
							</li>
							<li class="price">
								<img class="kupanjelogo" src="img/kupanjelogo.png" alt=""/>
							</li>
							<li class="bullet-item">
								∞ Databases
							</li>
							<li class="bullet-item">
								∞ Storage
							</li>
							<li class="bullet-item">
								∞ Users
							</li>
							<li class="bullet-item">
								SSL Support
							</li>
							<li class="bullet-item">
								24/7 Support
							</li>
							<li class="cta-button">
								<a class="button narucise" href="#">Naruči se</a>
							</li>
						</ul>
						<br>
					</div>
					<div class="large-4 columns">
						<ul class="pricing-table" data-equalizer-watch="" style="height: 378px;">
							<li class="title">
								Češljanje
							</li>
							<li class="price">
								<img class="cesljanjelogo" src="img/cesljanjelogo.png" alt=""/>
							</li>
							<li class="bullet-item">
								∞ Databases
							</li>
							<li class="bullet-item">
								∞ Storage
							</li>
							<li class="bullet-item">
								∞ Users
							</li>
							<li class="bullet-item">
								SSL Support
							</li>
							<li class="bullet-item">
								24/7 Support
							</li>
							<li class="cta-button">
								<a class="button narucise" href="#">Naruči se</a>
							</li>
						</ul>
						<br>
					</div>
					<div class="large-4 columns">
						<ul class="pricing-table" data-equalizer-watch="" style="height: 378px;">
							<li class="title">
								Rezanje noktiju
							</li>
							<li class="price">
								<img class="rezanjelogo" src="img/rezanjelogo.png" alt=""/>
							</li>
							<li class="bullet-item">
								∞ Databases
							</li>
							<li class="bullet-item">
								∞ Storage
							</li>
							<li class="bullet-item">
								∞ Users
							</li>
							<li class="bullet-item">
								SSL Support
							</li>
							<li class="bullet-item">
								24/7 Support
							</li>
							<li class="cta-button">
								<a class="button narucise" href="#">Naruči se</a>
							</li>
						</ul>
						<br>
					</div>
					<div class="large-4 columns">
						<ul class="pricing-table" data-equalizer-watch="" style="height: 378px;">
							<li class="title">
								Brijanje šapica
							</li>
							<li class="price">
								<img class="rezanjelogo" src="img/sapicelogo.png" alt=""/>
							</li>
							<li class="bullet-item">
								∞ Databases
							</li>
							<li class="bullet-item">
								∞ Storage
							</li>
							<li class="bullet-item">
								∞ Users
							</li>
							<li class="bullet-item">
								SSL Support
							</li>
							<li class="bullet-item">
								24/7 Support
							</li>
							<li class="cta-button">
								<a class="button narucise" href="#">Naruči se</a>
							</li>
						</ul>
						<br>
					</div>
					<div class="large-4 columns">
						<ul class="pricing-table" data-equalizer-watch="" style="height: 378px;">
							<li class="title">
								Izbrijavanje
							</li>
							<li class="price">
								<img class="rezanjelogo" src="img/izbrijavanjelogo.png" alt=""/>
							</li>
							<li class="bullet-item">
								∞ Databases
							</li>
							<li class="bullet-item">
								∞ Storage
							</li>
							<li class="bullet-item">
								∞ Users
							</li>
							<li class="bullet-item">
								SSL Support
							</li>
							<li class="bullet-item">
								24/7 Support
							</li>
							<li class="cta-button">
								<a class="button narucise" href="#">Naruči se</a>
							</li>
						</ul>
						<br>
					</div>
				</div>
			</div>
		</div>
		<?php
		include_once 'podnozje.php';
		include_once 'modalNisteLogirani.php';
		?>
		

		<?php
		include_once 'skripte.php';
		?>
		
		<script>
			$(document).ready(function($) {

				$(".button").click(function() {
					$.ajax({				
						url : "provjeriLogin.php",
						cache : false,
						success : function(data) {
							//alert(data);
							if (data == "KORISNIK") {
								window.location = 'mojeNarudzbe.php';							
							}else if (data == "ADMINISTRATOR"){
								window.location = 'privatno/narudzbe/index.php';
							}else if (data == "FAIL"){								
								$("#modalNisteLogirani").foundation('reveal','open');
							}
						}
					});
				});

				});
		</script>

	</body>
</html>
