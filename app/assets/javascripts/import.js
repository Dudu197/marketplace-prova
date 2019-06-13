// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require_tree .

function toggle(){
	$(".btn-import").toggle();
	$(".spinner").toggle();
}

$(document).ready(function(){
	$(".btn-import").click(function(){
		let de = parseFloat($("#de").val());
		let ate = parseFloat($("#ate").val());
		if(de > ate){
			$("#de").val(ate);
			$("#ate").val(de);
			de = parseFloat($("#de").val());
			ate = parseFloat($("#ate").val());
		}
		if(isNaN(de) || isNaN(ate)){
			alert("Preencha todos os campos");
			return;
		}
		if((ate - (de === 0 ? -1 : de)) > 50){
			alert("Escolha um intervalo de até 50 itens");
			return;
		}
		toggle();
		$.post( "/admin/import", {de: de, ate: ate}, function( data ) {
			if(data.status === "ok"){
				alert("Produtos importados");
				document.location.reload();
			}else{
				toggle();
				alert("erro");
			}
		}).fail(function(){
			toggle();
			alert("erro");
		});
	});
});