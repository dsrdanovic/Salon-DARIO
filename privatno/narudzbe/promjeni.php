<?php

include_once '../../konfiguracija.php';

if (!((isset($_GET["sifra"]) && ctype_digit($_GET["sifra"])) || isset($_POST["sifra"]))) {
	header("location: ../../odjavi.php");
}else{
	if(isset($_GET["sifra"])){
		$sifra=$_GET["sifra"];
	}else{
		$sifra=$_POST["sifra"];
	}
}

	$izraz = $veza -> prepare("select * from narudzba where sifra=:sifra");
	$izraz -> bindParam(":sifra", $sifra);
	$izraz -> execute();
	$narudzba = $izraz -> fetch(PDO::FETCH_OBJ);

	$izraz = $veza -> prepare("select a.narudzba as sifraNarudzbe,a.usluga,a.cijena,b.naziv as nazivUsluge,b.sifra as sifraUsluge from narudzba_usluga a inner join usluga b on a.usluga=b.sifra where narudzba=:sifra");
	$izraz->bindParam("sifra",$_GET["sifra"]);
	$izraz -> execute();
	$narudzba_usluga = $izraz -> fetchAll(PDO::FETCH_OBJ);
	
	$izraz = $veza -> prepare("select * from usluga");
	$izraz -> execute();
	$usluga = $izraz -> fetchAll(PDO::FETCH_OBJ);
	
	$sifraOperatera = $_SESSION[$ida . "operater"]->sifra;
	$izraz = $veza -> prepare("select * from zaposlenik where operater=:sifraOperatera");
	$izraz->bindParam(':sifraOperatera',$sifraOperatera);
	$izraz -> execute();
	$zaposlenik = $izraz -> fetch(PDO::FETCH_OBJ);


 ?>
<!doctype html>
<html class="no-js" lang="en">
	<head>
		<?php
		include_once '../../head.php';
		?>
		
		<link rel="stylesheet" href="<?php echo $putanjaApp; ?>css/jquery-ui.css" />
	</head>
	<body spellcheck="false">

		<?php
		include_once '../../zaglavlje.php';
		?>

		<div class="row">
			<div class="large-12 columns">
				<h4><i class="fi-page-edit"></i> Promjena narudžbe</h4>
		<hr />
			</div>
		</div>
			
	
		
		<div class="row">
		<div class="large-4 columns">
			
		<form id="myform" action="promjeniNarudzbu.php" method="post">
			
		<label for="datumnarudzbe">Datum narudžbe</label>
		<?php $date = date_create($narudzba -> datumnarudzbe); ?>	
		<input id="datumnarudzbe" type="text" name="datumnarudzbe" value="<?php echo date_format($date, 'd.m.Y.'); ?>">
		
		<label for="termin">Termin(h)</label>
		<select id="termin" name="termin">
		<?php
		$termini = array("07:00","07:30","08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00",
		"13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00");
		?>
		<?php foreach ($termini as $t): ?>
			<option <?php if($narudzba->termin==$t){echo 'selected="selected"'; }  ?> ><?php echo $t;  ?></option>
		<?php endforeach ?>					
			</select>	
			
		<label for="dan">Dan</label>	
		<input id="dan" type="text" name="dan" value="<?php echo $narudzba->dan; ?>">	
		<!--
		<label for="status">Status</label>	
		<input type="checkbox" name="status"/>
		-->
<label>Status</label>	
<div class="switch">
  <input id="status" name="status" type="checkbox">
  <label for="status"></label>
</div> 
		
		
			<div class="row collapse prefix-radius">
											<div class="large-5 columns">
												<span class="prefix">Datum unosa</span>
											</div>
											<div class="large-7 columns">
											<?php
											$date = date_create($narudzba -> datumunosa);
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
											$date = date_create($narudzba -> datumpromjene);
											?>
												<input id="datumpromjene" name="datumpromjene" type="text" disabled="disabled" value="<?php echo date_format($date, 'd.m.Y. H:i:s'); ?>">
											</div>
										</div>
										
				
		
				<ul class="button-group round">
					<li><a href="index.php" class="round button alert tipkanazad"><i class="fi-arrow-left"></i> Nazad</a></li>
					<li><a href="#" id="promjeniNarudzbu" type="submit" class="round button success tipkaspremi"><i class="fi-save"></i> Spremi</a></li>
					</ul>
					
					<div data-alert class="alert-box success radius alertNarudzbaPromjenjena" style="display: none;">
  									Narudžba uspješno promjenjena.
 									 <a href="#" class="close"></a>
									</div>

		
		
		</div>
		
		
		<div class="large-4 columns end">

<table class="reference">
<tbody>
	<tr>
	<th>Odabrane usluge</th>
	<th>Cijena(HRK)</th>


</tr>
			
			<?php foreach ($usluga as $u): ?>

<tr>
	<td >
	 <input type="checkbox" name="usluga[]" value="<?php echo $u->sifra; ?>"
	 <?php foreach ($narudzba_usluga as $nu){if($u->sifra==$nu->sifraUsluge) echo 'checked="checked"'; }?> /> <?php echo $u->naziv; ?>
	
	</td>
	<td style="width:20%">
	<input type="text" id="cijena" class="cijena" name="cijena_<?php echo $u->sifra;?>" value="<?php foreach ($narudzba_usluga as $nu){
		if($u->sifra==$nu->sifraUsluge){
			if($nu->cijena=="" || $nu->cijena=="0.00"){
				echo "";
			}else{
				echo $nu->cijena; 
			}
		} 
			}
		?>" />
		</td>
</tr>   

			<?php endforeach ?>
			
<tr>
	<td><b>Ukupno:</b></td>
	<td>
	<span class="ukupno"></span>

	</td>

</tr>
			
	</tbody>
</table>
				
			
		<input type="hidden" name="sifraZaposlenika" value="<?php echo $zaposlenik->sifra; ?>" />	
		<input type="hidden" id="sifra" name="sifra" value="<?php echo $narudzba->sifra; ?>" />
		</form>	
			

		</div>

		
		</div>

	

		<?php
		include_once '../../podnozje.php';
		?>

		<?php
		include_once '../../skripte.php';
		?>
	
		<script src="<?php echo $putanjaApp; ?>js/vendor/jquery-ui.js"></script>
		
		
		<script>
		
		$(document).ready(function(){
			$(".cijena").each(function(){
				$(this).keyup(function(){
					calculateSum();
							});
						});
					});
					
		function calculateSum(){
			var sum=0;$(".cijena").each(function(){
				if(!isNaN(this.value)&&this.value.length!=0){
					sum+=parseFloat(this.value);
					}});
		$(".ukupno").html(sum.toFixed(2));
			}

		

		
		
		
		$('#promjeniNarudzbu').click(function(event) {
					
				event.preventDefault();
									
				var forma = $("#myform");
				
				var podaci = forma.serialize();
				
				var url = forma.attr('action');
				
				var alertBox = $('.alertNarudzbaPromjenjena');

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
							
							
							//alert("Narudžba promjenjena."); 

							}
							
							

						}
					});

				});
		
		
		
		
		$('#klijenti').on('change', function(e) {
			
		var forma = $("#formaSifraKlijenta");		
	
		forma.submit();
	
		var podaci = forma.serialize();
				
		var url = forma.attr('action');
 		
 		$.ajax({
					type : "POST",
						url : url,
						data : podaci,
						cache : false,
						success: function() {
     
       					 }
				});
		
		
		});
		
		
		
					$(document).foundation();  
	$('a.obrisi').click(function(){
    var link = $('.deleteUrl');
    $(link).attr('href', this.href);
    
 	
});


		$(function() {
			
			
			$(".detalji").click(function(){
				//alert($(this).attr("id"));
				
				$.ajax({
						type : "GET",
						url : "pokupiDetalje.php?sifra=" + $(this).attr("id"),
						cache : false,
						success : function(data) {

							$("#kontejner").html(data);
							$('#modalDetalji').foundation('reveal','open');
						}
					});
				
				
				
				
				return false;
			});

				$.datepicker.regional['hr'] = {
					closeText : 'Zatvori',
					prevText : 'Prethodni',
					nextText : 'Sljedeći',
					currentText : 'Trenutni',
					monthNames : ['Siječanj', 'Veljača', 'Ožujak', 'Travanj', 'Svibanj', 'Lipanj', 'Srpanj', 'Kolovoz', 'Rujan', 'Listopad', 'Studeni', 'Prosinac'],
					monthNamesShort : ['sij', 'velj', 'ožu', 'tra', 'svi', 'lip', 'srp', 'kol', 'ruj', 'lis', 'stu', 'pro'],
					dayNames : ['Nedjelja', 'Ponedjeljak', 'Utorak', 'Srijeda', 'Četvrtak', 'Petak', 'Subota'],
					dayNamesShort : ['ned', 'pon', 'uto', 'sri', 'čet', 'pet', 'sub'],
					dayNamesMin : ['Ned', 'Pon', 'Uto', 'Sri', 'Čet', 'Pet', 'Sub'],
				//	weekHeader : 'Tjedan',
					dateFormat : 'dd.mm.yy.',
					firstDay : 1,
				//	isRTL : false,
					showOtherMonths : true,
				//	showMonthAfterYear : true,
				//	yearSuffix : '',
				//	changeMonth : true,
				//	changeYear : true,
					showButtonPanel : true,
				//	yearRange : '1940:2020',
					onSelect: function(date) {
                // work out selected date 
                var dateSelect = $(this).datepicker('getDate'); //used below

                var dayOfWeek = $.datepicker.formatDate('DD', dateSelect); //shows Monday
                $("#dan").val(dayOfWeek);

              
            }
				};
				$.datepicker.setDefaults($.datepicker.regional['hr']);

				 var datum = document.getElementById('datumnarudzbe').value;
			//	$("#datumnarudzbe").datepicker({ minDate: 0 });
				$("#datumnarudzbe").datepicker();
				
				 $("#datumnarudzbe").datepicker("option", $.datepicker.regional['hr']);
				 $("#datumnarudzbe").val(datum);
				 
			});
		

			$(document).ready(function($) {
				
					$(window).keypress(function() {
					$('#datumnarudzbe').tooltipster('hide');
			
				});

				$(window).click(function() {
					$('#datumnarudzbe').tooltipster('hide');

				});

				$('#idiNaDrugiKorak').click(function(event) {

					event.preventDefault();
					
					$(".panelDrugiKorak").css('display','none');					
					$(".ui-progressbar-value").animate({width:"66%"});
					$("#drugiKorak").css({opacity: 0.0, visibility: "visible"}).animate({opacity: 1.0}, 2000);
					$('#prviKorak').css({opacity: 1.0, visibility: "visible"}).animate({opacity: 0}, 2000);
					$(".panelPrviKorak").css('display','block');
					

				

				});
				
					$('#datumnarudzbe').tooltipster({
					position : 'right',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});
				
				$('#idiNaTreciKorak').click(function(event) {
					
					event.preventDefault();
					
						// PROVJERA DATUMA NARUDŽBE
					
					var datumNarudzbe = $('#datumnarudzbe').val();
				//	alert(datumNarudzbe);

					if (datumNarudzbe.length == 0) {

						$('#datumnarudzbe').tooltipster('content', 'Ovo polje je obavezno.');
						$('#datumnarudzbe').tooltipster('show');
						return false;
					}
					
					$(".ui-progressbar-value").animate({width:"100%"});
					$("#treciKorak").css({opacity: 0.0, visibility: "visible"}).animate({opacity: 1.0}, 2000);
					$('#drugiKorak').css({opacity: 1.0, visibility: "visible"}).animate({opacity: 0}, 2000);
					$(".panelDrugiKorak").css('display','block');
					$(".panelTreciKorak").css('display','none');
				

				});
				
				$('#idiNaPrviKorak').click(function(event) {
					
					event.preventDefault();
					
					$(".ui-progressbar-value").animate({width:"31.5%"});
					$('#prviKorak').css({opacity: 0.0, visibility: "visible"}).animate({opacity: 1.0}, 2000);
					$('#drugiKorak').css({opacity: 1.0, visibility: "visible"}).animate({opacity: 0}, 2000);
					$(".panelDrugiKorak").css('display','block');
					$(".panelPrviKorak").css('display','none');
					
				

				});
				
				$('#idiNaDrugiKorak1').click(function(event) {

					event.preventDefault();
					$(".panelDrugiKorak").css('display','none');
					$('#drugiKorak').css({opacity: 0.0, visibility: "visible"}).animate({opacity: 1.0}, 2000);
					$(".panelTreciKorak").css('display','block');										
					$("#treciKorak").css({opacity: 1.0, visibility: "visible"}).animate({opacity: 0.0}, 2000);
					$(".ui-progressbar-value").animate({width:"66%"});
					
					
				
				

				});
				
				
				
				$('.naruci').click(function(event) {

					event.preventDefault();
					
				
					
					var forma = $("#myform");
					var podaci = forma.serialize();
					var url = forma.attr('action');
					//alert(podaci+" "+url+" "+forma);

					$.ajax({
						type : "POST",
						url : url,
						data : podaci,
						cache : false,
						success : function(data) {

							if (data == "OK") {

								alert("Narudžba zaprimljena!");
							}

						}
					});
					

				

				});
				
				
			

			});

		</script>
		
		
		
	</body>

</html>
