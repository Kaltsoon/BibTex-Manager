var REFERENCE_LIST_MODULE = 
(function(){
	var references_all = [];
	var references = [];
	var fetch = function(callback){
		$.getJSON( "references.json", function(data) {
			references_all = data;
			references = references_all;
			callback();
		});
	}
	var filter = function(){
		var keyword = $("#filter-keyword").val().toLowerCase();
		references = [];
		if(keyword){
			references_all.forEach(function(ref){
				if(ref.name.toLowerCase().indexOf(keyword)>=0 || ref.ref_type.toLowerCase().indexOf(keyword)>=0){
					references.push(ref);
				}else{
					ref.reference_attributes.forEach(function(attribute){
						if(attribute.value.toLowerCase().indexOf(keyword)>=0){
							references.push(ref);
						}
					});
				}
			});
		}else{
			references = references_all;
		}
		render();
	}
	var render = function(){
		$("#reference-list").html(Mustache.to_html($("#reference-row-template").html(), { references: references }));
		$(".reference-attributes-popover").popover();
		$(".reference-bibtex-popover").popover();
		$("a[rel=popover]").on("click",function(){
			$("a[rel=popover]").not(this).popover("hide");
		});
	}
	var list = function(){
		fetch(render);
	}
	return {
		list: list,
		filter: filter
	}
})();
$(document).on("page:load ready",function(){
	REFERENCE_LIST_MODULE.list();
	$("#filter-keyword").keyup(function(){
		REFERENCE_LIST_MODULE.filter();
	});
});