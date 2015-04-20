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
	<style>
		.CSSTableGenerator {
			margin: 0px;
			padding: 0px;
			width: 100%;
			border: 0px solid #000000;
			-moz-border-radius-bottomleft: 10px;
			-webkit-border-bottom-left-radius: 10px;
			border-bottom-left-radius: 10px;
			-moz-border-radius-bottomright: 10px;
			-webkit-border-bottom-right-radius: 10px;
			border-bottom-right-radius: 10px;
			-moz-border-radius-topright: 10px;
			-webkit-border-top-right-radius: 10px;
			border-top-right-radius: 10px;
			-moz-border-radius-topleft: 10px;
			-webkit-border-top-left-radius: 10px;
			border-top-left-radius: 10px;
		}
		.CSSTableGenerator table {

			border: none;
			border-spacing: 5;
			width: 100%;
			height: 100%;
			margin: 0px;
			padding: 0px;
		}
		.CSSTableGenerator tr:last-child td:last-child {
			-moz-border-radius-bottomright: 10px;
			-webkit-border-bottom-right-radius: 10px;
			border-bottom-right-radius: 10px;
		}
		.CSSTableGenerator table tr:first-child td:first-child {
			-moz-border-radius-topleft: 10px;
			-webkit-border-top-left-radius: 10px;
			border-top-left-radius: 10px;
		}
		.CSSTableGenerator table tr:first-child td:last-child {
			-moz-border-radius-topright: 10px;
			-webkit-border-top-right-radius: 10px;
			border-top-right-radius: 10px;
		}
		.CSSTableGenerator tr:last-child td:first-child {
			-moz-border-radius-bottomleft: 10px;
			-webkit-border-bottom-left-radius: 10px;
			border-bottom-left-radius: 10px;
		}

		.CSSTableGenerator tr .sisanje, .CSSTableGenerator tr .sisanjeiliizbrijavanje, .CSSTableGenerator tr .kupanjeicesljanje, .CSSTableGenerator tr .rezanjenoktiju {
			width: 120px;
			vertical-align: middle;
			background: -o-linear-gradient(bottom, #83A738 5%, #ABCD63 ABCD63%);
			background: -webkit-gradient( linear, left top, left bottom, color-stop(0.05, #83A738), color-stop(1, #ABCD63) );
			background: -moz-linear-gradient( center top, #83A738 5%, #ABCD63 100% );
			filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#83A738", endColorstr="#ABCD63");
			background: -o-linear-gradient(top,#83A738,ABCD63);
			border: 0px solid #000000;
			border-width: 0px 0px 0px 0px;
			text-align: center;
			padding: 10px;
			font-size: 14px;
			font-family: Arial;
			font-weight: bold;
			color: white;
			text-shadow: 1px 1px #000000;
		}

		.CSSTableGenerator tr .sisanjeikupanje, .CSSTableGenerator tr .sisanjeikupanje1, .CSSTableGenerator tr .cesljanje, .CSSTableGenerator tr .brijanjesapica {

			vertical-align: middle;
			background: -o-linear-gradient(bottom, #3F5D02 5%, #638619 100%);
			background: -webkit-gradient( linear, left top, left bottom, color-stop(0.05, #3F5D02), color-stop(1, #638619) );
			background: -moz-linear-gradient( center top, #3F5D02 5%, #638619 100% );
			filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#3F5D02", endColorstr="#638619");
			background: -o-linear-gradient(top,#3F5D02,638619);
			border: 0px solid #000000;
			border-width: 0px 0px 0px 0px;
			text-align: center;
			padding: 10px;
			font-size: 14px;
			font-family: Arial;
			font-weight: bold;
			color: white;
			text-shadow: 1px 1px #000000;
		}

		.CSSTableGenerator tr .usluga, .CSSTableGenerator tr .cijena {
			background: -o-linear-gradient(bottom, #5b2c77 5%, #784b92 100%);
			background: -webkit-gradient( linear, left top, left bottom, color-stop(0.05, #5b2c77), color-stop(1, #784b92) );
			background: -moz-linear-gradient( center top, #5b2c77 5%, #784b92 100% );
			filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#5b2c77", endColorstr="#784b92");
			background: -o-linear-gradient(top,#5b2c77,784b92);
			border: 0px solid #000000;
			border-width: 0px 0px 0px 0px;
			text-align: center;
			padding: 20px;
			font-size: 14px;
			font-family: Arial;
			font-weight: bold;
			color: white;
			text-shadow: 1px 1px #000000;
		}

		.CSSTableGenerator tr .psitezine {
			background: -o-linear-gradient(bottom, #5b2c77 5%, #784b92 100%);
			background: -webkit-gradient( linear, left top, left bottom, color-stop(0.05, #5b2c77), color-stop(1, #784b92) );
			background: -moz-linear-gradient( center top, #5b2c77 5%, #784b92 100% );
			filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#5b2c77", endColorstr="#784b92");
			background: -o-linear-gradient(top,#5b2c77,784b92);
			border: 0px solid #000000;
			border-width: 0px 0px 0px 0px;
			text-align: left;
			padding: 10px;
			font-size: 14px;
			font-family: Arial;
			font-weight: bold;
			color: white;
			text-shadow: 1px 1px #000000;
		}

	</style>
	<body>

		<?php
		include_once 'zaglavlje.php';
		?>

		<?php
		include_once 'navigacija.php';
		?>

		<div class="row">
			<div class="large-12 columns">
				<h4><i class="fi-clipboard-notes"> </i>Cjenik</h4>
				<hr />

				<div class="CSSTableGenerator" >
					<table >
						<tr>
							<td colspan="10" class="usluga"> USLUGA </td>
							<td colspan="2" class="cijena"> CIJENA</td>

						</tr>
						<tr>
							<td colspan="12" class="psitezine"> PSI TEŽINE DO 10KG </td>
						</tr>
						<tr>
							<td colspan="2" class="sisanje"> ŠIŠANJE </td>
							<td colspan="8" class="sisanje"> pasa održavane dlake </td>
							<td colspan="2" class="sisanje"> 80-150 kn </td>
						</tr>
						<tr>
							<td colspan="2" class="sisanjeikupanje"> ŠIŠANJE I KUPANJE </td>
							<td colspan="8" class="sisanjeikupanje"> pasa održavane dlake </td>
							<td colspan="2" class="sisanjeikupanje"> 100-180 kn </td>
						</tr>
						<tr>
							<td colspan="2" class="sisanjeiliizbrijavanje"> ŠIŠANJE ILI IZBRIJAVANJE </td>
							<td colspan="8" class="sisanjeiliizbrijavanje"> pasa neodržavane, duge, zapetljane dlake </td>
							<td colspan="2" class="sisanjeiliizbrijavanje"> 130-220 kn </td>
						</tr>
						<tr>
							<td colspan="2" class="sisanjeikupanje1"> ŠIŠANJE I KUPANJE </td>
							<td colspan="8" class="sisanjeikupanje1"> pasa neodržavane, duge, zapetljane dlake </td>
							<td colspan="2" class="sisanjeikupanje1"> 150-250 kn </td>
						</tr>
						<tr>
							<td colspan="2" class="kupanjeicesljanje"> KUPANJE I ČEŠLJANJE </td>
							<td colspan="8" class="kupanjeicesljanje"> pasa ovisno o dužini i stanju dlake </td>
							<td colspan="2" class="kupanjeicesljanje"> 60-180 kn </td>
						</tr>
						<tr>
							<td colspan="2" class="cesljanje"> ČEŠLJANJE </td>
							<td colspan="8" class="cesljanje"> pasa ovisno o dlaci </td>
							<td colspan="2" class="cesljanje"> 60-100 kn / sat </td>
						</tr>
						<tr>
							<td colspan="2" class="rezanjenoktiju"> REZANJE NOKTIJU </td>
							<td colspan="8" class="rezanjenoktiju"></td>
							<td colspan="2" class="rezanjenoktiju"> do 30 kn </td>
						</tr>
						<tr>
							<td colspan="2" class="brijanjesapica"> BRIJANJE ŠAPICA </td>
							<td colspan="8" class="brijanjesapica"></td>
							<td colspan="2" class="brijanjesapica"> do 40 kn </td>
						</tr>
						<tr>
							<td colspan="12" class="psitezine"> PSI TEŽINE OD 10-23 KG </td>
						</tr>
						<tr>
							<td colspan="2" class="sisanje"> ŠIŠANJE </td>
							<td colspan="8" class="sisanje"> pasa održavane dlake </td>
							<td colspan="2" class="sisanje"> 100-180 kn </td>
						</tr>
						<tr>
							<td colspan="2" class="sisanjeikupanje"> ŠIŠANJE I KUPANJE </td>
							<td colspan="8" class="sisanjeikupanje"> pasa održavane dlake </td>
							<td colspan="2" class="sisanjeikupanje"> 150-200 kn </td>
						</tr>
						<tr>
							<td colspan="2" class="sisanjeiliizbrijavanje"> ŠIŠANJE ILI IZBRIJAVANJE </td>
							<td colspan="8" class="sisanjeiliizbrijavanje"> pasa neodržavane, duge, zapetljane dlake </td>
							<td colspan="2" class="sisanjeiliizbrijavanje"> 150-250 kn </td>
						</tr>
						<tr>
							<td colspan="2" class="sisanjeikupanje1"> ŠIŠANJE I KUPANJE </td>
							<td colspan="8" class="sisanjeikupanje1"> pasa neodržavane, duge, zapetljane dlake </td>
							<td colspan="2" class="sisanjeikupanje1"> 180-300 kn </td>
						</tr>
						<tr>
							<td colspan="2" class="kupanjeicesljanje"> KUPANJE I ČEŠLJANJE </td>
							<td colspan="8" class="kupanjeicesljanje"> pasa ovisno o dužini i stanju dlake </td>
							<td colspan="2" class="kupanjeicesljanje"> 100-200 kn </td>
						</tr>
						<tr>
							<td colspan="2" class="cesljanje"> ČEŠLJANJE </td>
							<td colspan="8" class="cesljanje"> pasa ovisno o dlaci </td>
							<td colspan="2" class="cesljanje"> 80-120 kn / sat </td>
						</tr>
						<tr>
							<td colspan="2" class="rezanjenoktiju"> REZANJE NOKTIJU </td>
							<td colspan="8" class="rezanjenoktiju"></td>
							<td colspan="2" class="rezanjenoktiju"> do 50 kn </td>
						</tr>
						<tr>
							<td colspan="2" class="brijanjesapica"> BRIJANJE ŠAPICA </td>
							<td colspan="8" class="brijanjesapica"></td>
							<td colspan="2" class="brijanjesapica"> do 60 kn </td>
						</tr>

					</table>
				</div>
				<hr />
				<p>
					U navedenim cijenama je uračunat PDV.
					<br />
					U salonu se mogu šišati i kupati psi do cca. 23kg težine.
					<br />
					<b>Za novoudomljene pse iz osječkog Azila</b> prvi tretman je besplatan. Slijedeći tretmani za takve a i za ranije udomljene pse imaju popust od 50% na uslugu šišanja.
					Potrebno je priložiti kopiju Ugovora o udomljenju.
				</p>
			</div>

		</div>

		<?php
		include_once 'podnozje.php';
		?>

		<?php
		include_once 'skripte.php';
		?>
	</body>
</html>
