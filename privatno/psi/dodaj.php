<?php
include_once '../../konfiguracija.php';

$izraz = $veza -> prepare("select * from pasmina");
$izraz -> execute();
$pasmina = $izraz -> fetchAll(PDO::FETCH_OBJ);

$izraz = $veza -> prepare("select a.sifra,b.ime,b.prezime from klijent a inner join osoba b on a.osoba=b.sifra");
$izraz -> execute();
$klijent = $izraz -> fetchAll(PDO::FETCH_OBJ);


?>

<!doctype html>
<html class="no-js" lang="en">
	<head>
		<?php
		include_once '../../head.php';
	?>
	</head>
	<body spellcheck="false">

		<?php
		include_once '../../zaglavlje.php';
	?>
		
		
		<div class="row">
			<div class="large-12 columns">
				<h4><i class="fi-guide-dog"></i> Novi pas</h4>
				<hr />
			</div>
		</div>

		<div class="row">
			<div class="large-4 columns">
				
			
			<form id="myform" action="dodajPsa.php" method="post" accept-charset="utf-8" >

					<label for="ime">Ime</label>
					<input id="ime" type="text" name="ime">

					<label for="pasmina">Pasmina</label>
					<select id="pasmina" name="pasmina">
						
						<option id="nemaSlike.png" value = "0">--------------------------------------------------</option>
								
						<?php
						foreach ($pasmina as $p) : ?>

						 <option id="<?php echo $p -> slika; ?>" value="<?php echo $p -> sifra; ?>"><?php echo $p -> naziv; ?></option>

						<?php endforeach; ?>
					</select>

					<label for="klijent">Klijent</label>
					<select id="klijent" name="klijent">
						
						<option value = "0">--------------------------------------------------</option>
								
								
						<?php
						foreach ($klijent as $k) : ?>

						 <option value="<?php echo $k -> sifra; ?>"><?php echo $k -> ime ." ". $k->prezime; ?></option>

					<?php endforeach; ?>
					</select>
					
					
					<ul class="button-group round">
					<li><a href="index.php" class="round button alert tipkanazad"><i class="fi-arrow-left"></i> Nazad</a></li>
					<li><a href="#" id="dodajPsa" type="submit" class="round button success tipkaspremi"><i class="fi-save"></i> Spremi</a></li>
					
					
					</ul>
					
					</form>
					
						<div data-alert class="alert-box success radius alertPasDodan" style="display: none;">
  									Pas uspješno dodan.
 									 <a href="#" class="close"></a>
									</div>	

				
					
					</div>
					<div class="large-4 columns end">
						
						<img id="preview" src="<?php echo $putanjaApp; ?>img/pasmine/nemaSlike.png" alt="your image" />
			</div>
		</div>
		<br />
		<br />
		<br />
		<br />

		<?php
		include_once '../../podnozje.php';
		?>

		<?php
		include_once '../../skripte.php';
		?>
		
		<script>
			$(document).ready(function($) {

						$(window).keypress(function() {
					$('#ime').tooltipster('hide');
					$('#pasmina').tooltipster('hide');
					$('#klijent').tooltipster('hide');
					$('.alert-box').fadeOut();
					
				});

				$(window).click(function() {
					$('#ime').tooltipster('hide');
					$('#pasmina').tooltipster('hide');
					$('#klijent').tooltipster('hide');
					$('.alert-box').fadeOut();

				});

				$('#pasmina').change(function(){
    			var slika = $(this).find('option:selected').attr('id')
    			$("#preview").attr('src',"<?php echo $putanjaApp; ?>img/pasmine/"+slika);
    			
				});
				
				$('#ime').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

					});
				
				$('#pasmina').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

					});
					
				$('#klijent').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

					});
				

				$('#dodajPsa').click(function(event) {
					
						event.preventDefault();
					
				//PROVJERA IMENA

					var ime = $('#ime').val().trim();
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
					
						//PROVJERA PASMINE
				
				var selektiranaPasmina = $('#pasmina').val();

					if (selektiranaPasmina == 0) {

						$('#pasmina').tooltipster('content', 'Niste odabrali pasminu.');
						$('#pasmina').tooltipster('show');

						return false;
					}
					
				//PROVJERA KLIJENTA
				
				var selektiraniKlijent = $('#klijent').val();

					if (selektiraniKlijent == 0) {

						$('#klijent').tooltipster('content', 'Niste odabrali klijenta.');
						$('#klijent').tooltipster('show');

						return false;
					}
					
					
				var forma = $("#myform");
				
				var podaci = forma.serialize();
				
				var url = forma.attr('action');
				
				var alertBox = $('.alertPasDodan');

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