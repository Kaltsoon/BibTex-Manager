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
	return {
		display_fields: display_fields
	}
})();

$(document).on("page:load ready",function(){
	REFERENCE_CREATE_MODULE.display_fields();
	$("#reference_ref_type").change(function(){
		REFERENCE_CREATE_MODULE.display_fields();
	});
});
