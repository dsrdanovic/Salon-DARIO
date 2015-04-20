<?php

include_once 'konfiguracija.php';

if (!isset($_SESSION[$ida . "operater"]) || $_SESSION[$ida . "operater"] -> uloga != "korisnik") {
	header("location: index.php");
}

$korisnickoime = $_SESSION[$ida . "operater"] -> korisnickoime;
$izraz = $veza -> prepare("select a.*,b.sifra as sifraKlijenta,b.*,c.*,d.* from operater a inner join klijent b on a.sifra=b.operater inner join osoba c on b.osoba=c.sifra inner join mjesto d on c.mjesto=d.sifra where a.korisnickoime= :korisnickoime");
$izraz -> bindParam(":korisnickoime", $korisnickoime);
$izraz -> execute();
$osoba = $izraz -> fetch(PDO::FETCH_OBJ);

if($osoba==null){

$izraz = $veza -> prepare("select a.*,b.sifra as sifraKlijenta,b.*,c.* from operater a inner join klijent b on a.sifra=b.operater inner join osoba c on b.osoba=c.sifra where a.korisnickoime= :korisnickoime");
$izraz -> bindParam(":korisnickoime", $korisnickoime);
$izraz -> execute();
$osoba = $izraz -> fetch(PDO::FETCH_OBJ);
	
}

$izraz = $veza -> prepare("select * from pasmina");
					$izraz -> execute();
					$pasmina = $izraz -> fetchAll(PDO::FETCH_OBJ);

$izraz = $veza -> prepare("select a.*,b.naziv,b.sifra as sifraPasmine,b.slika as slikaPasmine from pas a inner join pasmina b on a.pasmina=b.sifra where klijent=:sifraKlijenta");
					$sifraKlijenta = $osoba -> sifraKlijenta;
					$izraz -> bindParam(":sifraKlijenta", $sifraKlijenta);
					$izraz -> execute();
					$pas = $izraz -> fetchAll(PDO::FETCH_OBJ);
					
$izraz = $veza -> prepare("select * from usluga");
$izraz -> execute();
$usluga = $izraz -> fetchAll(PDO::FETCH_OBJ);
 ?>
<!doctype html>
<html class="no-js" lang="en">
	<head>
		<?php
		include_once 'head.php';
		?>
		
		<link rel="stylesheet" href="<?php echo $putanjaApp; ?>css/jquery-ui.css" />
	</head>
	<body spellcheck="false">

		<?php
		include_once 'zaglavlje.php';
		?>

		<div class="row">
			<div class="large-12 columns">
				<h4><i class="fi-star"></i> Moje narudžbe</h4>
				<hr />

				<ul class="tabs" data-tab>
					<li class="tab-title active">
						<a href="#panel1"><i class="fi-plus"></i> Nova narudžba</a>
					</li>
					<li class="tab-title">
						<a href="#panel2"><i class="fi-archive"></i> Arhiva</a>
					</li>

				</ul>

			
				

				<div class="tabs-content">
					<div class="content active" id="panel1">
							
				<div id="progressbar" class="ui-progressbar ui-widget ui-widget-content ui-corner-all" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="20">
					<div class="ui-progressbar-value ui-widget-header ui-corner-left" style="width: 31.5%;">
					
				</div>
				</div>
				
						<div class="row">
							<div class="panel panelPrviKorak" style="display:none;">1</div>
							<div class="large-4 columns" id="prviKorak">
							<fieldset class="prvikorak">
			<legend>
				Osobni podaci
			</legend>
								<form id="myform" action="dodajNarudzbu.php" method="post">

						<div class="row collapse prefix-radius">
											<div class="large-4 columns">
												<span class="prefix">OIB</span>
											</div>
											<div class="large-8 columns">
												<input id="oib" name="oib" type="text" disabled="disabled" value="<?php echo $osoba -> oib; ?>">
											</div>
										</div>

					<div class="row collapse prefix-radius">
											<div class="large-4 columns">
												<span class="prefix">Ime</span>
											</div>
											<div class="large-8 columns">
												<input id="ime" name="ime" type="text" disabled="disabled" value="<?php echo $osoba -> ime; ?>">
											</div>
										</div>

					<div class="row collapse prefix-radius">
											<div class="large-4 columns">
												<span class="prefix">Prezime</span>
											</div>
											<div class="large-8 columns">
												<input id="prezime" name="prezime" type="text" disabled="disabled" value="<?php echo $osoba -> prezime; ?>">
											</div>
										</div>

					<div class="row collapse prefix-radius">
											<div class="large-4 columns">
												<span class="prefix">Adresa</span>
											</div>
											<div class="large-8 columns">
												<input id="adresa" name="adresa" type="text" disabled="disabled" value="<?php echo $osoba -> adresa; ?>">
											</div>
										</div>
										
					<div class="row collapse prefix-radius">
											<div class="large-4 columns">
												<span class="prefix">Mjesto</span>
											</div>
											<div class="large-8 columns">
												<input id="mjesto" name="mjesto" type="text" disabled="disabled" value="<?php if(isset($osoba->naselje)) { echo $osoba -> naselje; } else { echo "";  }?>">
											</div>
										</div>

					<div class="row collapse prefix-radius">
											<div class="large-4 columns">
												<span class="prefix">Telefon</span>
											</div>
											<div class="large-8 columns">
												<input id="telefon" name="telefon" type="text" disabled="disabled" value="<?php echo $osoba -> telefon; ?>">
											</div>
										</div>
										
					<div class="row collapse prefix-radius">
											<div class="large-4 columns">
												<span class="prefix">Mobitel</span>
											</div>
											<div class="large-8 columns">
												<input id="mobitel" name="mobitel" type="text" disabled="disabled" value="<?php echo $osoba -> mobitel; ?>">
											</div>
										</div>
										
					<div class="row collapse prefix-radius">
											<div class="large-4 columns">
												<span class="prefix">E-mail</span>
											</div>
											<div class="large-8 columns">
												<input id="email" name="email" type="text" disabled="disabled" value="<?php echo $osoba -> email; ?>">
											</div>
									</div>
					
				
					<a href="#" id="idiNaDrugiKorak" class="round button daljePrvi1">DALJE <i class="fi-arrow-right"></i></a>
					
					</fieldset>
					
					
					
					
					
							</div>
							
						
			<div class="large-4 columns" >
				<div class="panel panelDrugiKorak">2</div>
				
			<div id="drugiKorak" style="visibility: hidden;">
			
				
								<fieldset class="">
									<legend>
				Podaci o psu
			</legend>				
					<a href="#" class="button round dodajpsa" data-reveal-id="modalDodajPsa"><i class="fi-plus"></i> DODAJ PSA</a>								
				<div class="row collapse prefix-radius">
											<div class="large-4 columns">
												<span class="prefix">Pas</span>
											</div>
											<div class="large-8 columns">
										
							<select id="pas" name="pas">
							<option value="0"></option>
							
								
						<?php
						foreach ($pas as $pas) : ?>

						 <option value="<?php echo $pas -> sifra; ?>"><?php echo $pas -> ime; ?></option>

						<?php endforeach; ?>
					</select>
											</div>
										</div>





											<div class="row collapse prefix-radius">
											<div class="large-4 columns">
												<span class="prefix">Pasmina</span>
											</div>
											<div class="large-8 columns">
												<input type="text" id="pasmina" name="pasmina" disabled="disabled">
											</div>
										</div>
										
										
					<label for="napomena">Napomena</label>
					<textarea id="napomena" name="napomena"></textarea>
						</fieldset>
					
									
									
									
							
								
								
								
			<fieldset class="drugikorak" >
				<legend>
				Datum i termin
			</legend>
			<div class="row collapse prefix-radius">
											<div class="large-4 columns">
												<span class="prefix">Datum</span>
											</div>
											<div class="large-8 columns">
												<input type="text" id="datumnarudzbe" name="datumnarudzbe" title="Kalendar">
											</div>
										</div>
			
				<div class="row collapse prefix-radius">
											<div class="large-4 columns">
												<span class="prefix">Dan</span>
											</div>
											<div class="large-8 columns">
												<input type="text" id="dan" name="dan" disabled="disabled">
											</div>
										</div>
										
					<div class="row collapse prefix-radius">
											<div class="large-4 columns">
												<span class="prefix">Termin (h)</span>
											</div>
											<div class="large-8 columns">
												<select id="termin" name="termin">
													<option value = "0"></option>
		<?php
		$termini = array("07:00","07:30","08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00",
		"13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00");
		?>
		<?php foreach ($termini as $t): ?>
			<option><?php echo $t; ?></option>
		<?php endforeach ?>					
			</select>	
											</div>
										</div>
			
			
								
					
					
						
						<ul class="button-group round">
					<li><a href="#" id="idiNaPrviKorak" class="round button nazadDrugi"><i class="fi-arrow-left"></i> Nazad</a></li>
					<li><a href="#" id="idiNaTreciKorak" class="round button daljeDrugi">DALJE <i class="fi-arrow-right"></i></a></li>
					</ul>
							
							</div>	
							</div>
							
							
							
							
							
							
							<div class="large-4 columns" >
				<div class="panel panelTreciKorak">3</div>
				
			<div id="treciKorak" style="visibility: hidden;">
								<fieldset class="trecikorak">
				<legend>
				Odaberite uslugu/usluge
			</legend>
			
			<?php foreach ($usluga as $u): ?>
			
			<input id="usluga" type="checkbox" name="usluga[]" value="<?php echo $u->sifra; ?>"> <?php echo $u->naziv; ?><br>
			
			<?php endforeach; ?>
  			
  			
  				<ul class="button-group round">
  					
					<li><a href="#" id="idiNaDrugiKorak1" class="round button nazadTreci"><i class="fi-arrow-left"></i> Nazad</a></li>
					<li><a href="#" type="submit" class="round button naruci">Naruči <i class="fi-check"></i></a></li>
					</ul>
			
			</fieldset>	
			
			<input type="hidden" name="sifraKlijenta" value="<?php echo $osoba->sifraKlijenta;?>" />
			</form>
							</div>
							
							</div>
						</div>
					</div>
					
					<div class="content" id="panel2">
					
					<?php	
					
					$izraz = $veza -> prepare("select a.sifra,a.datumnarudzbe,a.termin,a.dan,a.status,a.napomena,a.datumunosa, b.ime as imePsa,c.naziv as nazivPasmine from narudzba a inner join pas b on a.pas=b.sifra inner join pasmina c on b.pasmina=c.sifra inner join klijent d on a.klijent=d.sifra where d.sifra=:sifraKlijenta order by a.sifra asc");
					$sifraKlijenta = $osoba -> sifraKlijenta;
					$izraz -> bindParam(":sifraKlijenta", $sifraKlijenta);
					$izraz -> execute();
					$narudzba = $izraz -> fetchAll(PDO::FETCH_OBJ);
					
					?>	
						
					<table class="reference" style="width:100%">
<tbody>
<tr>
	<th>Šifra</th>
	<th>Pas</th>
	<th>Pasmina</th>		
	<th>Datum</th>
	<th>Dan</th>
	<th>Termin(h)</th>
	<th>Datum narudžbe</th>
	<th>Status</th>
	<th>Opcije</th>

</tr>
<?php foreach ($narudzba as $n): ?>
					

<tr>
	<td><?php echo $n -> sifra; ?></td>
	<td><?php echo $n -> imePsa; ?></td>
	<td><?php echo $n -> nazivPasmine; ?></td>
		
	<?php $date = date_create($n -> datumnarudzbe); ?>	
	<td><?php echo date_format($date, 'd.m.Y.'); ?></td>		
	
	<td><?php echo $n -> dan; ?></td>
	<td><?php echo $n -> termin; ?></td>
	
	<?php $date = date_create($n -> datumunosa); ?>	
	<td><?php echo date_format($date, 'd.m.Y. H:i:s'); ?></td>
	
	<td><?php if ($n -> status == 0) { ?>
		
		<img src="<?php echo $putanjaApp; ?>img/proces.gif" alt=""/>
		 
		<?php } else { ?>
		 	
		 <img src="<?php echo $putanjaApp; ?>img/odradeno.png" alt=""/>
		 
		<?php }?></td>
	<td>
		

	
	
		<ul class="button-group radius even-2">
	<li><a href="modalDetalji.php?sifra=<?php echo $n->sifra; ?>"  title="Pogledaj detalje"><i id="<?php echo $n->sifra; ?>" class="fi-zoom-in detalji"></i></a></li>
  	<li><a href="obrisiNarudzbu.php?sifra=<?php echo $n->sifra; ?>" data-reveal-id="myModal" class="obrisi" title="Obriši"><i class="fi-x"></i></a></li>
  
</ul>

</td>
</tr>

<?php endforeach; ?>
</tbody>
</table>
						
						
						
						
					
						
						
						
						
						
					</div>

				</div>

			</div>
		</div>
		
		<?php include_once 'modalDodajPsa.php'; ?>
		
		<?php include_once 'modalObrisiNarudzbu.php'; ?>
		
		<?php include_once 'modalDetalji.php'; ?>
		
	    <?php include_once 'privatno/narudzbe/modalNarudzba.php'; ?>
		
		

		<?php
		include_once 'podnozje.php';
		?>

		<?php
		include_once 'skripte.php';
		?>
	
		<script src="<?php echo $putanjaApp; ?>js/vendor/jquery-ui.js"></script>
		
		
		<script>
		
		$('#dodajPsa').click(function(event) {
					
				event.preventDefault();
					
				var klijent = <?php echo $sifraKlijenta; ?>;	
				var forma = $("#myform1");
				var podaci = forma.serialize();
				var url = forma.attr('action');

					$.ajax({
						type : "POST",
						url : url,
						data : podaci+"&klijent="+klijent,
						cache : false,
						success : function(data) {

							if (data == "OK") {
								
											$.ajax({
						type : "GET",
						url : "privatno/narudzbe/json.php",
						data : "sifraKlijenta="+klijent,
						cache : false,
						success: function(vraceniJson) {					
					   	 
					   	 var select = $("#pas");

					    if(vraceniJson=="FALSE"){
					    
					    	select.empty();
					    }
					    				    
					    var nizObjekata = jQuery.parseJSON(vraceniJson);
					   
					    $.each(nizObjekata, function( index, value ) {
  						
  						select.empty();
  						
  						select
       				  .append($("<option>")
        			 .attr("value",0)
         			.text(""));
  						
  						 $.each(value.pas, function( i, pas ) {
  						 select
       				  .append($("<option>")
        			 .attr("value",pas.sifra)
         			.text(pas.ime));
     			
						});
  						
							});
    
       					 }
				});

								$("#modalDodajPsa").foundation('reveal','close');

							}

						}
					});
					
				

					
				});

				
		$('#pas').on('change', function(e) {
			
 		var sifraPsa = $(this).val();
  		
 		$.ajax({
					type : "GET",
						url : "privatno/narudzbe/json1.php",
						data : "sifraPsa="+sifraPsa,
						cache : false,
						success: function(vraceniJson) {
					    					    
					    var pasmina = $("#pasmina");
					    
					     if(vraceniJson=="FALSE"){
					    	pasmina.val("");					    	
					   }
					
					 var nizObjekata = jQuery.parseJSON(vraceniJson);
					 	 
			    $.each(nizObjekata, function( index, value ) {
					    	
					   	pasmina.val(value.naziv);

							});
    
       					 }
				});
				
		});
		
		
		
					$(document).foundation();  
	$('a.obrisi').click(function(){
    var link = $('.deleteUrl');
    $(link).attr('href', this.href);
    
 	
});

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


		$(function() {

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
				$("#datumnarudzbe").datepicker({ minDate: 0 });
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
					$('#pas').tooltipster('hide');
					$('#termin').tooltipster('hide');
					$('#usluga').tooltipster('hide');

				});

				$('#idiNaDrugiKorak').click(function(event) {

					event.preventDefault();
					
					$(".panelDrugiKorak").css('display','none');					
					$(".ui-progressbar-value").animate({width:"66%"});
					$("#drugiKorak").css({opacity: 0.0, visibility: "visible"}).animate({opacity: 1.0}, 1500);
					$('#prviKorak').css({opacity: 1.0, visibility: "visible"}).animate({opacity: 0}, 1500);
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
					
						$('#pas').tooltipster({
					position : 'right',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});
				
						$('#termin').tooltipster({
					position : 'right',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});
					
					// PROVJERA PSA
					
					var pas = $('#pas').val();
				//	alert(datumNarudzbe);

					if (pas == 0) {

						$('#pas').tooltipster('content', 'Niste odabrali psa.');
						$('#pas').tooltipster('show');
						return false;
					}
					
					
						// PROVJERA DATUMA NARUDŽBE
					
					var datumNarudzbe = $('#datumnarudzbe').val();
				//	alert(datumNarudzbe);

					if (datumNarudzbe.length == 0) {

						$('#datumnarudzbe').tooltipster('content', 'Ovo polje je obavezno.');
						$('#datumnarudzbe').tooltipster('show');
						return false;
					}
					
					
									// PROVJERA TERMINA
					
					var termin = $('#termin').val();
				//	alert(datumNarudzbe);

					if (termin == 0) {

						$('#termin').tooltipster('content', 'Niste odabrali termin.');
						$('#termin').tooltipster('show');
						return false;
					}
					
					$(".ui-progressbar-value").animate({width:"100%"});
					$("#treciKorak").css({opacity: 0.0, visibility: "visible"}).animate({opacity: 1.0}, 1500);
					$('#drugiKorak').css({opacity: 1.0, visibility: "visible"}).animate({opacity: 0}, 1500);
					$(".panelDrugiKorak").css('display','block');
					$(".panelTreciKorak").css('display','none');
					
			
				

				});
				
				$('#idiNaPrviKorak').click(function(event) {
					
					event.preventDefault();
					
					$(".ui-progressbar-value").animate({width:"31.5%"});
					$('#prviKorak').css({opacity: 0.0, visibility: "visible"}).animate({opacity: 1.0}, 1500);
					$('#drugiKorak').css({opacity: 1.0, visibility: "visible"}).animate({opacity: 0}, 1500);
					$(".panelDrugiKorak").css('display','block');
					$(".panelPrviKorak").css('display','none');
					
				

				});
				
				$('#idiNaDrugiKorak1').click(function(event) {

					event.preventDefault();
					$(".panelDrugiKorak").css('display','none');
					$('#drugiKorak').css({opacity: 0.0, visibility: "visible"}).animate({opacity: 1.0}, 1500);
					$(".panelTreciKorak").css('display','block');										
					$("#treciKorak").css({opacity: 1.0, visibility: "visible"}).animate({opacity: 0.0}, 1500);
					$(".ui-progressbar-value").animate({width:"66%"});
					
					
				
				

				});
				
				
				
				$('.naruci').click(function(event) {

					event.preventDefault();
					
					$('#usluga').tooltipster({
					position : 'right',
					offsetX : '265px',
					offsetY : '-19px',
					trigger : 'custom'

				});
					
					if($("#usluga").prop('checked') == false){
						
						$('#usluga').tooltipster('content', 'Odaberite barem jednu uslugu.');
						$('#usluga').tooltipster('show');
						return false;
    
					}
					
				
					
					var forma = $("#myform");
					var podaci = forma.serialize();
					var url = forma.attr('action');
					var dan = $("#dan").val();
					//alert(podaci+" "+url+" "+forma);

					$.ajax({
						type : "POST",
						url : url,
						data : podaci+"&dan="+dan,
						cache : false,
						success : function(data) {

							if (data == "OK") {

								$("#modalNarudzba").foundation('reveal','open');
							}

						}
					});
					

				

				});
				
				
			

			});

		</script>
		
		
		
	</body>

</html>
