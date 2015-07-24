Blacklight.onLoad(function () {
    /*
     *  Customizing color range for GW Libraries
     */
    $(".tagcloud").blacklightTagCloud({
        size: {start: 0.9, end: 2.5, unit: 'em'},
        cssHooks: {granularity: 15},
        color: {start: '#004165', end: '#2971a7'}
    });


});
