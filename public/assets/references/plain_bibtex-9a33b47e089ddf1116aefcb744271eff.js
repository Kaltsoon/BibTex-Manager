$(document).ready(function(){
	var clientTarget = new ZeroClipboard( $("#copy-to-clipboard"), {
      moviePath: "http://www.paulund.co.uk/playground/demo/zeroclipboard-demo/zeroclipboard/ZeroClipboard.swf",
      debug: false
    });
    clientTarget.on("load", function(clientTarget){
        clientTarget.on("complete", function(clientTarget, args) {
            clientTarget.setText( args.text );
        });
    });
    $("#global-zeroclipboard-html-bridge").on("click",function(){
    	$("#copy-to-clipboard").popover("show");
    })
})
;
