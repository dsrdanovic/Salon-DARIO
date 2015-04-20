<script>
	$(document).ready(function() {
		$("#ki").hide();
		$("#l").hide();

		$("#prijavitese").click(function() {

			$("#ki").html("");
			$("#ki").hide();
			$("#l").html("");
			$("#l").hide();

			if ($("#korisnickoime").val().trim().length == 0) {

				$("#ki").html("Niste unijeli korisničko ime");
				$("#ki").show();
				$("#ki").focus();
				return false;
			}

			if ($("#lozinka").val().trim().length == 0) {

				$("#l").html("Niste unijeli lozinku");
				$("#l").show();
				$("#l").focus();
				return false;
			}

			return true;
		});

	}); 
</script>