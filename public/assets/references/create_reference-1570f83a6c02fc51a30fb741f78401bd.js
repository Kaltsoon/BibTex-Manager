var REFERENCE_CREATE_MODULE = (function(){

	var display_fields = function(){
		var type = $("#reference_ref_type").find(":selected").text();
		if(type){
			var actions = {
				book: function(){
					$("#attributes_form").html($("#book_attributes_form").html());
				},
				article: function(){
					$("#attributes_form").html($("#article_attributes_form").html());
				},
				inproceedings: function(){
					$("#attributes_form").html($("#inproceedings_attributes_form").html());
				}
			}
			actions[type]();
		}
		$("#attributes_form input[type=text]").on("keyup", function(){
			display_generated_id();
		});
	}

	var display_generated_id = function(){
		var attributes = {}
		$("#attributes_form input[type=text]").each(function(index, field){
			if($(field).val() != ""){
				var field_name = $(field).attr("name");
				var attribute_name = field_name.substring(field_name.indexOf("[")+1, field_name.length-1);
				attributes[attribute_name] = $(field).val();
			}
		});
		fetch_generated_id(attributes);
	}

	var fetch_generated_id = function(attributes){
		if(!$("#disable-generation").is(":checked")){
			$.post("/generate_id_for_reference", { attributes: attributes }).done(function(data){
				$("#reference_name").val(data.generated_id);
			});
		}
	}

	return {
		display_fields: display_fields,
		display_generated_id: display_generated_id
	}
})();

$(document).on("ready",function(){
	REFERENCE_CREATE_MODULE.display_fields();
	$("#reference_ref_type").on("change", function(){
		REFERENCE_CREATE_MODULE.display_fields();
	});
	$("#attributes_form input[type=text]").on("keyup", function(){
		REFERENCE_CREATE_MODULE.display_generated_id();
	});
	$("#disable-generation").on("click", function(){
		if($(this).is(":checked")){
			$("#auto-generate-help").fadeOut();
		}else{
			$("#auto-generate-help").fadeIn();
		}
	});
});
