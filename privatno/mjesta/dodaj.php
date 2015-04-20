<?php
include_once '../../konfiguracija.php';
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
				<h4><i class="fi-target"></i> Novo mjesto</h4>
				<hr />
			</div>
		</div>

		<div class="row">
			<div class="large-4 columns">
				
			
			<form id="myform" action="dodajMjesto.php" method="post" accept-charset="utf-8" >

					<label for="naselje">Naselje</label>
					<input id="naselje" type="text" name="naselje">

					<label for="postanskibroj">Poštanski broj</label>
					<input id="postanskibroj" type="text" name="postanskibroj">

					<label for="opcina">Općina</label>
					<input id="opcina" type="text" name="opcina">

					<label for="zupanija">Županija</label>
					<input id="zupanija" type="text" name="zupanija">
					
					<ul class="button-group round">
					<li><a href="index.php" class="round button alert tipkanazad"><i class="fi-arrow-left"></i> Nazad</a></li>
					<li><a href="#" id="dodajMjesto" type="submit" class="round button success tipkaspremi"><i class="fi-save"></i> Spremi</a></li>					
					</ul>
					
					</form>
					
						<div data-alert class="alert-box success radius alertMjestoDodano" style="display: none;">
  									Mjesto uspješno dodano.
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
					$('#naselje').tooltipster('hide');
					$('.alert-box').fadeOut();
					
				});

				$(window).click(function() {
					$('#naselje').tooltipster('hide');
					$('.alert-box').fadeOut();

				});
				
					$('#naselje').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

					});

				

				$('#dodajMjesto').click(function(event) {
					
					event.preventDefault();
					
						//PROVJERA NASELJA

					var naselje = $('#naselje').val().trim();
					var naselje_regex = /^[a-zA-Z ćĆčČđĐšŠžŽ]{2,50}$/;

					if (naselje.length == 0) {

						$('#naselje').tooltipster('content', 'Ovo polje je obavezno.');
						$('#naselje').tooltipster('show');
						return false;
					}

					if (!naselje.match(naselje_regex)) {

						$('#naselje').tooltipster('content', 'Dozvoljena samo slova. 2-50');
						$('#naselje').tooltipster('show');
						return false;
					}

					
				
				var forma = $("#myform");
			
				var podaci = forma.serialize();
			
				var url = forma.attr('action');
			
				var alertBox = $('.alertMjestoDodano');

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