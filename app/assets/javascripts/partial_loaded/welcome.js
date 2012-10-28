function slideSwitch() {
    var $active = $('#diashow IMG.active');

    if ( $active.length == 0 ) $active = $('#diashow IMG:last');

    // use this to pull the divs in the order they appear in the markup
    var $next =  $active.next().length ? $active.next() : $('#diashow IMG:first');

    $active.addClass('last-active');

    $next.css({opacity: 0.0})
        .addClass('active')
        .animate({opacity: 1.0}, 3000, function() {
            $active.removeClass('active last-active');
        });
}

$(function() {
    setInterval( "slideSwitch()", 8000 );
});
