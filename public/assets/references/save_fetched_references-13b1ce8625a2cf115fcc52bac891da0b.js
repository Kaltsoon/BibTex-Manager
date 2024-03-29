$(document).on("ready", function(){
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
	$("input#select").on("click", function(){
		if(!$(this).is(":checked")){
			$(".reference-info-input").attr("disabled", "disabled");
		}else{
			$(".reference-info-input").removeAttr("disabled");
		}
	});
});
