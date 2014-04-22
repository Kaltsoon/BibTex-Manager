var FILTER_MODULE = 
(function(){
	var matches_name = function(keyword, name){
		return name.toLowerCase().indexOf(keyword.toLowerCase())>=0;
	}

	var matches_type = function(keyword, type){
		return type.toLowerCase().indexOf(keyword.toLowerCase())>=0;
	}

	var matches_attributes = function(keyword, attributes){
		for(var i=0; i<attributes.length; i++){
			attribute = attributes[i];
			if(attribute.value.toLowerCase().indexOf(keyword.toLowerCase())>=0){
				return true;
			}
		}
		return false;
	}

	var matches_single = function(keyword, reference){
		return (matches_attributes(keyword, reference.reference_attributes) || matches_type(keyword, reference.ref_type) || matches_name(keyword, reference.name));
	}


	var matches_multiple = function(keywords, reference){
		for(var i=0; i<keywords.length; i++){
			word = keywords[i].replace(/'/g,"");
			if(!matches_single(word, reference)){
				return false;
			}
		}
		return true;
	}

	var matches = function(keyword, reference){
		if(keyword.toLowerCase().indexOf("' and '")>=0){
			keywords = keyword.toLowerCase().split("' and '");
			return matches_multiple(keywords, reference);
		}else{
			return matches_single(keyword.replace(/'/g,""), reference);
		}
	}

	return {
		matches: matches,
	}
})();

var REFERENCE_LIST_MODULE = 
(function(filter_module){
	var references_all = [];
	var references = [];
	var fetch = function(callback){
		$.getJSON( "/references.json", function(data) {
			references_all = data;
			references = references_all;
			callback();
		});
	}

	var filter = function(){
		var keyword = $("#filter-keyword").val().toLowerCase();
		references = [];
		if(keyword){
			for(var i=0; i<references_all.length; i++){
				ref = references_all[i];
				if(filter_module.matches(keyword, ref)){
					references.push(ref);
				}
			}
		}else{
			references = references_all;
		}
		render();
	}

	var bind_popovers = function(){
		$(".reference-attributes-popover").popover({ trigger: "manual", html: true})
	    .on("mouseenter", function () {
	        var _this = this;
	        $(this).popover("show");
	        $(".popover").on("mouseleave", function () {
	            $(_this).popover('hide');
	        });
	    }).on("mouseleave", function () {
	        var _this = this;
	        setTimeout(function () {
	            if (!$(".popover:hover").length) {
	                $(_this).popover("hide")
	            }
	        }, 100);
	    });
		$(".reference-bibtex-popover").popover({ trigger: "manual", html: true }).
		on("mouseenter", function () {
	        var _this = this;
	        $(this).popover("show");
	        $(".popover").on("mouseleave", function () {
	            $(_this).popover('hide');
	        });
	    }).on("mouseleave", function () {
	        var _this = this;
	        setTimeout(function () {
	            if (!$(".popover:hover").length) {
	                $(_this).popover("hide")
	            }
	        }, 100);
	    });
		$("a[rel=popover]").on("mouseover",function(){
			$("a[rel=popover]").not(this).popover("hide");
		});
	}

	var string_summary = function(str, max_len){
		if(str.length <= max_len){
			return str;
		}else{
			return (str.substring(0,max_len)+"...")
		}
	}

	var render = function(){
		$("#download-filtered-references").removeAttr("disabled");
		if(references.length==0){
			$("#download-filtered-references").attr("disabled", "disabled");
		}
		references.forEach(function(reference){
			attributes=[];
			reference.reference_attributes.forEach(function(attr){
				if(attr.name=="author" || attr.name == "editor"){
					attributes[0] = string_summary(attr.value,25);
				}else if(attr.name=="title"){
					attributes[1] = string_summary(attr.value,25);
				}else if(attr.name=="year"){
					attributes[2] = string_summary(attr.value,25);
				}
			});
			reference.name_summary = string_summary(reference.name, 25);
			reference.displayed_attributes = attributes;
		});
		$("#reference-list").html(Mustache.to_html($("#reference-row-template").html(), { references: references }));
		bind_popovers();
	}

	var list = function(){
		fetch(render);
	}

	return {
		list: list,
		filter: filter
	}

})(FILTER_MODULE);

$(document).on("ready",function(){
	REFERENCE_LIST_MODULE.list();
	$("#filter-keyword").keyup(function(){
		REFERENCE_LIST_MODULE.filter();
	});
});