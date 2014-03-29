var ready = function(){
	$("#submit_reference").removeAttr("disabled");
	manage_attribute_form();
	$("#reference_ref_type").change(function(){
		manage_attribute_form();
	});
}
$(document).ready(ready);
$(document).on('page:load', ready);
function manage_attribute_form(){
	var type = $("#reference_ref_type").find(":selected").text();
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
	};
	actions[type]();
}