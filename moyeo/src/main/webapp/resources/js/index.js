$(".close").click(function(){
	$('.outside').toggleClass('in');
	$('.bar').toggleClass('active');
	$(this).toggleClass('is-showing');
	// z-index toggle logic
	var mapElement = $('#map');
	var currentZIndex = mapElement.css('z-index');
	if (currentZIndex == 0) mapElement.css('z-index', -1);
	else mapElement.css('z-index', 0);
});
