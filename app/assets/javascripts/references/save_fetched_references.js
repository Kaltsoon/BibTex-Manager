$(document).on("ready", function(){
	$("input#select").on("click", function(){
		if(!$(this).is(":checked")){
			$(".reference-info-input").attr("disabled", "disabled");
		}else{
			$(".reference-info-input").removeAttr("disabled");
		}
	});
});