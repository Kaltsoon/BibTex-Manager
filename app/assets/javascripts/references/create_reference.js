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
	}

	var display_generated_id = function(){
		var attributes = {}
		$("#attributes_form input[type=text]").each(function(index, field){
			var field_name = $(field).attr("name");
			var attribute_name = field_name.substring(field_name.indexOf("[")+1, field_name.length-1)
			attributes[attribute_name] = $(field).val();
		});
	}

	var fetch_generated_id = function(attributes){
		
	}

	return {
		display_fields: display_fields,
		display_generated_id: display_generated_id
	}
})();

$(document).on("page:load ready",function(){
	REFERENCE_CREATE_MODULE.display_fields();
	REFERENCE_CREATE_MODULE.display_generated_id();
	$("#reference_ref_type").change(function(){
		REFERENCE_CREATE_MODULE.display_fields();
	});
	$("#attributes_form input[type=text]").keyup(function(){
		REFERENCE_CREATE_MODULE.display_generated_id();
	});
});
